file = game_save_id + "stage.json";
//f = file_text_open_write(file);
savedFile = game_save_id + "stage.bin";
stage = {};
//feather disable once GM2017
stage = global.stage.Stage1;
filter = "";
//if (file_exists(savedFile)) {
//	fs = file_text_open_read(savedFile);
//	var _json = file_text_read_string(fs);
//	file_text_close(fs);
//	stage = json_parse(_json);
//}
//else{
//	stage = {};
//}
scrollOffset = 0;
//stage = {};
selected = 0;
minutes = 0;
seconds = 0;
addEvent = false;
addEventEvent = false;
editing = "";
editIndex = 0;
isEnemyEvent = false;
//type, hp, atk, spd, xp, lifetime, quantity, r = 400, distanceDie = "-", followPlayer = false, offset = 2){
#region event
hp = 0;
atk = 0;
spd = 0;
xp = 0;
amount = 0;
followPlayer = 0;
offset = 0;
pattern = 0;
lifetime = 0;
#endregion
eventstats = [[sHudHPIcon, "hp"], [sHudAtkIcon, "atk"], [sHudSpdIcon, "spd"], [sXP, "xp"], ["amount", "amount"], ["follow player", "followPlayer"], ["offset", "offset"], ["lifetime", "lifetime"], ["pattern", "pattern"]];
selectedEnemy = 0;
selectingEnemy = false;
addToList = false;
listToAdd = "";
enemyStart = 0;
enemyEnd = 10;
enemySubimg = [0, 0, 0];
enemySubImgs = [];
for (var i = 0; i < Enemies.Lenght; ++i) {
	var _enemy = EnemyList[i][? "sprite"];
	if (_enemy == undefined) {
	    enemySubImgs[i] = "error";
		continue;
	}
	var maxSubImg = sprite_get_number(_enemy);
	var spdSubImg = sprite_get_speed(_enemy);
    enemySubImgs[i] = [0, maxSubImg, spdSubImg];
}
editEnemy = false;
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
	DEBUG
	    draw_rectangle(x, y, x + (string_width(text) * scale), y + (string_height(text) * scale), true);
	ENDDEBUG
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
	draw_rectangle(_x - 3, _y - 4, _x + w + 2, _y + h + 4, false);
	draw_set_color(c_white);
	draw_set_alpha(1);
	draw_rectangle(_x - 3, _y - 4, _x + w + 2, _y + h + 4, true);
	draw_text_transformed(_x, _y, text, textscale, textscale, 0);
	if (mouse_check_button_pressed(mb_left) and point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), _x, _y, _x + w, _y + h)) {
		_clicked = true;
	}
	return _clicked;
}