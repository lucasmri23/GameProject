function menu_pause (index){
	var option = index;
	
	switch(option){
		case 0:
			global.pause = false;
		break;
		case 1:
			room_restart();
		break;
		case 2:
		break;
		case 3:
			global.pause = false; // Garante que o jogo esteja despausado
			room_goto(Room_menu);
		break;
		case 4:
			game_end();
		break;
	
	
	}
}