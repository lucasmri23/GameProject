function mapa_instanciar_inimigos() {
    var min_dist_player = 130;
    var min_dist_others = 100;

    var sala_largura = 6; // em células (tiles) da grid
    var sala_altura  = 6;

    for (var i = 0; i < array_length(global.grafo_salas); i++) {
        var sala = global.grafo_salas[i];

        // Pula a sala inicial
        if (sala == global.sala_inicial) continue;

        var sx = sala.x;
        var sy = sala.y;

        var area = sala_largura * sala_altura;
        var quantidade = irandom_range(1, clamp(floor(area / 10), 2, 5)); // mais ajustado para densidade

        var tentativas = 0;
        var criados = 0;

        while (criados < quantidade && tentativas < 100) {
            tentativas++;

            var cx = irandom_range(sx - sala_largura div 2 + 1, sx + sala_largura div 2 - 2);
            var cy = irandom_range(sy - sala_altura div 2 + 1, sy + sala_altura div 2 - 2);

            if (grid[# cx, cy] != global.TIPO_SALA) continue;

            var x1 = cx * cell_t + cell_t / 2;
            var y1 = cy * cell_t + cell_t / 2;

            var dist_ok = true;

            if (instance_exists(obj_player)) {
                if (point_distance(obj_player.x, obj_player.y, x1, y1) < min_dist_player) {
                    dist_ok = false;
                }
            }

            if (dist_ok) {
                with (obj_enemy1) {
                    if (point_distance(x, y, x1, y1) < min_dist_others) {
                        dist_ok = false;
                    }
                }
            }

            if (dist_ok) {
                instance_create_layer(x1, y1, "instances", obj_enemy1);
                criados++;
            }
        }
    }
}
