if(life <=0) instance_destroy();
script_execute(state);

// Se o jogo ainda não começou
if (!global.jogo_iniciado) {
    exit;
}
