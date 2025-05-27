// Atualiza sala do jogador e inimigo
var sala_inimigo = mapa.grid_sala[# (x div cell_t), (y div cell_t)];
var sala_jogador = mapa.grid_sala[# (obj_player.x div cell_t), (obj_player.y div cell_t)];
var tem_visao = !collision_line(x, y, obj_player.x, obj_player.y, obj_colisao, true, false);

// Se o jogo ainda não começou
if (!global.jogo_iniciado) {
    exit;
}

// Verifica se o inimigo vê o jogador na mesma sala
if (sala_inimigo != -1 && sala_inimigo == sala_jogador && tem_visao) {
    if (estado != "perseguicao") {
        estado = "perseguicao";
        ultima_sala_jogador = -1;
        alertou = false; // permite que esse inimigo alerte uma vez

        if (sala_inimigo >= 0 && sala_inimigo < array_length(global.grafo_salas)) {
            global.grafo_salas[sala_inimigo].alerta = true;
        }
    }
} else if (estado != "perseguindo") {
    estado = "patrulha";
    path_end();
}

// 🔔 Propagação de alerta (ocorre apenas uma vez por perseguição)
if (estado == "perseguicao" && !alertou && sala_inimigo != -1) {
    if (!global.grafo_salas[sala_inimigo].alerta) {
        propagar_alerta_bfs(sala_inimigo, 1);
    }
    alertou = true;
}

// --- Lógica de estados ---
switch (estado) {
    case "patrulha":
		sprite_index = spr_enemy1_idle;
        var dist = point_distance(x, y, obj_player.x, obj_player.y);
        if (dist <= visao) {
            estado = "perseguindo";
            alertou = false;
            path_end();
        }
        break;

    case "perseguindo":
        if (tempo_path_recalc <= 0) {
            var x2 = obj_player.x;
            var y2 = obj_player.y;

            if (mp_grid_path(global.grid_pathfinding, caminho, x, y, x2, y2, true)) {
                path_start(caminho, velc, path_action_stop, false);
                path_atual = caminho;
            }
            tempo_path_recalc = path_delay;
        } else {
            tempo_path_recalc--;
        }

        // Perdeu o jogador de vista
        if (point_distance(x, y, obj_player.x, obj_player.y) > visao * 1.5) {
            estado = "patrulha";
            path_end();
        }

        // Comunicação com inimigos próximos
        if (!alertou) {
            with (obj_enemy1) {
                if (id != other.id && point_distance(x, y, other.x, other.y) < 96) {
                    if (estado != "perseguindo") {
                        estado = "perseguindo";
                        alertou = false;
                    }
                }
            }
            alertou = true;
        }
		
		if(instance_exists(obj_player)){
			if(obj_player.x>x){
				sprite_index = spr_enemy1_run_rigth
			}else if((obj_player.x<x)){
				sprite_index = spr_enemy1_run_left
			}	
		}
		
        break;

    case "perseguicao":
        if (point_distance(x, y, obj_player.x, obj_player.y) > 16) {
            ultima_sala_jogador = sala_jogador;

            var x2 = (obj_player.x div 32) * 32 + 16;
            var y2 = (obj_player.y div 32) * 32 + 16;

            if (mp_grid_path(obj_map.mp_grid, caminho, x, y, x2, y2, true)) {
                path_start(caminho, velc, path_action_stop, false);
            }
        }
        break;
}
