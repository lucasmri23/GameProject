function enemy1_state_idle(){
	velh=0;
	velv=0;
	if(global.jogo_iniciado = true){
		state = enemy1_state_patrol;	
	}
}
function enemy1_state_patrol() {
    sprite_index = spr_enemy1_idle;

    var dist = point_distance(x, y, obj_player.x, obj_player.y);
    if (dist <= visao) {
        state = enemy1_state_chase;
        alertou = false;
        path_end();
        exit;
    }
}
function enemy1_state_chase() {
    var sala_inimigo = mapa.grid_sala[# (x div cell_t), (y div cell_t)];
    if (minha_sala_id == -1 || minha_sala_id != sala_inimigo) {
        minha_sala_id = sala_inimigo;
    }

    var sala_jogador = mapa.grid_sala[# (obj_player.x div cell_t), (obj_player.y div cell_t)];
    var tem_visao = !collision_line(x, y, obj_player.x, obj_player.y, obj_colisao, true, false);

    // Se o jogador está na mesma sala e visível, define estado interno
    if (sala_inimigo != -1 && sala_inimigo == sala_jogador && tem_visao) {
        if (estado != "perseguicao") {
            estado = "perseguicao";
            ultima_sala_jogador = -1;
            alertou = false;

            if (ds_map_exists(global.salas, sala_inimigo) && !global.salas[? sala_inimigo].alerta) {
                global.salas[? sala_inimigo].alerta = true;
            }
        }
    } 

    // Recalcula o path
    if (tempo_path_recalc <= 0) {
        show_debug_message("Inimigo " + string(id) + " - Recalculando path para X:" + string(obj_player.x) + " Y:" + string(obj_player.y));
        // ALTERAÇÃO: Destino do path simplificado
        if (mp_grid_path(global.grid_pathfinding, caminho, x, y, obj_player.x, obj_player.y, true)) {
            path_start(caminho, velc, path_action_stop, false);
            path_atual = caminho;
            show_debug_message("Inimigo " + string(id) + " - Path encontrado e iniciado.");
        } else {
            show_debug_message("AVISO: Inimigo " + string(id) + " - Não conseguiu encontrar um path para o jogador. Posição inimigo: (" + string(x) + "," + string(y) + ") Posição jogador: (" + string(obj_player.x) + "," + string(obj_player.y) + ")");
        }
        tempo_path_recalc = path_delay;
    } else {
        tempo_path_recalc--;
    }

    // Direção do sprite
    if (instance_exists(obj_player)) {
        sprite_index = (obj_player.x > x) ? spr_enemy1_run_rigth : spr_enemy1_run_left;
    }

    // 🔔 Propagação de alerta (usando BFS)
    if (estado == "perseguicao" && !alertou && sala_inimigo != -1) {
        propagar_alerta_bfs(sala_inimigo, 2);
        alertou = true;
    }

    // 📣 Lógica de pedido de reforço
    if (estado == "perseguicao" && sala_inimigo != -1) {
        if (tempo_prox_reforco <= 0) {
            var sala_do_player = mapa.grid_sala[# (obj_player.x div cell_t), (obj_player.y div cell_t)];
            if (sala_inimigo == sala_do_player) { 
                solicitar_reforco(sala_inimigo);
                tempo_prox_reforco = tempo_reforco_cooldown;
            }
        } else {
            tempo_prox_reforco--;
        }
    }

    // Se o jogador se distanciar muito, desiste
    if (point_distance(x, y, obj_player.x, obj_player.y) > visao * 1.5) {
        estado = "patrulha";
        path_end();
        state = enemy1_state_patrol;
    }
	
	if (point_distance(x, y, obj_player.x, obj_player.y) <= alcance_ataque && atk_cd <=0) {
        image_xscale = (obj_player.x >= x) ? -1 : 1;
		image_index = 0;
		state = enemy1_state_atk;
		path_end();
		exit;
	}
	
}
function enemy1_state_atk() {
    velh = 0;
    velv = 0;
    sprite_index = spr_enemy1_atk;

    if (image_index >= 5 && image_index < 6) {
        if (!instance_exists(obj_hitbox_enemy1)) {
            instance_create_layer(x - (9 * image_xscale), y + 8, "tileset", obj_hitbox_enemy1);
        }
    }
    if (image_index >= 8 && instance_exists(obj_hitbox_enemy1)) {
        instance_destroy(obj_hitbox_enemy1);
    }

    if (image_index >= image_number - 1) {
        if (instance_exists(obj_hitbox_enemy1)) {
            instance_destroy(obj_hitbox_enemy1);
        }
        atk_started = false;
        atk_cd = 90;
        state = enemy1_state_chase;
    }
}

function enemy1_state_hurt() {
	velh = 0;
	velv = 0;
    if (!variable_instance_exists(id, "hurt_started") || !hurt_started) {
        hurt_started = true;
        image_index = 0;
		sprite_index = spr_enemy1_hurt_front;
    }

    if (image_index >= image_number - 1) {
        hurt_started = false;
        state = enemy1_state_chase;
    }
}
function enemy1_state_dead(){
	velh = 0;
	velv = 0;
	sprite_index = spr_enemy1_death;
	
	if (!death_started) {
		death_started = true;
		image_index = 0;
    }
	    if (image_index >= image_number - 1) {
			image_index = image_number - 1;
            
            if (minha_sala_id != -1 && ds_map_exists(global.salas, minha_sala_id)) {
                var sala_onde_morreu = global.salas[? minha_sala_id];
                sala_onde_morreu.inimigos_ativos_count--;
                if (sala_onde_morreu.inimigos_ativos_count <= 0) {
                    sala_onde_morreu.alerta = false;
                }
            }
			global.inimigos_vivos -= 1;

			// Verifica vitória
			if (global.inimigos_vivos <= 0){
				room_goto(Room_win);
			}
			instance_destroy();
    }
	
}