function aplicar_autotile(grid, cell_h, cell_v, cell_t, tileset_id, tilemap_id) {
    for (var xx = 0; xx < cell_h; xx++) {
        for (var yy = 0; yy < cell_v; yy++) {
            if (grid[# xx, yy] == 1) {
                var mask = 0;
                var cx = xx, cy = yy;

                var e  = (cx + 1 < cell_h) && grid[# cx + 1, cy    ] == 1;
                var ne = (cx + 1 < cell_h) && (cy - 1 >= 0)     && grid[# cx + 1, cy - 1] == 1;
                var n  = (cy - 1 >= 0)     && grid[# cx,     cy - 1] == 1;
                var nw = (cx - 1 >= 0)     && (cy - 1 >= 0)     && grid[# cx - 1, cy - 1] == 1;
                var w  = (cx - 1 >= 0)     && grid[# cx - 1, cy    ] == 1;
                var sw = (cx - 1 >= 0)     && (cy + 1 < cell_v) && grid[# cx - 1, cy + 1] == 1;
                var s  = (cy + 1 < cell_v) && grid[# cx,     cy + 1] == 1;
                var se = (cx + 1 < cell_h) && (cy + 1 < cell_v) && grid[# cx + 1, cy + 1] == 1;

                var mask = 0;
					if (n)  mask |= 1 << 0;
					if (ne) mask |= 1 << 1;
					if (e)  mask |= 1 << 2;
					if (se) mask |= 1 << 3;
					if (s)  mask |= 1 << 4;
					if (sw) mask |= 1 << 5;
					if (w)  mask |= 1 << 6;
					if (nw) mask |= 1 << 7;

                tilemap_set(tilemap_id, xx, yy, 1);
				tilemap_set_autotile(tilemap_id, xx, yy, mask);


            }
        }
    }
}
