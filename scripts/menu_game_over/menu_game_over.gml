function menu_game_over(index){
	var option = index;
	
	switch(option){
		case 0:
			room_goto(Room1);
		break;
		case 1:
			room_goto(Room_menu);
		break;
		case 2:
			game_end();
		break;
	}
}