var _events = variable_struct_get_names(stage);
array_sort(_events, true);
var _xoffset = 0;
var _yoffset = scrollOffset;
for (var i = 0; i < array_length(_events); ++i) {
	var _time = string_replace(string_replace(_events[i], "m", ""), "s", ":");
	var _x = 10;
    draw_text_transformed(_x, 10 + _yoffset, $"{_time}: ", 2, 2, 0);
	_x += string_width($"{_time}: ") * 2;
	var _text = "+";
	draw_set_color(c_red);
	draw_text_transformed(_x, 10 + _yoffset, _text, 2, 2, 0);
	//draw_rectangle(_x, 10 + _yoffset, _x + string_width(_text) * 2, 10 + _yoffset + string_height(_text) * 2, true);
	if (mouse_check_button_pressed(mb_left) and mouseOnText(_x, 10 + _yoffset, _text, 2)) {
		addEventEvent = true;
		editing = _events[i];
	}
	draw_set_color(c_white);
	_x = 20;
	var _y = 10 + _yoffset;
	_xoffset = 0;
	var _event = stage[$ _events[i]];
	if (_event[$ "addEnemy"] != undefined) {
		_y += 30;
		_text = "Add Enemies: ";
	    draw_text_transformed(_x, _y, _text, 2, 2, 0);
		_xoffset = string_width(_text) * 2;
		for (var j = 0; j < array_length(stage[$ _events[i]][$ "addEnemy"]); ++j) {
			var _enemy = EnemyList[stage[$ _events[i]][$ "addEnemy"][j]];
		    draw_sprite_ext(_enemy[? "sprite"], 0, _x + _xoffset, _y + sprite_get_height(_enemy[? "sprite"]) * 0.85, .75, .75, 0, c_white, 1);
			_xoffset += sprite_get_width(_enemy[? "sprite"]) * .75;
		}
		draw_text_transformed_color(_x + _xoffset, _y, "+", 2, 2, 0, c_green, c_green, c_green, c_green, 1);
		if (mouse_check_button_pressed(mb_left) and mouseOnText(_x + _xoffset, _y, "+", 2)) {
			addToList = true;
			editing = _events[i];
			listToAdd = "addEnemy";
		}
		_yoffset += 30;
	}
	if (_event[$ "delEnemy"] != undefined) {
		_y += 30;
		_text = "Delete Enemies: ";
	    draw_text_transformed(_x, _y, _text, 2, 2, 0);
		_xoffset = string_width(_text) * 2;
		for (var j = 0; j < array_length(_event[$ "delEnemy"]); ++j) {
			var _enemy = EnemyList[_event[$ "delEnemy"][j]];
		    draw_sprite_ext(_enemy[? "sprite"], 0, _x + _xoffset, _y + sprite_get_height(_enemy[? "sprite"]) * 0.85, .75, .75, 0, c_white, 1);
			_xoffset += sprite_get_width(_enemy[? "sprite"]) * .75;
		}
		draw_text_transformed_color(_x + _xoffset, _y, "+", 2, 2, 0, c_green, c_green, c_green, c_green, 1);
		if (mouse_check_button_pressed(mb_left) and mouseOnText(_x + _xoffset, _y, "+", 2)) {
			addToList = true;
			editing = _events[i];
			listToAdd = "delEnemy";
		}
		_yoffset += 30;
	}
	if (_event[$ "event"] != undefined) {
		_y += 30;
		_text = "Event: ";
	    draw_text_transformed(_x, _y, _text, 2, 2, 0);
		_xoffset = string_width(_text) * 2;
		for (var j = 0; j < array_length(_event[$ "event"]); ++j) {
			var _enemy = EnemyList[_event[$ "event"][j][$ "id"]];
			draw_sprite_ext(_enemy[? "sprite"], 0, _x + _xoffset, _y + sprite_get_height(_enemy[? "sprite"]) * 0.85, .75, .75, 0, c_white, 1);
			_xoffset += sprite_get_width(_enemy[? "sprite"]) * .75;
		}
		draw_text_transformed_color(_x + _xoffset, _y, "+", 2, 2, 0, c_green, c_green, c_green, c_green, 1);
		if (mouse_check_button_pressed(mb_left) and mouseOnText(_x + _xoffset, _y, "+", 2)) {
			//addToList = true;
			//editing = _events[i];
			//listToAdd = "event";
		}
		_yoffset += 30;
	}
	_yoffset += 30;
}

