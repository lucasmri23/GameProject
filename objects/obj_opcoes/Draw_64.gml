draw_set_font(ft_menu);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

draw_text(x_centro, y_inicio - margin * 1.5, "ESCOLHA UMA RESOLUÇÃO:");

for (var i = 0; i < array_length(resolucao_opcoes); i++) {
    var yy = y_inicio + i * margin;
    var texto = resolucao_opcoes[i].nome;
    draw_set_color(i == resolucao_index ? c_orange : c_white);
    draw_text(x_centro, yy, texto);
}

draw_text(x_centro, y_inicio + array_length(resolucao_opcoes) * margin + 20, "[Clique direito para voltar]");
