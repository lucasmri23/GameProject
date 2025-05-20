function mapa_popular_tiles_com_colisao(tilemap_id){
	for (var xx = 0; xx < cell_h; xx++) {
		for (var yy = 0; yy < cell_v; yy++) {
			if (grid[# xx, yy] == 0) {
				tilemap_autotile(tilemap_id, xx, yy, true);
				instance_create_layer(xx * cell_t, yy * cell_t, "instances", obj_colisao);
			}
		}
	}
}