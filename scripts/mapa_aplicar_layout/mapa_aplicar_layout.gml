function mapa_aplicar_layout(xx, yy, layout, sala_id) {
    var layout_altura = array_length(layout);
    var layout_largura = array_length(layout[0]);

    for (var yy = 0; yy < layout_altura; yy++) {
        for (var xx = 0; xx < layout_largura; xx++) {
            var celula = layout[y][x];

            var gx = xx + x;
            var gy = yy + y;

            // Verifica se está dentro do grid
            if (gx >= 0 && gx < cell_h && gy >= 0 && gy < cell_v) {
                grid[gx, gy] = celula;
                // Se quiser marcar a sala, pode usar:
                sala_ids[gx, gy] = sala_id;
            }
        }
    }
}
