if (visible) {
    // Cores de fundo dependendo do hover
    var cor_fundo = hover ? make_color_rgb(255, 180, 70) : make_color_rgb(255, 130, 0);
    var cor_texto = c_white;

    // Fundo do botão
    draw_set_color(cor_fundo);
    draw_rectangle(btn_x, btn_y, btn_x + btn_w, btn_y + btn_h, false);

    // Texto do botão
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_font(ft_creditos); // ou uma fonte legível
    draw_set_color(cor_texto);
    draw_text(btn_x + btn_w / 2, btn_y + btn_h / 2, "Voltar");
}
