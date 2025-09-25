#include "first.h"

#include "fdevent_impl.h"
#include "fdevent.h"
#include "buffer.h"
#include "log.h"

#include <stdlib.h>
#include <errno.h>

// inlining_added
extern int fdevent_linux_sysepoll_event_del (fdevents *ev, fdnode *fdn);
extern int fdevent_poll_event_del (fdevents *ev, fdnode *fdn);
// extern int fdevent_select_event_del (fdevents *ev, fdnode *fdn);

// inlining_added
static inline int
event_del_dispatch(fdevents *ev, fdnode *fdn)
{
    /* 함수 포인터 주소를 직접 비교해서 해당 함수를 직접 호출 */
    if (ev->event_del == fdevent_linux_sysepoll_event_del) {
        return fdevent_linux_sysepoll_event_del(ev, fdn);
    }
    else if (ev->event_del == fdevent_poll_event_del) {
        return fdevent_poll_event_del(ev, fdn);
    }
    // else if (ev->event_del == fdevent_select_event_del) {
    //     return fdevent_select_event_del(ev, fdn);
    // }
}

// inlining_added
// int fdevent_linux_sysepoll_event_set(fdevents *ev, fdnode *fdn, int events);
int fdevent_freebsd_kqueue_event_set(fdevents *ev, fdnode *fdn, int events);
int fdevent_solaris_port_event_set(fdevents *ev, fdnode *fdn, int events);
int fdevent_solaris_devpoll_event_set(fdevents *ev, fdnode *fdn, int events);
// int fdevent_poll_event_set(fdevents *ev, fdnode *fdn, int events);
int fdevent_select_event_set(fdevents *ev, fdnode *fdn, int events);

// 최적화된 event_set 디스패처 함수 (조건부 컴파일 적용)
static int
event_set_dispatch(fdevents *ev, fdnode *fdn, int events)
{
    /* 플랫폼별로 확실히 존재하는 함수들만 최적화 */
// #ifdef FDEVENT_USE_LINUX_EPOLL
//     if (ev->event_set == fdevent_linux_sysepoll_event_set) {
//         return fdevent_linux_sysepoll_event_set(ev, fdn, events);
//     }
// #endif
#ifdef FDEVENT_USE_FREEBSD_KQUEUE
    if (ev->event_set == fdevent_freebsd_kqueue_event_set) {
        return fdevent_freebsd_kqueue_event_set(ev, fdn, events);
    }
#endif
#ifdef FDEVENT_USE_SOLARIS_PORT
    if (ev->event_set == fdevent_solaris_port_event_set) {
        return fdevent_solaris_port_event_set(ev, fdn, events);
    }
#endif
#ifdef FDEVENT_USE_SOLARIS_DEVPOLL
    if (ev->event_set == fdevent_solaris_devpoll_event_set) {
        return fdevent_solaris_devpoll_event_set(ev, fdn, events);
    }
#endif
// #ifdef FDEVENT_USE_POLL
//     if (ev->event_set == fdevent_poll_event_set) {
//         return fdevent_poll_event_set(ev, fdn, events);
//     }
// #endif
#ifdef FDEVENT_USE_SELECT
    if (ev->event_set == fdevent_select_event_set) {
        return fdevent_select_event_set(ev, fdn, events);
    }
#endif
}

__attribute_malloc__
__attribute_returns_nonnull__
static fdnode *
fdnode_init (void)
{
    return ck_calloc(1, sizeof(fdnode));
}

static void
fdnode_free (fdnode *fdn)
{
    free(fdn);
}

fdnode *
fdevent_register (fdevents *ev, int fd, fdevent_handler handler, void *ctx)
{
  #ifdef _WIN32
    fdnode *fdn  = fdnode_init();
    ev->fdarray[(fdn->fda_ndx = ev->count++)] = fdn;
  #else
    fdnode *fdn  = ev->fdarray[fd] = fdnode_init();
  #endif
    fdn->handler = handler;
    fdn->fd      = fd;
    fdn->ctx     = ctx;
    fdn->events  = 0;
    fdn->fde_ndx = -1;
    return fdn;
}

#ifdef _WIN32
#define fdevent_fdarray_slot(ev,fdn) &(ev)->fdarray[(fdn)->fda_ndx]
#else
#define fdevent_fdarray_slot(ev,fdn) &(ev)->fdarray[(fdn)->fd]
#endif

