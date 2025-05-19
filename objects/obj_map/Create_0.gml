//struct das salas
function Sala(_id,_x,_y)constructor{
	id = _id;
	x = _x;
	y = _y;
	conexoes = [];
	tipo = "comum";
}


cell_t =32;
room_width = cell_t * 40
room_height = room_width div 2;
cell_h = room_width div cell_t;
cell_v = room_height div cell_t;

// Tipos de célula
var TIPO_SALA = 1;
var TIPO_CORREDOR = 2;

grid = ds_grid_create(cell_h,cell_v);
ds_grid_clear(grid,0);
mp_grid = mp_grid_create(0,0,cell_h,cell_v,cell_t,cell_t);
grid_sala = ds_grid_create(cell_h, cell_v);
ds_grid_clear(grid_sala, -1); // -1 indica "sem sala"


global.grafo = ds_map_create(); // Grafo: sala -> lista de conexões
global.grafo_salas = [];global.grafo_salas_length_last = -1;// Lista para armazenar coordenadas das salas
global.exibir_grafo = false;    // Toggle para desenhar ou não

// Pega o tilemap da camada 'tileset'
var layer_id = layer_get_id("tileset");
var tilemap_id = layer_tilemap_get_id(layer_id);

randomize();
var dir = irandom(3);
var xx = cell_h div 2;
var yy = cell_v div 2;
//teste dungeon
var room_count = 45;
var room_size = 1;
var num_enemy1 = irandom_range(7,15);

function sala_ja_existente(xx, yy, dist_minima = 3) {
    for (var i = 0; i < array_length(global.grafo_salas); i++) {
        var sala = global.grafo_salas[i];
        if (point_distance(sala.x, sala.y, xx, yy) <= dist_minima) {
            return i; // já existe, retorna o índice
        }
    }
    return -1; // não existe
}

for(var i = 0; i<room_count; i++){
	ds_grid_set_region(grid, xx - room_size, yy - room_size, xx + room_size, yy + room_size, TIPO_SALA);
	var path_distance = room_size*6;
	
	while(path_distance>0){
		grid[# xx, yy] = TIPO_CORREDOR;
		xx+=lengthdir_x(1,dir*90);
		yy+=lengthdir_y(1,dir*90);
		xx = clamp(xx,3,cell_h-3);
		yy = clamp(yy,3,cell_v-3);
		path_distance--;
	}
if(path_distance == 0){
    //cria sala na grid
    ds_grid_set_region(grid, xx - room_size, yy - room_size, xx + room_size, yy + room_size, TIPO_SALA);

    // verifica se já existe uma sala próxima
    var sala_existente = sala_ja_existente(xx, yy, 2); // distância em células (ajuste se necessário)
    var sala_index;

    if (sala_existente == -1) {
        var sala_index = array_length(global.grafo_salas);
		var nova_sala = new Sala(sala_index, xx, yy);
		array_push(global.grafo_salas, nova_sala);
		// Mapeia as células dessa sala na grid_sala
		for (var i = xx - room_size; i <= xx + room_size; i++) {
			for (var j = yy - room_size; j <= yy + room_size; j++) {
				grid_sala[# i, j] = sala_index;
			}
		}
        var conexoes = ds_list_create();
        ds_map_add(global.grafo, string(sala_index), conexoes);
    } else {
        sala_index = sala_existente;
    }

    // conecta com sala anterior, se não for a primeira
    if (global.grafo_salas_length_last != -1 && sala_index != global.grafo_salas_length_last) {
		var sala_anterior = global.grafo_salas[global.grafo_salas_length_last];
		var sala_atual = global.grafo_salas[sala_index];

		array_push(sala_anterior.conexoes, sala_index);
		array_push(sala_atual.conexoes, global.grafo_salas_length_last);
    }

    // salva o índice da última sala registrada válida
    global.grafo_salas_length_last = sala_index;

    dir = irandom(3);
}

}

for(var xx = 0;xx<cell_h;xx++){
	for(var yy = 0;yy<cell_v;yy++){
		if (grid[# xx, yy] == 0) {
			// Cria o tile usando autotile parede
			tilemap_autotile(tilemap_id, xx, yy, true);
			// Coloca colisão como antes 
			instance_create_layer(xx * cell_t, yy * cell_t, "instances", obj_colisao);
		}
		if (grid[# xx, yy] == TIPO_SALA || grid[# xx, yy] == TIPO_CORREDOR) {
			
			//Tiles para o chão
			//tilemap_set(tilemap_id, 47, xx, yy);
			
			var x1 = xx*cell_t+cell_t/2;
			var y1 = yy*cell_t+cell_t/2;
			if(!instance_exists(obj_player)){
				instance_create_layer(x1,y1,"instances",obj_player);
			}
			if(num_enemy1>0){
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
						num_enemy1 -= 1;
					}
				}
			}
			
		}
		
	}
}

mp_grid_add_instances(mp_grid,obj_colisao,false);
if (array_length(global.grafo_salas) > 0) {
    global.grafo_salas[0].tipo = "inicial";
    global.grafo_salas[global.grafo_salas_length_last].tipo = "final";
}