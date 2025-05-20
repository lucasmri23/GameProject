function mapa_instanciar_player(){
	function mapa_instanciar_player() {
		if (!instance_exists(obj_player)) {
			var x1 = global.sala_inicial.x * cell_t + cell_t / 2;
			var y1 = global.sala_inicial.y * cell_t + cell_t / 2;
			instance_create_layer(x1, y1, "instances", obj_player);
	}
}
}