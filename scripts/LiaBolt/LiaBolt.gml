function liabolt_create(obj){
	sprite_index = sBolt;
	obj.image_xscale = 0.2;
	obj.image_yscale = 0.2;
	if (obj[$ "bolts"] == undefined) {
	    obj.bolts = obj.upg.bolts;
		obj.lightningColor = c_yellow;
		if (obj.upg[$ "level"] > 3) { obj.lightningColor = c_blue; }
		if (obj.upg[$ "level"] == 7) { obj.lightningColor = c_red; }
		obj.startX = obj.x;
		obj.startY = obj.y;
	}
	obj.lightningTarget = noone;
	var _list = ds_list_create();
	var _num = collision_circle_list(obj.x, obj.y, 150, oEnemy, false, true, _list, true);
	if (_num > 0) {
		for (var i = 0; i < _num; ++i) {
			if (!_list[| i].lightningMarked and !_list[| i].infected) {
				obj.lightningTarget = _list[| i];
				obj.x = obj.lightningTarget.x;
				obj.y = obj.lightningTarget.y;
				_list[| i].lightningMarked = true;
				_list[| i].lightningTimer = 30;
				break;
			}
		}
		if (obj.lightningTarget == noone) {
		    instance_destroy(obj);
			exit;
		}
	}
	ds_list_destroy(_list);
	if (obj.bolts > 1 and obj.lightningTarget != noone) {
		var target = obj.lightningTarget;
		instance_create_layer(target.x, target.y, "Upgrades", oUpgradeNew,{
			upg : obj.upg,
			owner : target,
			startX : target.x,
			startY : target.y,
			bolts : obj.bolts - 1,
			lightningColor : obj.lightningColor
		});
	}
	//		newbolts : obj.bolts - 1,
	//		newboltcolor : obj.lightningColor,
	//		newboltx : obj.x,
	//		newbolty : obj.y,
	//		newowner : obj.id,
	//		upg : obj.upg,
	//		hits : obj.hits,
	//		mindmg : obj.mindmg,
	//		maxdmg : obj.maxdmg,
	//		sprite_index : sLiaBolt
	//	});
	//}
	//obj.extrainfo = {upg : upg[$"id"], lightningColor, startX, startY};
}

function liabolt_step(obj){
	if (obj.lightningTarget != noone and instance_exists(obj.lightningTarget)) {
		obj.x = obj.lightningTarget.x;
		obj.y = obj.lightningTarget.y;
	}
}

function liabolt_draw(obj) {
	if (obj.lightningTarget != noone and instance_exists(obj.lightningTarget)) {
		try {
		    draw_lightning(obj.owner.x, obj.owner.y - 8, obj.lightningTarget.x, obj.lightningTarget.y - 8, false, obj.lightningColor);
		}
		catch (err) {
			//bruh
		}
	}
}