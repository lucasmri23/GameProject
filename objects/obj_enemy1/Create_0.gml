life = 10;

cell_t = 32;
mapa = instance_find(obj_map, 0);
caminho = path_add();
velc = 1.2;

ultima_sala_jogador = -1;
visao = 100

path_atual = -1;
tempo_path_recalc = 0;
path_delay = 10;

estado = "patrulha";
alertou = false;