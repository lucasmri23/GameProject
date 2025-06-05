var m_x = device_mouse_x_to_gui(0);
var m_y = device_mouse_y_to_gui(0);

for (var i = 0; i < array_length(resolucao_opcoes); i++) {
    var yy = y_inicio + i * margin;
    var texto = resolucao_opcoes[i].nome;
    var largura = string_width(texto);
    var altura = string_height(texto);

    if (point_in_rectangle(m_x, m_y, x_centro - largura/2, yy - altura/2, x_centro + largura/2, yy + altura/2)) {
        if (mouse_check_button_pressed(mb_left)) {
            resolucao_index = i;
            // Salva os dados escolhidos globalmente
            global.resolution_width_selected  = resolucao_opcoes[i].width;
            global.resolution_height_selected = resolucao_opcoes[i].height;
            global.resolution_scale_selected  = resolucao_opcoes[i].scale;
        }
    }
}

if (mouse_check_button_pressed(mb_right)) {
    instance_create_layer(0, 0, "GUI", obj_menu);
    instance_destroy();
}
