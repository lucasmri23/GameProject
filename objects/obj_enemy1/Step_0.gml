if(life <=0) instance_destroy();
if (atk_cd > 0) atk_cd--;
script_execute(state);

// Se o jogo ainda não começou
if (!global.jogo_iniciado) {
    exit;
}