var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);

hover = (mx > btn_x && mx < btn_x + btn_w && my > btn_y && my < btn_y + btn_h);

// Clique com o mouse
if (hover && mouse_check_button_pressed(mb_left)) {
    // Ação do botão
    with (obj_creditos) visible = false;
    with (obj_botao_voltar) visible = false;
    with (obj_menu) visible = true;
    
    // Som opcional
    // audio_play_sound(snd_click, 1, false);
}
