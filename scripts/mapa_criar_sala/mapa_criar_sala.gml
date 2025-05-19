function mapa_criar_sala(xx, yy, room_size) {
    ds_grid_set_region(grid, xx - room_size, yy - room_size, xx + room_size, yy + room_size, 1);
    for (var i = xx - room_size; i <= xx + room_size; i++) {
        for (var j = yy - room_size; j <= yy + room_size; j++) {
            grid_sala[# i, j] = array_length(global.grafo_salas);
        }
    }
}