if (addEvent) {
	var _x = GW/2;
	var _y = GH/2;
	var _textScale = 2;
	var _text = "";
	var _textsize = 0;
	var _w = 70;
	var _h = 40;
	window(_x, _y, _w, _h, "Add Event");
	_x = _x - _w + 10;
	_y = _y - _h + 30 + 10;
	
	_text = "Time: ";
	_textsize = string_width(_text) * _textScale;
	draw_text_transformed(_x, _y, _text, _textScale, _textScale, 0);
	_x += _textsize;
	
	_text = $"{minutes < 10 ? "0" + string(minutes) : string(minutes)}:";
	_textsize = string_width(_text) * _textScale;
	draw_text_transformed(_x, _y, _text, _textScale, _textScale, 0);
	//draw_rectangle(_x, _y, _x + _textsize, _y + (string_height(_text) * _textScale), true);
	if ((mouse_wheel_up() or mouse_wheel_down()) and mouseOnText(_x, _y, _text, _textScale)) {
	    minutes = minutes + (- mouse_wheel_down() + mouse_wheel_up());
		if (minutes > 60) { minutes = 0; }
		if (minutes < 0) { minutes = 0; }
	}
	_x += _textsize;
	
	_text = $"{seconds < 10 ? "0" + string(seconds) : string(seconds)}";
	_textsize = string_width(_text) * _textScale;
	draw_text_transformed(_x, _y, _text, _textScale, _textScale, 0);
	if ((mouse_wheel_up() or mouse_wheel_down()) and mouseOnText(_x, _y, _text, _textScale)) {
	    seconds = seconds + (- mouse_wheel_down() + mouse_wheel_up());
		if (seconds > 60) { seconds = 0; minutes++; }
		if (seconds < 0) { seconds = 0; }
	}
	_x += _textsize;
}

if (addEventEvent) {
    var _x = GW/2;
	var _y = GH/2;
	var _w = 157;
	var _h = 40;
	window(_x, _y, _w, _h, "Add Event");
	_x = _x - _w + 10;
	_y = _y - _h + 30 + 10;
	var _buttons = [];
	if (stage[$ editing][$ "addEnemy"] == undefined) {
	    array_push(_buttons, "Add Enemy");
	}
	if (stage[$ editing][$ "delEnemy"] == undefined) {
	    array_push(_buttons, "Delete Enemy");
	}
	if (stage[$ editing][$ "event"] == undefined) {
	    array_push(_buttons, "Event");
	}
	for (var i = 0; i < array_length(_buttons); ++i) {
		var _text = _buttons[i];
		var _textScale = 2;
		var _textW = string_width(_text) * _textScale;
		var _textH = string_height(_text) * _textScale;
		draw_set_alpha(0.25);
	    draw_rectangle_color(_x, _y, _x + _textW, _y + _textH, c_black, c_black, c_black, c_black, false);
		draw_set_alpha(1);
	    draw_rectangle_color(_x, _y, _x + _textW + 4, _y + _textH + 3, c_white, c_white, c_white, c_white, true);
		draw_text_transformed(_x + 2, _y, _text, _textScale, _textScale, 0);
		if (mouse_check_button_pressed(mb_left) and mouseOnText(_x + 2, _y, _text, _textScale)) {
		    switch (_text) {
			    case "Add Enemy":
					stage[$ editing][$ "addEnemy"] = [];
			        break;
			    case "Delete Enemy":
					stage[$ editing][$ "delEnemy"] = [];
			        break;
			    case "Event":
					stage[$ editing][$ "event"] = [];
			        break;
			}
			addEventEvent = false;
		}
		_x += _textW + 10;
	}
}
	
if (addToList) {
    var _x = GW/2;
    var _xx = GW/2;
	var _y = GH/2;
	var _w = 75;
	_xx += _w + 10;
	var _h = 57;
	window(_x, _y, _w, _h, $"Add to {listToAdd} on {editing}");
	_x = _x - _w + 10;
	_y = _y - _h + 30 + 10;
	_xoffset = 64;
	_yoffset = 64;
	
	draw_sprite_stretched(EnemyList[selectedEnemy][? "sprite"], enemySubimg[0],  _x, _y, _xoffset, _yoffset);
	draw_rectangle(_x, _y, _x + _xoffset, _y + _yoffset, true);
	if (mouse_check_button_pressed(mb_left) and point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), _x, _y, _x + _xoffset, _y + _yoffset)) {
		selectingEnemy = true;
	}
	_x += _xoffset + 10;
	if (create_button(_x, _y, "Add", 2)) {
		array_push(stage[$ editing][$ listToAdd], selectedEnemy);
		addToList = false;
	}
	_y+=30;
	if (create_button(_x, _y, "Cancel", 2)) {
		addToList = false;
	}
}

if (selectingEnemy) {
    var _x = GW/2 + 250;
	var _y = GH/2;
	var _w = 150;
	var _h = 155;
	window(_x, _y, _w, _h, "Enemies");
	_x = _x - _w + 10;
	_y = _y - _h + 30 + 10;
	var _yoffset = 0;
	if (enemyEnd >= Enemies.Lenght) { enemyEnd = Enemies.Lenght - 1; enemyStart = enemyEnd - 10;}
	if (enemyStart <= 0) { enemyStart = 0; enemyEnd = 10}
	for (var i = enemyStart; i <= enemyEnd; ++i) {
		var _name = EnemyList[i][? "name"];
		if (_name == undefined) {
		    continue;
		}
	    draw_text_transformed(_x, _y + _yoffset, _name, 2, 2, 0);
		if (mouse_check_button_pressed(mb_left) and mouseOnText(_x, _y + _yoffset, _name, 2)) {
			selectedEnemy = i;
			selectingEnemy = false;
		}
		_yoffset += string_height(_name) + 10;
	}
}