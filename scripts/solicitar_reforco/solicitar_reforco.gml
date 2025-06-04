function solicitar_reforco(sala_origem_id) {
    // Garante que a sala de origem existe no nosso mapa de salas
    if (!ds_map_exists(global.salas, sala_origem_id)) {
        return;
    }

    var sala_origem = global.salas[? sala_origem_id];
    var vizinhos_em_alerta = [];

    // 1. Encontrar salas vizinhas que estão em ALERTA e não são a sala de origem
    for (var i = 0; i < array_length(sala_origem.conexoes); i++) {
        var vizinho_id = sala_origem.conexoes[i];
        if (ds_map_exists(global.salas, vizinho_id)) {
            var sala_vizinha = global.salas[? vizinho_id];
            // Verifica se a sala vizinha está em alerta E se não é a própria sala de origem
            if (sala_vizinha.alerta && sala_vizinha.id != sala_origem_id) {
                array_push(vizinhos_em_alerta, sala_vizinha);
            }
        }
    }

    // 2. Se houver salas vizinhas em alerta, escolha uma para enviar reforço
    if (array_length(vizinhos_em_alerta) > 0) {
        var sala_reforco = vizinhos_em_alerta[irandom(array_length(vizinhos_em_alerta) - 1)]; // Escolhe uma sala aleatoriamente

        // 3. Tenta instanciar um inimigo na sala de reforço
        // Ajuste as coordenadas de spawn para ficarem dentro dos limites da sala de reforço
        // Assumindo que Sala tem .x e .y como coordenadas da célula central
        // E que sala.w e sala.h seriam as dimensões da sala em células
        // Como não vi w/h em Sala struct, estou usando offsets arbitrários, adapte se necessário.
        var spawn_cell_x = irandom_range(sala_reforco.x - 2, sala_reforco.x + 2); // Ex: 5x5 area central da sala
        var spawn_cell_y = irandom_range(sala_reforco.y - 2, sala_reforco.y + 2);

        // Garante que o ponto de spawn está em uma célula de sala válida (não parede/corredor)
        // Você precisará de uma forma de acessar 'grid' do obj_map aqui, talvez passando como argumento
        // ou usando `obj_map.grid`. Eu recomendo `obj_map.grid` já que é uma instância única.
        var map_obj = instance_find(obj_map, 0); // Encontra a instância do obj_map

        if (is_struct(map_obj) && map_obj.grid[# spawn_cell_x, spawn_cell_y] == global.TIPO_SALA) {
            var x_spawn = spawn_cell_x * cell_t + cell_t / 2;
            var y_spawn = spawn_cell_y * cell_t + cell_t / 2;
            
            // Verifique por colisões antes de instanciar para evitar spawnar em cima de algo
            if (!place_meeting(x_spawn, y_spawn, obj_colisao) && !place_meeting(x_spawn, y_spawn, obj_enemy1) && !place_meeting(x_spawn, y_spawn, obj_player)) {
                var novo_inimigo = instance_create_layer(x_spawn, y_spawn, "instances", obj_enemy1);
                novo_inimigo.minha_sala_id = sala_reforco.id; // Atribui a sala de origem
                sala_reforco.inimigos_ativos_count++; // Incrementa o contador da sala

                // Opcional: fazer o inimigo de reforço ir direto para a sala de combate (sala_origem_id)
                // Ele ainda pode usar o pathfinding normal para se aproximar do jogador.
                novo_inimigo.state = enemy1_state_chase; // Force o estado de perseguição
                // Poderia também forçar a perseguição em direção ao jogador específico.
            }
        }
    }
}