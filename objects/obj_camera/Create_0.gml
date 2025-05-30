resolution_width = 1920;
resolution_height = 1080;
resolution_scale = 6; // define a escala, o quão perto a câmera vai ficar
global.view_width = resolution_width / resolution_scale;
global.view_height = resolution_height / resolution_scale;
view_target = obj_player;
view_spd = 0.1;
window_set_size(global.view_width * resolution_scale,global.view_height * resolution_scale);
surface_resize(application_surface,global.view_width * resolution_scale,global.view_height * resolution_scale);
display_set_gui_size(global.view_width,global.view_height);
alarm[0] =1; //centraliza a janela