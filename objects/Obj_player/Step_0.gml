var tecla_direita = keyboard_check(ord("D"));
var tecla_esquerda = keyboard_check(ord("A")); 
var tecla_cima = keyboard_check(ord("W"));
var tecla_baixo = keyboard_check(ord("S")); 
var teclas = tecla_direita-tecla_esquerda != 0 or tecla_baixo-tecla_cima !=0; 
move_dir = point_direction(0,0,tecla_direita-tecla_esquerda,tecla_baixo-tecla_cima);

velh=lengthdir_x(velc*teclas,move_dir);
velv=lengthdir_y(velv*teclas,move_dir);


x+=velh;
y+=velv;