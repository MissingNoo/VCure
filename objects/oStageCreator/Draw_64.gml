time.draw(100, 50);
draw_set_font(global.newFont[1]);
var _events = variable_struct_get_names(stage);
array_sort(_events, true);
var _xoffset = 0;
var _yoffset = scrollOffset;
for (var i = 0; i < array_length(_events); ++i) {
	//if (filter != "") {
	//	if (stage[$ _events[i]][$ filter] == undefined) {
	//		continue;
			//if (stage[$ _events[i]][$ "addEnemy"] == undefined and stage[$ _events[i]][$ "delEnemy"] == undefined and stage[$ _events[i]][$ "event"] == undefined) {
			//    //nothing
			//}	
			//else{
			//	continue;
			//}
	//	}
	//}
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
	var _eventNames = variable_struct_get_names(_event);
	for (var j = 0; j < array_length(_eventNames); ++j) {
		if (filter != "") {
		    if (filter != _eventNames[j]) {
			    continue;
			}
		}
	    _y += 30;
		
		_text = $"{_eventNames[j]}: ";
	    draw_text_transformed(_x, _y, _text, 2, 2, 0);
		_xoffset = string_width(_text) * 2;
		for (var k = 0; k < array_length(_event[$ _eventNames[j]]); ++k) {
			var _enemy = 0;
			var _enemyId = 0;
			var _isEvent = false;
			switch (_eventNames[j]) {
				default:
					_enemyId = _event[$ _eventNames[j]][k];
			        break;
			    case "event":
					_isEvent = true;
					_enemyId = _event[$ _eventNames[j]][k][$ "id"];
			        break;
			}
			_enemy = EnemyList[_enemyId];
			var _sprite = _enemy[? "sprite"];
			draw_sprite_ext(_sprite, enemySubImgs[_enemyId][0], _x + _xoffset, _y + sprite_get_height(_enemy[? "sprite"]) * 0.85, .75, .75, 0, c_white, 1);
			var _xx = _x + _xoffset - (sprite_get_width(_sprite) * 0.75) / 2;
			var _xxx = _x + _xoffset + (sprite_get_width(_sprite) * 0.75) / 2;
			var _yy = _y + sprite_get_height(_enemy[? "sprite"]) * 0.85;
			var _yyy = _y;
			if (point_distance(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), _xx, _yy) < 15 or point_distance(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), _xxx, _yyy) < 15) {
			    draw_rectangle(_xx, _yy, _xxx, _yyy, true);
				draw_text(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), _enemy[? "name"]);
			//}
			//if (point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), _xx, _yy, _xxx, _yyy)) {
			    if (mouse_check_button_pressed(mb_right)) {
					editing = _events[i];
					listToAdd = _eventNames[j];
					editIndex = k;
					array_delete(stage[$ editing][$ listToAdd], editIndex, 1);
				}
			    if (mouse_check_button_pressed(mb_left)) {
					    selectedEnemy = _enemyId;
						editing = _events[i];
						listToAdd = _eventNames[j];
						editIndex = k;
						editEnemy = true;
						addToList = true;
						isEnemyEvent = _isEvent;
						followPlayer = true;
						radius = 0;
						for (var l = 0; l < array_length(eventstats); ++l) {
							variable_instance_set(self, eventstats[l][1], 0);
						}
						for (var l = 0; l < array_length(eventstats); ++l) {
							if (variable_struct_get(_event[$ _eventNames[j]][k], eventstats[l][1]) != undefined) {
							    variable_instance_set(self, eventstats[l][1], variable_struct_get(_event[$ _eventNames[j]][k], eventstats[l][1]));
							}
						}
						//_event[$ _eventNames[j]][k][$ "followPlayer"];
				}
			    if (mouse_check_button_pressed(mb_middle)) {
					    selectedEnemy = _enemyId;
						followPlayer = true;
						for (var l = 0; l < array_length(eventstats); ++l) {
							variable_instance_set(self, eventstats[l][1], 0);
						}
						for (var l = 0; l < array_length(eventstats); ++l) {
							if (variable_struct_get(_event[$ _eventNames[j]][k], eventstats[l][1]) != undefined) {
							    variable_instance_set(self, eventstats[l][1], variable_struct_get(_event[$ _eventNames[j]][k], eventstats[l][1]));
							}
						}
						//_event[$ _eventNames[j]][k][$ "followPlayer"];
				}
			}
			_xoffset += sprite_get_width(_sprite);
		}
		draw_text_transformed_color(_x + _xoffset, _y, "+", 2, 2, 0, c_green, c_green, c_green, c_green, 1);
		if (mouse_check_button_pressed(mb_left) and mouseOnText(_x + _xoffset, _y, "+", 2)) {
			selectedEnemy = 0;
			addToList = true;
			editing = _events[i];
			listToAdd = _eventNames[j];
			isEnemyEvent = _eventNames[j] == "event";
			for (var k = 0; k < array_length(eventstats); ++k) {
				variable_instance_set(self, eventstats[k][1], 0);
			}
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
	var _w = 80;
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
	var _w = isEnemyEvent ? 80 : 75;
	_xx += _w + 10;
	var _h = isEnemyEvent ? 150 : 57;
	window(_x, _y, _w, _h, $"Add to {listToAdd} on {editing}");
	_x = _x - _w + 10;
	_y = _y - _h + 30 + 10;
	_xoffset = 64;
	_yoffset = 64;
	
	draw_sprite_stretched(EnemyList[selectedEnemy][? "sprite"], enemySubImgs[selectedEnemy][0],  _x, _y, _xoffset, _yoffset);
	draw_rectangle(_x, _y, _x + _xoffset, _y + _yoffset, true);
	if (mouse_check_button_pressed(mb_left) and point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), _x, _y, _x + _xoffset, _y + _yoffset)) {
		enemyStart = 0;
		enemyEnd = 10;
		selectingEnemy = true;
	}
	var _ey = _y + _yoffset + 10;
	var _eyOffset = 0;
	var _text = "";
	if (isEnemyEvent) { 
		var _x2 = GW/2 + 180;
		var _y2 = GH/2;
		var _w2 = 80;
		var _h2 = 205;
		window(_x2, _y2, _w2, _h2, $"Add to {listToAdd} on {editing}");
		_x2 = _x2 - _w2 + 10;
		_y2 = _y2 - _h2 + 30 + 10;
		var _y2offset = 0;
		for (var i = 0; i < Patterns.Length; ++i) {
			var _color = pattern == i ? c_yellow : c_white;
		    draw_text_transformed_color(_x2, _y2 + _y2offset, global.patternNames[i], 2, 2, 0, _color, _color, _color, _color, 1);
			if (mouse_check_button_pressed(mb_left) and mouseOnText(_x2, _y2 + _y2offset, global.patternNames[i], 2)) {
			    pattern = i;
			}
			_y2offset += 20;
		}
	}
	for (var i = 0; i < array_length(eventstats) - 1; ++i) {
		if (!isEnemyEvent) { break; }
		var _tempOffset = 0;
	    if (is_string(eventstats[i][0])) {
			_text = $"{eventstats[i][0]}:{variable_instance_get(self, eventstats[i][1])}";
		    draw_text_transformed(_x, _ey + _eyOffset, _text, 2, 2, 0);
		}
		else {
			draw_sprite_ext(eventstats[i][0], 0, _x + _tempOffset + sprite_get_width(eventstats[i][0]) / 2, _ey + _eyOffset + (sprite_get_height(eventstats[i][0]) / 2), 2, 2, 0, c_white, 1);
			_text = variable_instance_get(self, eventstats[i][1]);
			_tempOffset = sprite_get_width(eventstats[i][0]) * 2.5;
			draw_text_transformed(_x + _tempOffset, round(_ey + _eyOffset), _text, 2, 2, 0);
		}
		var _mult = 1;
		if (keyboard_check(vk_shift)) {
		    _mult = 0.05;
		}
		if (keyboard_check(vk_alt)) {
		    _mult = 10;
		}
		var _updown = mouse_wheel_up() - mouse_wheel_down();
		if (mouseOnText(_x + _tempOffset, _ey + _eyOffset, _text, 2) and _updown != 0) {
			variable_instance_set(self, eventstats[i][1], variable_instance_get(self, eventstats[i][1]) + _updown * _mult);
			if (variable_instance_get(self, eventstats[i][1]) < 0) {
			    variable_instance_set(self, eventstats[i][1], 0);
			}
		}
		_eyOffset += 25;
	}
	_x += _xoffset + 10;
	if (create_button(_x, _y, "Add", 2)) {
		if (editEnemy) {
			if (isEnemyEvent) {
				stage[$ editing][$ listToAdd][editIndex] = {};
				for (var i = 0; i < array_length(eventstats); ++i) {
					if (variable_instance_get(self, eventstats[i][1]) != 0) {
					    variable_struct_set(stage[$ editing][$ listToAdd][editIndex], eventstats[i][1], variable_instance_get(self, eventstats[i][1]));
					}
				}
			    stage[$ editing][$ listToAdd][editIndex][$ "id"] = selectedEnemy;
				editEnemy = false;
			}
			else {
				stage[$ editing][$ listToAdd][editIndex] = selectedEnemy;
				editEnemy = false;
			}		    
		}
		else {
			if (isEnemyEvent) {
				array_push(stage[$ editing][$ listToAdd], {id : selectedEnemy});
			    for (var i = 0; i < array_length(eventstats); ++i) {
					if (variable_instance_get(self, eventstats[i][1]) != 0) {
					    variable_struct_set(stage[$ editing][$ listToAdd][array_length(stage[$ editing][$ listToAdd]) - 1], eventstats[i][1], variable_instance_get(self, eventstats[i][1]));
					}
				}
			}
			else {
				array_push(stage[$ editing][$ listToAdd], selectedEnemy);
			}
		}
		selectingEnemy = false;
		addToList = false;
		isEnemyEvent = false;
	}
	_y+=30;
	if (create_button(_x, _y, "Cancel", 2)) {
		addToList = false;
		isEnemyEvent = false;
	}
}

