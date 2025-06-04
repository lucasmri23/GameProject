global.TIPO_SALA = 1;
global.TIPO_CORREDOR = 2;
global.num_enemy1 = irandom_range(7, 15);

alerta_inimigo = []; 

var layer_id = layer_get_id("tileset");
var tilemap_id = layer_tilemap_get_id(layer_id);
var layer_chao_id = layer_get_id("tileset_chao");
var tilemap_chao_id = layer_tilemap_get_id(layer_chao_id)

mapa_inicializar_globals();
mapa_criar_grids();
mapa_gerar_dungeon(45); // As salas e global.grafo_salas são criados aqui.
mapa_marcar_tipo_sala();
mapa_pintar_chao_xadrez(tilemap_chao_id);

// --- IMPORTANTE: Mova a inicialização de global.salas PARA CÁ ---
// Inicializa o ds_map global.salas ANTES que mapa_instanciar_inimigos() tente usá-lo.
global.salas = ds_map_create();
// Preenche global.salas com as structs de sala criadas em mapa_gerar_dungeon
for (var i = 0; i < array_length(global.grafo_salas); i++) {
    global.salas[? global.grafo_salas[i].id] = global.grafo_salas[i];
}
// ------------------------------------------------------------------

//Etapa de instanciamento de objetos (Agora essas funções podem usar global.salas)
mapa_popular_tiles_com_colisao(tilemap_id);
mp_grid_add_instances(mp_grid, obj_colisao, false);
mapa_instanciar_player();
mapa_instanciar_inimigos(); // Agora, global.salas já estará inicializado quando esta função for chamada.