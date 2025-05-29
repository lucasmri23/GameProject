function player_state_idle(){
	velh=0;
	velv=0;
	if(global.jogo_iniciado = true){
		state = player_state_free;	
	}
}
function player_state_free(){
	var tecla_direita = keyboard_check(ord("D"));
	var tecla_esquerda = keyboard_check(ord("A")); 
	var tecla_cima = keyboard_check(ord("W"));
	var tecla_baixo = keyboard_check(ord("S")); 
	var teclas = tecla_direita - tecla_esquerda != 0 || tecla_baixo - tecla_cima != 0;

	if(velh !=0)image_xscale = sign(velh)
	if(teclas !=0){
		sprite_index = spr_player_run
	}else{
		sprite_index = spr_player_idle
	}

	move_dir = point_direction(0, 0, tecla_direita - tecla_esquerda, tecla_baixo - tecla_cima);

	velh = lengthdir_x(velc * teclas, move_dir);
	velv = lengthdir_y(velc * teclas, move_dir);
	
	if(mouse_check_button(mb_left)){	
		if(mouse_x < x) image_xscale = -1 else image_xscale = 1;
		image_index = 0;
		state = player_state_atk;
	}
	
	if(mouse_check_button(mb_right)){	
		image_index = 0;
		state = player_state_def;
	}
}
function player_state_atk(){
	velh = 0;
	velv = 0;
	if(image_index > 2){
		if(!instance_exists(obj_hitbox)){
			//cria hitbox do atk
			instance_create_layer(x + (10 * image_xscale),y+6,"tileset",obj_hitbox)
		}
	}
	sprite_index = spr_player_atk
	if(image_index >= image_number-1){
		if(instance_exists(obj_hitbox)) instance_destroy(obj_hitbox);
		state = player_state_free;
	}
}function player_state_def(){
	velh = 0;
	velv = 0;
	sprite_index = spr_player_def;

	image_index = 1;

	// Mantém o estado enquanto o botão direito estiver pressionado
	if(!mouse_check_button(mb_right)){
		state = player_state_free;
	}	
}