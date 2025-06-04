function mapa_inicializar_globals() {
    cell_t = 32;
    room_width = cell_t * 40;
    room_height = room_width div 2;
    cell_h = room_width div cell_t;
    cell_v = room_height div cell_t;

	global.inimigos_vivos = 0;
    global.grafo = ds_map_create();
    global.grafo_salas = [];
    global.grafo_salas_length_last = -1;
    global.exibir_grafo = false;
    // global.salas será inicializado no obj_map Create, após a geração das salas.
}