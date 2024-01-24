//Feather disable all
#macro MX device_mouse_x_to_gui(0)
#macro MY device_mouse_y_to_gui(0)
#macro mouse_click device_mouse_check_button_pressed(0, mb_left)
#macro mouse_hold device_mouse_check_button(0, mb_right)
function mouse_on_area(area){
	var result = false;
	if (point_in_rectangle(MX, MY, area[0], area[1], area[2], area[3])) {
	    result = true;
	}
	return result;
}
function click_on_area(area){
	var result = false;
	if (mouse_on_area(area) and mouse_click) {
	    result = true;
	}
	return result;
}
function hold_on_area(area){
	//draw_rectangle(area[0], area[1], area[2], area[3], true);
	var result = false;
	if (mouse_on_area(area) and mouse_hold) {
	    result = true;
	}
	return result;
}
function button_arrow(dir, x, y){
	var result = false;
	var spr = undefined;
	var sprnumber = 0;
	switch (dir) {
	    case 0:
			spr = DebugArrowButtonLeftRight;
			sprnumber = 1;
	        break;
	    case 1:
			spr = DebugArrowButtonUpDown;
			sprnumber = 1;
	        break;
	    case 2:
			spr = DebugArrowButtonLeftRight;
			sprnumber = 0;
	        break;
	    case 3:
			spr = DebugArrowButtonUpDown;
			sprnumber = 0;
	        break;
	}
	draw_sprite_ext(spr, sprnumber, x, y, 1, 1, 0, c_white, 1);
	if (click_on_area([x, y, x + sprite_get_width(spr), y + sprite_get_height(spr)]) or hold_on_area([x, y, x + sprite_get_width(spr), y + sprite_get_height(spr)])) {
	    result = true;
	}
	return result;
}

function button_updown(x, y, text, variable, step){
	var h = sprite_get_height(DebugArrowButtonUpDown);
	var w = sprite_get_width(DebugArrowButtonUpDown);
	var up = button_arrow(3, x, y);
	var down = button_arrow(1, x, y + h + 1);
	draw_text_transformed(x + w, y + 5, text, 1.5, 1.5, 0);
	var result = up - down;
	variable_instance_set(self, variable, variable_instance_get(self, variable) + (step * result));
	yy += 50;
}

function debug_text_button(x, y, text){
	var textsize = string_width(text) + 4;
	var textheight= string_height(text) + 4;
	var area = [x, y, x + textsize, y + textheight];
	draw_set_alpha(.5);
	draw_set_color(c_black);
	draw_rectangle(x, y, x + textsize, y + textheight, false);
	draw_set_alpha(1);
	draw_set_color(c_white);
	draw_rectangle(x, y, x + textsize, y + textheight, true);	
	draw_text_transformed(x + 2, y + 2, text, 1, 1, 0);
	yy += 30;
	return click_on_area(area);	
}