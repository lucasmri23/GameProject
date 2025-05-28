// === ENTRADA ===
var hinput = keyboard_check(ord("D")) - keyboard_check(ord("A"));
var vinput = keyboard_check(ord("S")) - keyboard_check(ord("W"));
var teclando = hinput != 0 || vinput != 0;
var mouse_atk = mouse_check_button_pressed(mb_left);

// === MOVIMENTO BASE ===
var move_dir = point_direction(0, 0, hinput, vinput);
velh = lengthdir_x(velc * teclando, move_dir);
velv = lengthdir_y(velc * teclando, move_dir);

// === INÍCIO DO JOGO ===
if (!global.jogo_iniciado) {
    global.tempo_inicio_jogo++;

    if (teclando || global.tempo_inicio_jogo > 60 * 60) {
        global.jogo_iniciado = true;
    }

    if (mouse_atk) {
        state = PlayerStates.atk;
    }
}

// === TRANSIÇÃO DE ESTADO ===
if (state != PlayerStates.atk) {
    if (mouse_atk) {
        state = PlayerStates.atk;
    } else if (teclando) {
        state = PlayerStates.run;
    } else {
        state = PlayerStates.idle;
    }
}

// === FUNÇÃO DE ATAQUE ===
function player_states_atk() {
    sprite_index = spr_player_atk;
    velh = 0;
    velv = 0;

	
    if (!instance_exists(obj_hitbox)) {
        instance_create_layer(x + (20 * image_xscale), y, layer, obj_hitbox);
    }
		if (instance_exists(obj_hitbox)) instance_destroy(obj_hitbox);
			
	if (image_index >= image_number - 1) {
        state = PlayerStates.idle;
		
    }
}

// === LÓGICA DE ESTADOS ===
switch (state) {
    case PlayerStates.idle:
        sprite_index = spr_player_idle;
        break;

    case PlayerStates.run:
        sprite_index = spr_player_run;
        if (velh != 0) image_xscale = sign(velh);
        break;

    case PlayerStates.atk:
        player_states_atk();
        break;
}

// === COLISÃO HORIZONTAL ===
if (place_meeting(x + velh, y, obj_hitbox)) {
    while (!place_meeting(x + sign(velh), y, obj_hitbox)) {
        x += sign(velh);
    }
    velh = 0;
}
x += velh;

// === COLISÃO VERTICAL ===
if (place_meeting(x, y + velv, obj_colisao)) {
    while (!place_meeting(x, y + sign(velv), obj_colisao)) {
        y += sign(velv);
    }
    velv = 0;
}
y += velv;
