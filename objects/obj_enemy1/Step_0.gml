switch(estado){
	case "parado":
		if (instance_exists(obj_player)) {
			var range = 100;
			var vision = collision_line(x,y,obj_player.x,obj_player.y,obj_colisao,false,true)
			if(distance_to_object(obj_player)<= range and !vision){
				//segue
				estado = "perseguicao";
		}
	}
		
	break;
	case "perseguicao":
		var x1 = x;
		var y1 = y;
		var x2 = (obj_player.x div 32)*32 + 16;
		var y2 = (obj_player.y div 32)*32 + 16;

		if(mp_grid_path(obj_map.mp_grid,caminho,x1,y1,x2,y2,true)){
			path_start(caminho, velc, path_action_stop,false);
	break;
		}
}