function menu (index){
	var option = index;
	
	switch(option){
		case 0:
			room_goto_next();
		break;
		case 1:
			// Mostrar créditos
            obj_creditos.visible = true;
            obj_botao_voltar.visible = true;
            // Esconder o menu principal (opcional)
            obj_menu.visible = false;
		break;
		case 2:
		break;
		case 3:
			game_end();
		break;
	
	
	}
}