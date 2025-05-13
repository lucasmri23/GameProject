cell_t =32;
room_width = cell_t * 40
room_height = room_width div 2;
cell_h = room_width div cell_t;
cell_v = room_height div cell_t;

grid = ds_grid_create(cell_h,cell_v);
ds_grid_clear(grid,0);
mp_grid = mp_grid_create(0,0,cell_h,cell_v,cell_t,cell_t);

// Pega o tilemap da camada 'tileset'
var layer_id = layer_get_id("tileset");
var tilemap_id = layer_tilemap_get_id(layer_id);


randomize();
var dir = irandom(3);
var xx = cell_h div 2;
var yy = cell_v div 2;
var chances = 1;
var passos = 400;
var num_enemy1 = irandom_range(5,15);

for(var i = 0; i<passos; i+=1){
	if(irandom(chances) == chances){
		dir = irandom(3);
	}
	xx+=lengthdir_x(1,dir*90);
	yy+=lengthdir_y(1,dir*90);

	xx = clamp(xx,2,cell_h-2);
	yy = clamp(yy,2,cell_v-2);
	
	grid[# xx,yy] = 1;
}

for(var xx = 0;xx<cell_h;xx++){
	for(var yy = 0;yy<cell_v;yy++){
		if (grid[# xx, yy] == 0) {
			// Cria o tile usando autotile
			tilemap_autotile(tilemap_id, xx, yy, true);
    
			// Coloca colisão como antes 
			instance_create_layer(xx * cell_t, yy * cell_t, "instances", obj_colisao);
		}
		if(grid[# xx,yy] ==1 ){
			var x1 = xx*cell_t+cell_t/2;
			var y1 = yy*cell_t+cell_t/2;
			if(!instance_exists(obj_player)){
				instance_create_layer(x1,y1,"instances",obj_player);
			}
			if(num_enemy1>0){
				var chances = 15;
				var enemy_min_dist_player = 150;
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
						num_enemy1 -= 1;
					}
				}
			}
			
		}
		
	}
}

mp_grid_add_instances(mp_grid,obj_colisao,false);