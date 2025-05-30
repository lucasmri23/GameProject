if(life <=0 && state != enemy1_state_dead){
	state = enemy1_state_dead;
}

if (atk_cd > 0) atk_cd--;
script_execute(state);

// Se o jogo ainda não começou
if (!global.jogo_iniciado) {
    exit;
}