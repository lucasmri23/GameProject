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
        alertou = false; // Resetar para permitir novo alerta ao entrar no chase
        path_end();
        exit;
    }
}
function enemy1_state_chase() {
    var sala_inimigo = mapa.grid_sala[# (x div cell_t), (y div cell_t)];
    // Certifique-se de que o inimigo sabe em qual sala ele está
    if (minha_sala_id == -1 || minha_sala_id != sala_inimigo) {
        minha_sala_id = sala_inimigo;
    }

    var sala_jogador = mapa.grid_sala[# (obj_player.x div cell_t), (obj_player.y div cell_t)];
    var tem_visao = !collision_line(x, y, obj_player.x, obj_player.y, obj_colisao, true, false);

    // Se o jogador está na mesma sala e visível
    if (sala_inimigo != -1 && sala_inimigo == sala_jogador && tem_visao) {
        if (estado != "perseguicao") {
            estado = "perseguicao";
            ultima_sala_jogador = -1;
            alertou = false; // Permite que o alerta seja disparado ao entrar neste estado

            // Marca a sala atual do inimigo como alerta (se já não estiver)
            if (ds_map_exists(global.salas, sala_inimigo) && !global.salas[? sala_inimigo].alerta) {
                global.salas[? sala_inimigo].alerta = true;
            }
        }
    } else { // Se o jogador não está mais na mesma sala e visível
        estado = "patrulha";
        path_end();
        state = enemy1_state_patrol;
        exit;
    }

    // Recalcula o path
    if (tempo_path_recalc <= 0) {
        if (mp_grid_path(global.grid_pathfinding, caminho, x, y, obj_player.x-(20*image_xscale), obj_player.y, true)) {
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

    // 🔔 Propagação de alerta (usando BFS)
    // Se este inimigo está em perseguição e ainda não alertou a rede para esta "onda"
    if (estado == "perseguicao" && !alertou && sala_inimigo != -1) {
        // A sala do inimigo já foi marcada como alerta acima. Agora propaga.
        // profundidade_maxima: 1 = apenas vizinhos diretos, 2 = vizinhos dos vizinhos, etc.
        // Um valor maior espalha mais longe. Experimente!
        propagar_alerta_bfs(sala_inimigo, 2); // Exemplo: alerta se propaga por até 2 saltos
        alertou = true; // Marca que este inimigo já iniciou o alerta nesta "onda" de perseguição
    }

    // 📣 Lógica de pedido de reforço
    if (estado == "perseguicao" && sala_inimigo != -1) {
        if (tempo_prox_reforco <= 0) {
            var sala_do_player = mapa.grid_sala[# (obj_player.x div cell_t), (obj_player.y div cell_t)];
            // Se o inimigo está na mesma sala que o jogador (assumindo combate)
            if (sala_inimigo == sala_do_player) { 
                solicitar_reforco(sala_inimigo);
                tempo_prox_reforco = tempo_reforco_cooldown; // Reseta o cooldown
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
function enemy1_state_dead(){
	velh = 0;
	velv = 0;
	sprite_index = spr_enemy1_death;
	
	if (!death_started) {
		death_started = true;
		image_index = 0;
    }
	    if (image_index >= image_number - 1) {
			image_index = image_number - 1; // trava no último frame
            
            // Decrementar o contador de inimigos da sala e desativar alerta se for o último
            if (minha_sala_id != -1 && ds_map_exists(global.salas, minha_sala_id)) {
                var sala_onde_morreu = global.salas[? minha_sala_id];
                sala_onde_morreu.inimigos_ativos_count--;
                // Se não há mais inimigos ATIVOS na sala, desativa o alerta
                if (sala_onde_morreu.inimigos_ativos_count <= 0) {
                    sala_onde_morreu.alerta = false;
                }
            }
			instance_destroy();
    }
	
}