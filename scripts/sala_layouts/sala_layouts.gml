function sala_layouts(){

//sala 5x5 normal
var layout_5x5 = [
	[0,0,0,0,0],
    [0,1,1,1,0],
    [0,1,1,1,0],
    [0,1,1,1,0],
    [0,0,0,0,0]	
];

//sala 5x5 com obstaculo central
var layout_5x5_c = [
	[0,0,0,0,0],
    [0,1,1,1,0],
    [0,1,0,1,0],
    [0,1,1,1,0],
    [0,0,0,0,0]
];

// sala pequena 4x4
var layout_4x4 = [
	[0,0,0,0],
	[0,1,1,0],
	[0,1,1,0],
	[0,0,0,0]
];

// sala T
var layout_T = [
	[0,0,0,0,0],
	[0,1,1,1,0],
	[0,0,1,0,0],
	[0,0,1,0,0],
	[0,0,1,0,0]
];

//sala corredor H
var layout_c_horizontal = [
	[0,0,0,0,0,0,0],
	[0,1,1,1,1,1,0],
	[0,1,1,1,1,1,0],
	[0,0,0,0,0,0,0]
];

//sala corredor V
var layout_c_vertical = [
	[0,0,0,0],
	[0,1,1,0],
	[0,1,1,0],
	[0,1,1,0],
	[0,1,1,0],
	[0,1,1,0],
	[0,0,0,0]
];

//sala gigante
var layout_7x7 = [
	[0,0,0,0,0,0,0],
	[0,1,1,1,1,1,0],
	[0,1,1,1,1,1,0],
	[0,1,1,1,1,1,0],
	[0,1,1,1,1,1,0],
	[0,1,1,1,1,1,0],
	[0,0,0,0,0,0,0]
];
//sala gigante com obstaculo 1
var layout_7x7_c1 = [
	[0,0,0,0,0,0,0],
	[0,1,1,1,1,1,0],
	[0,1,1,0,1,1,0],
	[0,1,0,0,0,1,0],
	[0,1,1,0,1,1,0],
	[0,1,1,1,1,1,0],
	[0,0,0,0,0,0,0]
];
//sala gigante com obstaculo 2
var layout_7x7_c2 = [
	[0,0,0,0,0,0,0],
	[0,0,1,1,1,0,0],
	[0,1,1,1,1,1,0],
	[0,0,0,1,0,0,0],
	[0,1,1,1,1,1,0],
	[0,0,1,1,1,0,0],
	[0,0,0,0,0,0,0]
];

	global.salas_layouts = [];
	array_push(global.salas_layouts, layout_5x5);
	array_push(global.salas_layouts, layout_5x5_c);
	array_push(global.salas_layouts, layout_4x4);
	array_push(global.salas_layouts, layout_T);
	array_push(global.salas_layouts, layout_c_horizontal);
	array_push(global.salas_layouts, layout_c_vertical);
	array_push(global.salas_layouts, layout_7x7);
	array_push(global.salas_layouts, layout_7x7_c1);
	array_push(global.salas_layouts, layout_7x7_c2);
}



