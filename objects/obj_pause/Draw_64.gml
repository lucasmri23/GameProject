var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();
var x1 = gui_w / 2;
var y1 = gui_h / 3;
var margin = 35;
var m_x = device_mouse_x_to_gui(0);
var m_y = device_mouse_y_to_gui(0);

if(global.pause){
	draw_set_alpha(.8);
	draw_set_color(c_black);
	draw_rectangle(0,0,gui_w,gui_h,false);
	draw_set_alpha(1);
	draw_set_color(c_white);
	draw_set_font(ft_menu);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_text(gui_w/2,gui_h/9,"Jogo Pausado!");
	draw_set_font(ft_pause);
	for(var i = 0; i  <op_max; i++){
		var y2 = y1 + (margin *i);
		var string_w = string_width(options[i]);
		var string_h = string_height(options[i]);
	
		if(point_in_rectangle(m_x,m_y,x1 - string_w / 2,y2 - string_h / 2,x1 + string_w / 2,y2 + string_h / 2)){
			draw_set_color(c_orange);
			index = i;
			if(mouse_check_button_pressed(mb_left)){
				menu(index);
			}
		}else{
			draw_set_color(c_white);
		}
		draw_text(x1,y2,options[i]);
	}
	draw_set_halign(-1);
	draw_set_valign(-1);
	
}