void
fdevent_unregister (fdevents *ev, fdnode *fdn)
{
    fdnode **fdn_slot = fdevent_fdarray_slot(ev, fdn);
    if ((uintptr_t)*fdn_slot & 0x3) return; /*(should not happen)*/
  #ifdef _WIN32
    if (--ev->count != fdn->fda_ndx) {
        /* compact fdarray; move element in last slot */
        fdnode **fdn_last = &ev->fdarray[ev->count];
        *fdn_slot = *fdn_last;
        ((fdnode *)((uintptr_t)*fdn_slot & ~0x3))->fda_ndx = fdn->fda_ndx;
        fdn_slot = fdn_last;
    }
  #endif
    *fdn_slot = NULL;
    fdnode_free(fdn);
}

void
fdevent_sched_close (fdevents *ev, fdnode *fdn)
{
    fdnode **fdn_slot = fdevent_fdarray_slot(ev, fdn);
    if ((uintptr_t)*fdn_slot & 0x3) return;
    *fdn_slot = (fdnode *)((uintptr_t)fdn | 0x3);
    fdn->handler = (fdevent_handler)NULL;
    fdn->ctx = ev->pendclose;
    ev->pendclose = fdn;
}

__attribute_cold__
__attribute_noinline__
static int
fdevent_fdnode_event_unsetter_retry (fdevents *ev, fdnode *fdn)
{
    do {
        switch (errno) {
         #ifdef EWOULDBLOCK
         #if EAGAIN != EWOULDBLOCK
          case EWOULDBLOCK:
         #endif
         #endif
          case EAGAIN:
          case EINTR:
            /* temporary error; retry */
            break;
          /*case ENOMEM:*/
          default:
            /* unrecoverable error; might leak fd */
            log_perror(ev->errh, __FILE__, __LINE__,
              "fdevent event_del failed on fd %d", fdn->fd);
            return 0;
        }
    } while (0 != event_del_dispatch(ev, fdn));
    return 1;
}

static void
fdevent_fdnode_event_unsetter (fdevents *ev, fdnode *fdn)
{
    if (-1 == fdn->fde_ndx) return;
    if (0 != event_del_dispatch(ev, fdn))
        fdevent_fdnode_event_unsetter_retry(ev, fdn);
    fdn->fde_ndx = -1;
    fdn->events = 0;
}

__attribute_cold__
__attribute_noinline__
static int
fdevent_fdnode_event_setter_retry (fdevents *ev, fdnode *fdn, int events)
{
    do {
        switch (errno) {
         #ifdef EWOULDBLOCK
         #if EAGAIN != EWOULDBLOCK
          case EWOULDBLOCK:
         #endif
         #endif
          case EAGAIN:
          case EINTR:
            /* temporary error; retry */
            break;
          /*case ENOMEM:*/
          default:
            /* unrecoverable error */
            log_perror(ev->errh, __FILE__, __LINE__,
              "fdevent event_set failed on fd %d", fdn->fd);
            return 0;
        }
    } while (0 != event_set_dispatch(ev, fdn, events));
    return 1;
}

static void
fdevent_fdnode_event_setter (fdevents *ev, fdnode *fdn, int events)
{
    /*(Note: skips registering with kernel if initial events is 0,
     * so caller should pass non-zero events for initial registration.
     * If never registered due to never being called with non-zero events,
     * then FDEVENT_HUP or FDEVENT_ERR will never be returned.) */
    if (fdn->events == events) return;/*(no change; nothing to do)*/

    if (0 == ev->event_set(ev, fdn, events)
        || fdevent_fdnode_event_setter_retry(ev, fdn, events))
        fdn->events = events;
}

void
fdevent_fdnode_event_del (fdevents *ev, fdnode *fdn)
{
    if (NULL != fdn) fdevent_fdnode_event_unsetter(ev, fdn);
}

void
fdevent_fdnode_event_set (fdevents *ev, fdnode *fdn, int events)
{
    if (NULL != fdn) fdevent_fdnode_event_setter(ev, fdn, events);
}

void
fdevent_fdnode_event_add (fdevents *ev, fdnode *fdn, int event)
{
    if (NULL != fdn) fdevent_fdnode_event_setter(ev, fdn, (fdn->events|event));
}

void
fdevent_fdnode_event_clr (fdevents *ev, fdnode *fdn, int event)
{
    if (NULL != fdn) fdevent_fdnode_event_setter(ev, fdn, (fdn->events&~event));
}
