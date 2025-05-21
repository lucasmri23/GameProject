if (global.exibir_grafo) {
    for (var i = 0; i < array_length(global.grafo_salas); i++) {
        var salaA = global.grafo_salas[i];
        var x1 = salaA.x * cell_t + cell_t / 2;
        var y1 = salaA.y * cell_t + cell_t / 2;

        // Desenha as conexões (arestas do grafo)
        var conexoes = ds_map_find_value(global.grafo, string(i));
        for (var j = 0; j < ds_list_size(conexoes); j++) {
            var id_b = ds_list_find_value(conexoes, j);
            var salaB = global.grafo_salas[id_b];
            var x2 = salaB.x * cell_t + cell_t / 2;
            var y2 = salaB.y * cell_t + cell_t / 2;

            draw_set_color(c_white);
            draw_line(x1, y1, x2, y2);
        }

        // Cor diferente dependendo do tipo da sala
        switch (salaA.tipo) {
            case "inicial":
                draw_set_color(c_blue);
                break;
            case "final":
                draw_set_color(c_red);
                break;
            default:
                draw_set_color(salaA.alerta ? c_orange : c_lime);
        }

        draw_circle(x1, y1, 5, false);

        // Texto do índice da sala
        draw_set_color(c_black);
        draw_text(x1 + 6, y1 - 9, string(i)); // sombra
        draw_set_color(c_white);
        draw_text(x1 + 5, y1 - 10, string(i));
    }
}
