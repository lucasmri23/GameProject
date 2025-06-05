// Defaults
if (!variable_global_exists("resolution_width_selected")) {
    global.resolution_width_selected = 1920;
    global.resolution_height_selected = 1080;
    global.resolution_scale_selected = 6;
}

resolution_width  = global.resolution_width_selected;
resolution_height = global.resolution_height_selected;
resolution_scale  = global.resolution_scale_selected;

global.view_width  = resolution_width / resolution_scale;
global.view_height = resolution_height / resolution_scale;

window_set_size(global.view_width * resolution_scale, global.view_height * resolution_scale);
surface_resize(application_surface, global.view_width * resolution_scale, global.view_height * resolution_scale);
display_set_gui_size(global.view_width, global.view_height);

alarm[0] =1; //centraliza a janela