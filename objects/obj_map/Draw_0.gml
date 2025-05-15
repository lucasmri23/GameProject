if (global.exibir_grafo) {
    draw_set_color(c_lime);
    for (var i = 0; i < array_length(global.grafo_salas); i++) {
        var salaA = global.grafo_salas[i];
        var x1 = salaA[0] * cell_t + cell_t / 2;
        var y1 = salaA[1] * cell_t + cell_t / 2;

        var conexoes = ds_map_find_value(global.grafo, string(i));
        for (var j = 0; j < ds_list_size(conexoes); j++) {
            var id_b = ds_list_find_value(conexoes, j);
            var salaB = global.grafo_salas[id_b];
            var x2 = salaB[0] * cell_t + cell_t / 2;
            var y2 = salaB[1] * cell_t + cell_t / 2;
            draw_line(x1, y1, x2, y2);
        }

        draw_circle(x1, y1, 4, false);
		draw_set_color(c_black);
		draw_text(x1 + 6, y1 - 9, string(i)); // sombra
		draw_set_color(c_lime);
		draw_text(x1 + 5, y1 - 10, string(i)); // texto
    }
}