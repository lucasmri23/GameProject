if(global.pause){
	image_speed = 0;
	exit;
}else{
	image_speed = 1;
}

script_execute(state)
if(life <=0 && state != player_state_dead){
	state = player_state_dead;
}

// Se o jogo ainda não foi iniciado
if (!global.jogo_iniciado) {
    global.tempo_inicio_jogo++;
	var tecla_direita = keyboard_check(ord("D"));
	var tecla_esquerda = keyboard_check(ord("A")); 
	var tecla_cima = keyboard_check(ord("W"));
	var tecla_baixo = keyboard_check(ord("S")); 
    var movendo = tecla_direita || tecla_esquerda || tecla_cima || tecla_baixo;

    if (movendo || global.tempo_inicio_jogo > 60*60) { // aguarda 1 minuto
        global.jogo_iniciado = true;
    }
}

// Colisão horizontal
if (place_meeting(x + velh, y, obj_colisao)) {
    while (!place_meeting(x + sign(velh), y, obj_colisao)) {
        x += sign(velh);
    }
    velh = 0;
}
x += velh;

// Colisão vertical
if (place_meeting(x, y + velv, obj_colisao)) {
    while (!place_meeting(x, y + sign(velv), obj_colisao)) {
        y += sign(velv);
    }
    velv = 0;
}
y += velv;
