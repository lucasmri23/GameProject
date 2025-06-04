function propagar_alerta_bfs(sala_origem_id, profundidade_maxima) {
    // Sempre crie as estruturas de dados no início da função
    var visitadas = ds_map_create();
    var bfs_fila = ds_queue_create();

    // Adiciona verificações para garantir que as estruturas foram criadas com sucesso
    // ds_map_create() e ds_queue_create() devem sempre retornar um número válido (ID).
    // No entanto, é uma boa prática defensiva verificar.
    if (!is_real(visitadas) || visitadas < 0 || !is_real(bfs_fila) || bfs_fila < 0) {
        // Se a criação falhou, destrua o que pode ter sido criado e saia para evitar mais erros.
        if (is_real(visitadas) && visitadas >= 0) ds_map_destroy(visitadas);
        if (is_real(bfs_fila) && bfs_fila >= 0) ds_queue_destroy(bfs_fila);
        show_debug_message("ERRO: Falha ao criar DS structures em propagar_alerta_bfs.");
        return; // Sai da função
    }

    // --- Início do bloco de lógica principal ---
    var _success = false;

    if (ds_map_exists(global.salas, sala_origem_id)) {
        ds_queue_enqueue(bfs_fila, [sala_origem_id, 0]);

        // Verifique novamente se bfs_fila ainda é uma ID de fila válida antes do loop
        // Isso é redundante se a criação acima foi bem-sucedida, mas útil para depurar.
        if (ds_queue_exists(bfs_fila)) {
            while (!ds_queue_is_empty(bfs_fila)) {
                var info = ds_queue_dequeue(bfs_fila);
                var sala_id = info[0];
                var profundidade = info[1];

                if (ds_map_exists(visitadas, sala_id)) {
                    continue;
                }

                visitadas[? sala_id] = true;

                if (!ds_map_exists(global.salas, sala_id)) {
                    continue;
                }
                var sala = global.salas[? sala_id];
                sala.alerta = true;

                if (profundidade < profundidade_maxima) {
                    var vizinhos = sala.conexoes;
                    for (var i = 0; i < array_length(vizinhos); i++) {
                        var vizinho_id = vizinhos[i];
                        if (!ds_map_exists(visitadas, vizinho_id)) {
                            ds_queue_enqueue(bfs_fila, [vizinho_id, profundidade + 1]);
                        }
                    }
                }
            }
            _success = true;
        } else {
            show_debug_message("AVISO: bfs_fila se tornou inválida antes do loop BFS.");
        }
    }
    // --- Fim do bloco de lógica principal ---

    // Sempre destrua as estruturas de dados no final
    ds_map_destroy(visitadas);
    ds_queue_destroy(bfs_fila);
}