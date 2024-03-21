if (!gotknocked and !infected) {
    gotknocked = true;
	if (other.upg[$ "knockbackSpeed"] == undefined) { exit; }
	var _push = other.upg[$ "knockbackSpeed"];
	if (variable_instance_exists(other, "tempKnockback")) {
		_push = other.tempKnockback;
	}	
	var _dir = point_direction(other.x, other.y, x, y);
	//feather disable once GM1041
	var _hspd = lengthdir_x(_push, _dir);
	//feather disable once GM1041
	var _vspd = lengthdir_y(_push, _dir); 
	x+=_hspd;
	y+=_vspd;
	alarm[2] = other.upg[$ "knockbackDuration"]*2;
}
