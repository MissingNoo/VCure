//Feather disable all
#macro MX device_mouse_x_to_gui(0)
#macro MY device_mouse_y_to_gui(0)
#macro mouse_click device_mouse_check_button_pressed(0, mb_left)
#macro mouse_click_right device_mouse_check_button_pressed(0, mb_right)
#macro mouse_hold device_mouse_check_button(0, mb_right)
#macro mouse_hold_left device_mouse_check_button(0, mb_left)
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

function button_updown(x, y, text, variable, step, instance = self){
	var h = sprite_get_height(DebugArrowButtonUpDown);
	var w = sprite_get_width(DebugArrowButtonUpDown);
	var up = button_arrow(3, x, y);
	var down = button_arrow(1, x, y + h + 1);
	draw_text_transformed(x + w + 2, y + 5, $"{text}: {variable_instance_get(instance, variable)}", 1.5, 1.5, 0);
	var result = up - down;
	variable_instance_set(instance, variable, (variable_instance_get(instance, variable) + (step * result)));
	yy += yyStep[DebugTypes.UpDown];
}

function debug_text_button(x, y, text, func){
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
	yy += yyStep[DebugTypes.Button];
	if (click_on_area(area) and !is_undefined(func)) {
	    func();
	}
}
	
function debug_checkbox(x, y, variable, text, instance = self){
	draw_rectangle(x, y, x + 16, y + 16, true);
	if (click_on_area([x, y, x + 16, y + 16])) {
	    variable_instance_set(instance, variable, !variable_instance_get(instance, variable));
	}
	var foo = variable_instance_get(instance, variable);
	if (foo) {
	    draw_line(x, y, x + 16, y + 16);
	    draw_line(x + 16, y, x, y + 16);
	}
	draw_text_transformed(x + 18, y - 5, text, 1.25, 1.25, 0);
	yy += yyStep[DebugTypes.Checkbox];
	return foo;
}