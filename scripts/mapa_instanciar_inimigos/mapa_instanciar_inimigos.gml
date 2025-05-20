function mapa_instanciar_inimigos(){
	for (var xx = 0; xx < cell_h; xx++) {
		for (var yy = 0; yy < cell_v; yy++) {
			if (grid[# xx, yy] == global.TIPO_SALA && global.num_enemy1 > 0) {
				var chances = 5;
				var enemy_min_dist_player = 130;
				var enemy_min_dist_other = 100;

				if (irandom(chances) == chances) {
					var x1 = xx * cell_t + cell_t / 2;
					var y1 = yy * cell_t + cell_t / 2;

					var is_far_from_player = true;
					if (instance_exists(obj_player)) {
						var dist_to_player = point_distance(x1, y1, obj_player.x, obj_player.y);
						is_far_from_player = dist_to_player > enemy_min_dist_player;
					}

					var is_far_from_others = true;
					with (obj_enemy1) {
						if (point_distance(x, y, x1, y1) < enemy_min_dist_other) {
							is_far_from_others = false;
						}
					}

					if (is_far_from_player && is_far_from_others) {
						instance_create_layer(x1, y1, "instances", obj_enemy1);
						global.num_enemy1 -= 1;
					}
				}
			}
		}
	}
}