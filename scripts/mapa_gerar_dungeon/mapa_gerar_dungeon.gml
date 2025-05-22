function sala_ja_existente(xx, yy, dist_minima = 3) {
    for (var i = 0; i < array_length(global.grafo_salas); i++) {
        var sala = global.grafo_salas[i];
        if (point_distance(sala.x, sala.y, xx, yy) <= dist_minima) {
            return i;
        }
    }
    return -1;
}

function mapa_gerar_dungeon(room_count) {
    randomize();
    var dir = irandom(3);
    var xx = cell_h div 2;
    var yy = cell_v div 2;
    var room_size = 1;

    for (var i = 0; i < room_count; i++) {
        mapa_criar_sala(xx, yy, room_size);
        var path_distance = room_size * 6;
        var nova_pos = mapa_criar_corredor(xx, yy, dir, path_distance);
        xx = nova_pos[0];
        yy = nova_pos[1];

        mapa_criar_sala(xx, yy, room_size);
        var sala_existente = sala_ja_existente(xx, yy, 3);
        var sala_index;

		if (sala_existente == -1) {
			sala_index = array_length(global.grafo_salas);
			var nova_sala = new Sala(sala_index, xx, yy);
			array_push(global.grafo_salas, nova_sala);

    // 🔧 Adicione este bloco:
			if (!variable_global_exists("salas")) {
				global.salas = ds_map_create();
			}
			global.salas[? nova_sala.id] = nova_sala;

		for (var i2 = xx - room_size; i2 <= xx + room_size; i2++) {
			for (var j2 = yy - room_size; j2 <= yy + room_size; j2++) {
				grid_sala[# i2, j2] = sala_index;
			}
		}

    var conexoes = ds_list_create();
    ds_map_add(global.grafo, string(sala_index), conexoes);

        } else {
            sala_index = sala_existente;
        }

        if (global.grafo_salas_length_last != -1 && sala_index != global.grafo_salas_length_last) {
            var sala_anterior = global.grafo_salas[global.grafo_salas_length_last];
            var sala_atual = global.grafo_salas[sala_index];

            array_push(sala_anterior.conexoes, sala_index);
            array_push(sala_atual.conexoes, global.grafo_salas_length_last);
        }

        global.grafo_salas_length_last = sala_index;
        dir = irandom(3);
    }
}
