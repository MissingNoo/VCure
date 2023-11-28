file = working_directory + "stage.json";
scrollOffset = 0;
stage = global.stage[$ "Stage1"];
selected = 0;
minutes = 0;
seconds = 0;
addEvent = false;
addEventEvent = false;
editing = "";
selectedEnemy = 0;
selectingEnemy = false;
addToList = false;
listToAdd = "";
enemyStart = 0;
enemyEnd = 10;
enemySubimg = [0, 0, 0];
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

// Feather disable once GM2017
create_button = function(_x, _y, text, textscale, bgalpha = 0.25) {
	var _clicked = false;
	var w = string_width(text) * textscale;
	var h = string_height(text) * textscale;	
	draw_set_color(c_black);
	draw_set_alpha(bgalpha);
	draw_rectangle(_x, _y, _x + w, _y + h, false);
	draw_set_color(c_white);
	draw_set_alpha(1);
	draw_rectangle(_x, _y, _x + w, _y + h, true);
	draw_text_transformed(_x, _y, text, textscale, textscale, 0);
	if (mouse_check_button_pressed(mb_left) and point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), _x, _y, _x + w, _y + h)) {
		_clicked = true;
	}
	return _clicked;
}