function mapa_criar_corredor(xx, yy, dir, length) {
    for (var i = 0; i < length; i++) {
        grid[# xx, yy] = 2;
        xx += lengthdir_x(1, dir * 90);
        yy += lengthdir_y(1, dir * 90);
        xx = clamp(xx, 3, cell_h - 3);
        yy = clamp(yy, 3, cell_v - 3);
    }
    return [xx, yy]; // retorna nova posição
}