life = 10;
death_started = false;
depth = (-y)+10;

cell_t = 32;
mapa = instance_find(obj_map, 0);
caminho = path_add();
velc = 1.2;

ultima_sala_jogador = -1;
visao = 100;

alcance_ataque = 20;
atk_cd = 0;

path_atual = -1;
tempo_path_recalc = 0;
path_delay = 10;

state = enemy1_state_idle;
last_state = state;

estado = "patrulha"; // Estado interno (patrulha, perseguição)
alertou = false; // Indica se este inimigo já propagou o alerta via BFS para sua sala atual

// Variáveis para o sistema de reforço
minha_sala_id = -1; // O ID da sala em que este inimigo está. Atribuído ao ser criado.
tempo_prox_reforco = 0; // Contador para o cooldown de pedido de reforço
tempo_reforco_cooldown = 60; // Cooldown de 3 segundos (60 frames/seg * 3)