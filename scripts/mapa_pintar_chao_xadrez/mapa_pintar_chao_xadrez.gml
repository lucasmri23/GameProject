function mapa_pintar_chao_xadrez(tilemap_chao_id) {
    for (var xx = 0; xx < cell_h; xx++) {
        for (var yy = 0; yy < cell_v; yy++) {
            var tipo = grid[# xx, yy];
            var tile_index;

            if (tipo == global.TIPO_SALA) {
                // Tiles 2 e 3 para salas
                tile_index = ((xx + yy) mod 2 == 0) ? 2 : 3;
            }
            else if (tipo == global.TIPO_CORREDOR) {
                // Tiles 4 e 5 para corredores
                tile_index = ((xx + yy) mod 2 == 0) ? 4 : 5;
            }
            else {
                continue; // Pula espaços vazios
            }

            tilemap_set(tilemap_chao_id, tile_index, xx, yy);
        }
    }
}
