function mapa_criar_grids() {
    grid = ds_grid_create(cell_h, cell_v);
    ds_grid_clear(grid, 0);

    mp_grid = mp_grid_create(0, 0, cell_h, cell_v, cell_t, cell_t);
    global.grid_pathfinding = mp_grid; // Torna o grid global para os inimigos

    grid_sala = ds_grid_create(cell_h, cell_v);
    ds_grid_clear(grid_sala, -1); // -1 = sem sala
}
