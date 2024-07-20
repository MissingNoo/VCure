function keris_create(obj){
	if (obj.shoots == -1) { exit; }
	var pos = [];
	switch (obj.upg.level) {
	    case 1:
		    pos = [0];
		    break;
		case 2:
		case 3:
		case 4:
			pos = [32, -32];
		    break;
		case 5:
			pos = [60, 0, -60];
		    break;
		case 6:
		case 7:
			pos = [128, -128, 50, -50];
		    break;
	}
	keris_position(obj, pos, global.arrowDir);
	var _list = ds_list_create();
	var _num = collision_circle_list(oPlayer.x, oPlayer.y, oPlayer.pickupRadius, oEnemy, false, true, _list, false);
	repeat (3) {
		if (ds_list_size(_list) == 0) {
		    break;
		}
		var _pos = irandom(ds_list_size(_list) - 1);
		instance_create_layer(_list[| _pos].x, _list[| _pos].y, "Upgrades", oUpgradeNew, {upg : global.upgradesAvaliable[Weapons.LargeKeris][1], shoots : -1});
	    ds_list_delete(_list, _pos);
	}
	ds_list_destroy(_list);
}
function large_keris_animation_end(obj) {
	instance_destroy(obj);
}
function keris_animation_end(obj) {
	
	//obj.animate = false;
}
function keris_position(obj, pos, arrowdir){
	var _basex;
	var _basey;
	if (obj != noone) {
	    _basex = obj.x;
		_basey = obj.y;
	}
	else {
		_basex = x;
		_basey = y;
	}
	for (var i = 0; i < array_length(pos); ++i) {
		var _xx = _basex + lengthdir_x(pos[i], arrowdir + 90);
		var _yy = _basey + lengthdir_y(pos[i], arrowdir + 90);
		var _x2 = _basex + lengthdir_x(256, arrowdir - 0);
		var _y2 = _basey + lengthdir_y(256, arrowdir + 0);
		var lastdir = point_direction(_xx, _yy, _x2, _y2);
		if (obj != noone) {
		    if (i == 0) {
				obj.x = _xx;
				obj.y = _yy;
				obj.image_angle = lastdir;
			}
			else {
				instance_create_layer(_xx, _yy-8, "Upgrades", oUpgradeNew, {upg : obj.upg, shoots : -1, image_angle : lastdir});
			}
		}
		if (obj == noone) {
		    draw_sprite_ext(sHoloCursor, 0, x, y, 1, 1, arrowdir, c_white, 0.5);
			draw_rectangle_color(mouse_x - 2, mouse_y - 2, mouse_x + 2, mouse_y + 2, c_yellow, c_yellow, c_yellow, c_yellow, false);
		
			draw_rectangle_color(_xx - 2, _yy - 2, _xx + 2, _yy + 2, c_red, c_red, c_red, c_red, false);
			draw_rectangle_color(_x2 - 2, _y2 - 2, _x2 + 2, _y2 + 2, c_blue, c_blue, c_blue, c_blue, false);
			draw_sprite_ext(sHoloCursor, 0, _xx, _yy, 1, 1, lastdir, c_white, 0.5);
			draw_line_width_color(_xx, _yy, _x2, _y2, 3, c_blue, c_red);
		}
	}
}