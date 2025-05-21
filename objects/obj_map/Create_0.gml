global.TIPO_SALA = 1;
global.TIPO_CORREDOR = 2;
global.num_enemy1 = irandom_range(7, 15);

alerta_inimigo = [];

var layer_id = layer_get_id("tileset");
var tilemap_id = layer_tilemap_get_id(layer_id);

mapa_inicializar_globals();
mapa_criar_grids();
mapa_gerar_dungeon(45);
mapa_marcar_tipo_sala();

//Etapa de instanciamento de objetos
mapa_popular_tiles_com_colisao(tilemap_id);
mp_grid_add_instances(mp_grid, obj_colisao, false);
mapa_instanciar_player();
mapa_instanciar_inimigos();