if (selectingEnemy) {
    var _x = (GW/2 + 250) + (isEnemyEvent ? 180 : 0);
	var _y = GH/2;
	var _w = 150;
	var _h = 155;
	window(_x, _y, _w, _h, "Enemies");
	_x = _x - _w + 10;
	_y = _y - _h + 30 + 10;
	_yoffset = 0;
	if (enemyEnd >= Enemies.Lenght) { enemyEnd = Enemies.Lenght - 1; enemyStart = enemyEnd - 10;}
	if (enemyStart <= 0) { enemyStart = 0; enemyEnd = 10}
	for (var i = enemyStart; i <= enemyEnd; ++i) {
		var _name = EnemyList[i][? "name"];
		draw_text_transformed(_x, _y + _yoffset, _name, 2, 2, 0);
		if (mouse_check_button_pressed(mb_left) and mouseOnText(_x, _y + _yoffset, _name, 2) and _name != undefined) {
			selectedEnemy = i;
			selectingEnemy = false;
		}
		_yoffset += string_height(_name) + 10;
	}
}
var _text = "Export";
var _x = GW - 2;
var _y = GH - string_height(_text) * 2 - 3;
_x -= string_width(_text) * 2 + 9;
if (create_button(_x, _y, _text, 2)) {
	var f = file_text_open_write(file);
	file_text_write_string(f, string(json_stringify(stage, true)));
	file_text_close(f);
	var _fs = file_text_open_write(savedFile);
	file_text_write_string(_fs, json_stringify(stage));
	file_text_close(_fs);
	show_message_async($"Exported to {file}");
}
_text = "Load";
_x -= string_width(_text) * 2 + 9;
if (create_button(_x, _y, _text, 2)) {
	if (file_exists(savedFile)) {
		var fs = file_text_open_read(savedFile);
		var _json = file_text_read_string(fs);
		file_text_close(fs);
		stage = json_parse(_json);
	}
}
_text = "New";
_x -= string_width(_text) * 2 + 9;
if (create_button(_x, _y, _text, 2)) {
	stage = {};
}
_text = "Add Timer";
_x -= string_width(_text) * 2 + 9;
if (create_button(_x, _y, _text, 2)) {
	addEvent = true;
}
_text = "Stage1";
_x -= string_width(_text) * 2 + 9;
if (create_button(_x, _y, _text, 2)) {
	stage = global.stage[$ "Stage1"];
}
_text = "Events";
_x -= string_width(_text) * 2 + 9;
if (create_button(_x, _y, _text, 2)) {
	filter = "event";
}
_text = "delEnemy";
_x -= string_width(_text) * 2 + 9;
if (create_button(_x, _y, _text, 2)) {
	filter = "delEnemy";
}
_text = "addEnemy";
_x -= string_width(_text) * 2 + 9;
if (create_button(_x, _y, _text, 2)) {
	filter = "addEnemy";
}
_text = "Clear Filter";
_x -= string_width(_text) * 2 + 9;
if (create_button(_x, _y, _text, 2)) {
	filter = "";
}

//if (false) {
//    var _x = GW/2;
//	var _y = GH/2;
//	var _w = 150;
//	var _h = 155;
//	window(_x, _y, _w, _h, "Edit");
//	_x = _x - _w + 10;
//	_y = _y - _h + 30 + 10;
//}
draw_set_font(global.newFont[2]);