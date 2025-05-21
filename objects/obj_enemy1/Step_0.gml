// Atualiza sala do jogador e inimigo
var sala_inimigo = mapa.grid_sala[# (x div cell_t), (y div cell_t)];
var sala_jogador = mapa.grid_sala[# (obj_player.x div cell_t), (obj_player.y div cell_t)];

// Alerta por sala — atualização de estado
if (sala_inimigo != -1 && sala_inimigo == sala_jogador) {
    if (estado != "perseguicao") {
        estado = "perseguicao";
        ultima_sala_jogador = -1;

        if (sala_inimigo >= 0 && sala_inimigo < array_length(global.grafo_salas)) {
            global.grafo_salas[sala_inimigo].alerta = true;
        }
    }
} else {
    if (estado != "parado") {
        estado = "parado";
        path_end();
    }
}

switch(estado){
	case "parado":
		
	break;
	case "perseguicao":
		if (point_distance(x, y, obj_player.x, obj_player.y) > 16) {
			ultima_sala_jogador = sala_jogador;

			var x1 = x;
			var y1 = y;
			var x2 = (obj_player.x div 32) * 32 + 16;
			var y2 = (obj_player.y div 32) * 32 + 16;

			if (mp_grid_path(obj_map.mp_grid, caminho, x1, y1, x2, y2, true)) {
				path_start(caminho, velc, path_action_stop, false);
			}
		}
	break;
}