static handler_t plugins_call_fn_con_data(connection * const con, const int e) {
    const void * const plugin_slots = con->plugin_slots;
    const uint32_t offset = ((const uint16_t *)plugin_slots)[e];
    if (0 == offset) return HANDLER_GO_ON;
    const plugin_fn_con_data *plfd = (const plugin_fn_con_data *)
      (((uintptr_t)plugin_slots) + offset);
    handler_t rc = HANDLER_GO_ON;
    while (plfd->fn && (rc = plfd->fn(con, plfd->data)) == HANDLER_GO_ON)
        ++plfd;
    return rc;
}