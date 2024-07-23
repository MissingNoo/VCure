function bounceball_create(obj){
	obj.direction = point_direction(obj.x, obj.y, obj.x, obj.y+10);
	for (var i = 0; i < global.player[?"ballsize"]; ++i) {
		obj.image_xscale = obj.image_xscale * 1.10;
		obj.image_yscale = obj.image_xscale;
	}
	obj.y = oPlayer.y - 200;
	var _bx = irandom_range(-100, 100);
	obj.x = oPlayer.x + _bx;
}
function bounceball_step(obj){
	if (obj.vspeed < obj.upg[$ "speed"]) {
		obj.vspeed += 0.55 * Delta;
	}
	//move_and_collide(hspd, vspd, oEnemy);
	var _dir = point_direction(obj.x, obj.y, obj.x, obj.y + 10);
	var _diff = angle_difference(_dir, obj.direction);
	obj.direction += _diff * 0.005;
	obj.image_angle+=10;
}
function bounceball_on_hit(obj){
	var _push = 8;
	var _dir = point_direction(other.x, other.y, obj.x, obj.y);
	var _rnd = 0;
	obj.direction = _dir;
	var _vspd = lengthdir_y(_push, _dir); 
	obj.vspeed=_vspd;
}