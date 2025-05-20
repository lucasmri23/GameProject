function mapa_popular_tiles_e_instancias(tilemap_id){
	for(var xx = 0;xx<cell_h;xx++){
		for(var yy = 0;yy<cell_v;yy++){
			if (grid[# xx, yy] == 0) {
				// Cria o tile usando autotile parede
				tilemap_autotile(tilemap_id, xx, yy, true);
				// Coloca colisão como antes 
				instance_create_layer(xx * cell_t, yy * cell_t, "instances", obj_colisao);
			}
		if (grid[# xx, yy] == global.TIPO_SALA || grid[# xx, yy] == global.TIPO_CORREDOR) {
			
			//Tiles para o chão
			//tilemap_set(tilemap_id, 47, xx, yy);
			
			var x1 = xx*cell_t+cell_t/2;
			var y1 = yy*cell_t+cell_t/2;
			if(!instance_exists(obj_player)){
				instance_create_layer(x1,y1,"instances",obj_player);
			}
			if(global.num_enemy1>0){
				var chances = 5;
				var enemy_min_dist_player = 130;
				var enemy_min_dist_other = 100;
				
				if(irandom(chances)== chances){
					
					var dist_to_player = point_distance(x1, y1, obj_player.x, obj_player.y);
					var is_far_from_player = dist_to_player > enemy_min_dist_player;
					var is_far_from_others = true;
					
				// Verifica distância de TODOS os inimigos já existentes
					with (obj_enemy1) {
						if (point_distance(x, y, x1, y1) < enemy_min_dist_other) {
							is_far_from_others = false;
						}
					}
					
					if (is_far_from_player and is_far_from_others) {
						instance_create_layer(x1, y1, "instances", obj_enemy1);
						global.num_enemy1 -= 1;
					}
				}
			}
			
		}
		
	}
}
}