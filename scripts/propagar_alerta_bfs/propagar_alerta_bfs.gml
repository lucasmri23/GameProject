function propagar_alerta_bfs(sala_origem_id, profundidade_maxima) {
    if (!ds_map_exists(global.salas, sala_origem_id)) {
        return;
    }

    var visitadas = ds_map_create();
    var bfs_fila = ds_queue_create();

    ds_queue_enqueue(bfs_fila, [sala_origem_id, 0]);

    while (!ds_queue_is_empty(bfs_fila)) {
        var info = ds_queue_dequeue(bfs_fila);
        var sala_id = info[0];
        var profundidade = info[1];

        if (ds_map_exists(visitadas, sala_id)) {
            continue;
        }

        visitadas[? sala_id] = true;

        if (!ds_map_exists(global.salas, sala_id)) continue;
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

    ds_map_destroy(visitadas);
    ds_queue_destroy(bfs_fila);
}
