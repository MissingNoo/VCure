file = working_directory + "stage.json";
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