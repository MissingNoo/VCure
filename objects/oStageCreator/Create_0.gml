file = working_directory + "stage.json";
scrollOffset = 0;
stage = global.stage[$ "Stage1"];
selected = 0;
minutes = 0;
seconds = 0;
addEvent = false;
addEventEvent = false;
editing = "";
window = function (_x, _y, w, h, title){
	var _sizeW = w;
	var _sizeH = h;
	draw_set_color(c_black);
	draw_set_alpha(0.25);
	draw_rectangle(_x - _sizeW, _y - _sizeH, _x + _sizeW, _y +_sizeH, false);
	draw_set_color(c_white);
	draw_set_alpha(1);
	draw_rectangle(_x - _sizeW, _y - _sizeH, _x + _sizeW, _y +_sizeH, true);
	draw_rectangle(_x - _sizeW, _y - _sizeH, _x + _sizeW, _y - _sizeH + 30, true);
}

mouseOnText = function (x, y, text, scale){
	var result = false;
	if (global.debug) {
	    draw_rectangle(x, y, x + (string_width(text) * scale), y + (string_height(text) * scale), true);
	}
	if (point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), x, y, x + string_width(text) * scale, y + string_height(text) * scale)) {
		result = true;
	}
	return result;
}