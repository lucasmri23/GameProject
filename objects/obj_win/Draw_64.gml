draw_set_font(ft_game_over);
var gui_width = display_get_gui_width();
var gui_height = display_get_gui_height(); 
var margin = 80;
var m_x = device_mouse_x_to_gui(0);
var m_y = device_mouse_y_to_gui(0);

draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(c_yellow);
draw_text(gui_width/2,gui_height/9,"Você Venceu!!");

var frame = min(0, sprite_get_number(spr_player_def) - 1);
var escala = 8;
draw_sprite_ext(spr_player_def, frame, gui_width / 2, (gui_height / 9) + margin, escala, escala, 0, c_white, 1);

var x1 = gui_width / 2;
var sprite_h = sprite_get_height(spr_player_def) * escala;
var sprite_y = (gui_height / 9) + margin;
var y1 = sprite_y + sprite_h / 2 + margin;

draw_set_font(ft_pause);
	for(var i = 0; i  <op_max; i++){
		var y2 = y1 + (margin *i);
		var string_w = string_width(options[i]);
		var string_h = string_height(options[i]);
	
		if(point_in_rectangle(m_x,m_y,x1 - string_w / 2,y2 - string_h / 2,x1 + string_w / 2,y2 + string_h / 2)){
			draw_set_color(c_orange);
			index = i;
			if(mouse_check_button_pressed(mb_left)){
				menu_win(index);
			}
		}else{
			draw_set_color(c_white);
		}
		draw_text(x1,y2,options[i]);
	}