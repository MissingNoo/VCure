function liabolt_create(obj){
	var _list = ds_list_create();
	var _num = collision_circle_list(x,y, 150, oEnemy, false, true, _list, true);
	if (_num > 0) {
		for (var i = 0; i < _num; ++i) {
			if (!_list[| i].lightningMarked and !_list[| i].infected) {
				obj.lightningTarget = _list[| i];
				_list[| i].lightningMarked = true;
				_list[| i].lightningTimer = 20;
				break;
			}
		}
	}
	if (variable_instance_exists(self, "newbolts")) {
		obj.bolts = obj.upg.bolts;
		obj.lightningColor = newboltcolor;
		if (instance_exists(newowner)) {
			startX = newowner.x;
			startY = newowner.y;
		}
		else{
			instance_destroy();
		}
	}
	if (bolts > 1 and lightningTarget != noone) {
		var _inst = instance_create_layer(lightningTarget.x, lightningTarget.y, "Upgrades",oUpgradeNew,{
			upg,
			hits,
			mindmg,
			maxdmg,
			sprite_index : sLiaBolt
		});
		_inst.newbolts = bolts - 1;
		_inst.newboltcolor = lightningColor;
		_inst.newowner = id;
	}
	extrainfo = {upg : upg[$"id"], lightningColor, startX, startY};
}
function liabolt_step(obj){
	image_xscale = 0.2;
	image_yscale = 0.2;
	if (lightningTarget != noone and instance_exists(lightningTarget)) {
		x = lightningTarget.x;
		y = lightningTarget.y;
		extra.lx = x;
		extra.ly = y;
	}
}