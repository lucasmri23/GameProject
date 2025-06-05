if (visible) {
    var centro_x = display_get_gui_width() / 2;
    
    draw_set_halign(fa_center);
    draw_set_valign(fa_top);
    draw_set_font(ft_creditos);
    
    draw_text(centro_x, 100, 
        "CRÉDITOS\n\n" +
        "Desenvolvido por: Seu Nome\n" +
        "Música: Nome do artista\n" +
        "Fontes: XYZ\n\n" +
        "Obrigado por jogar!"
    );
}
