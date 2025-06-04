function Sala(_id, _x, _y) constructor {
    id = _id;
    x = _x;
    y = _y;
    conexoes = [];
    tipo = "comum";
	alerta = false;
    inimigos_ativos_count = 0; // Adicionada para o sistema de reforço/desativação de alerta
}