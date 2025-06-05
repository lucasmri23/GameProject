if (visible) {
    var centro_x = display_get_gui_width() / 2;
    
    draw_set_halign(fa_center);
    draw_set_valign(fa_top);
    draw_set_font(ft_creditos);
    
    draw_text(centro_x, 100, 
        "CRÉDITOS\n\n" +
        "Desenvolvido por: Lucas Marques Ribeiro\n" +
        "Professor(a) Orientador(a): Dra. Andrea Ono Sakai\n" +
        "Universidade: Centro Universitário Braz Cuabs\n\n" +
        "Sprite do cavaleiro: Artwork created by Raphael Gonçalves email: rgsdev83@gmail.com\n" +
        "Sprite dos slimes: https://craftpix.net/file-licenses\n\n" +
		"Obrigado por jogar!"
    );
}
