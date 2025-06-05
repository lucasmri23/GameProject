function menu (index){
	var option = index;
	
	switch(option){
		case 0:
			room_goto_next();
		break;
		case 1:
			instance_create_layer(0, 0, "GUI", obj_opcoes); // Cria o menu de opções
			instance_destroy(); // Remove o menu principal da tela
		break;
		case 2:
			// Mostrar créditos
            obj_creditos.visible = true;
            obj_botao_voltar.visible = true;
            // Esconder o menu principal (opcional)
            obj_menu.visible = false;
		break;
		case 3:
			game_end();
		break;
	
	
	}
}