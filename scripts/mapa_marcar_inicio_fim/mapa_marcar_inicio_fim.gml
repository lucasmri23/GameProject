function mapa_marcar_inicio_fim() {
    if (array_length(global.grafo_salas) > 0) {
        global.grafo_salas[0].tipo = "inicial";
        global.grafo_salas[global.grafo_salas_length_last].tipo = "final";
    }
}
