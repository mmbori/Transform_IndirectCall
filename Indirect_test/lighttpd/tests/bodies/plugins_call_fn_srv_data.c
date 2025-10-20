static handler_t plugins_call_fn_srv_data(server * const srv, const int e) {
    const uint32_t offset = ((const uint16_t *)srv->plugin_slots)[e];
    if (0 == offset) return HANDLER_GO_ON;
    const plugin_fn_srv_data *plfd = (const plugin_fn_srv_data *)
      (((uintptr_t)srv->plugin_slots) + offset);
    handler_t rc = HANDLER_GO_ON;
    while (plfd->fn && (rc = plfd->fn(srv,plfd->data)) == HANDLER_GO_ON)
        ++plfd;
    return rc;
}