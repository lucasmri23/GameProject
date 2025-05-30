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
    var sala_jogador = mapa.grid_sala[# (obj_player.x div cell_t), (obj_player.y div cell_t)];
    var tem_visao = !collision_line(x, y, obj_player.x, obj_player.y, obj_colisao, true, false);

    // Se o jogador está na mesma sala e visível, define estado interno
    if (sala_inimigo != -1 && sala_inimigo == sala_jogador && tem_visao) {
        if (estado != "perseguicao") {
            estado = "perseguicao";
            ultima_sala_jogador = -1;
            alertou = false;

            if (!global.grafo_salas[sala_inimigo].alerta) {
                global.grafo_salas[sala_inimigo].alerta = true;
            }
        }
    } else if (estado != "perseguindo") {
        estado = "patrulha";
        path_end();
        state = enemy1_state_patrol;
        exit;
    }

    // Recalcula o path
    if (tempo_path_recalc <= 0) {
        if (mp_grid_path(global.grid_pathfinding, caminho, x, y, obj_player.x, obj_player.y, true)) {
            path_start(caminho, velc, path_action_stop, false);
            path_atual = caminho;
        }
        tempo_path_recalc = path_delay;
    } else {
        tempo_path_recalc--;
    }

    // Direção do sprite
    if (instance_exists(obj_player)) {
        sprite_index = (obj_player.x > x) ? spr_enemy1_run_rigth : spr_enemy1_run_left;
    }

    // Comunicação com outros inimigos próximos
    if (!alertou) {
        with (obj_enemy1) {
            if (id != other.id && point_distance(x, y, other.x, other.y) < 96) {
                if (state != enemy1_state_chase) {
                    state = enemy1_state_chase;
                    alertou = false;
                }
            }
        }
        alertou = true;
    }

    // 🔔 Propagação de alerta
    if (estado == "perseguicao" && !alertou && sala_inimigo != -1) {
        if (!global.grafo_salas[sala_inimigo].alerta) {
            propagar_alerta_bfs(sala_inimigo, 1);
        }
        alertou = true;
    }

    // Se o jogador se distanciar muito, desiste
    if (point_distance(x, y, obj_player.x, obj_player.y) > visao * 1.5) {
        estado = "patrulha";
        path_end();
        state = enemy1_state_patrol;
    }
	
	if (point_distance(x, y, obj_player.x, obj_player.y) <= alcance_ataque && atk_cd <=0) {
        image_xscale = (obj_player.x >= x) ? -1 : 1; //olha para o lado do jogador
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

    // Criar hitbox no frame 5
    if (image_index >= 5 && image_index < 6) {
        if (!instance_exists(obj_hitbox_enemy1)) {
            instance_create_layer(x - (9 * image_xscale), y + 8, "tileset", obj_hitbox_enemy1);
        }
    }
    // Destruir hitbox no frame 8
    if (image_index >= 8 && instance_exists(obj_hitbox_enemy1)) {
        instance_destroy(obj_hitbox_enemy1);
    }

    // Finalizar animação
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