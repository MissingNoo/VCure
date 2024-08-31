function aik_create(obj) {
	obj.beamLaunched = false;
	obj.enemyTarget = noone;
	obj.aikFollow = true;
	obj.image_alpha = .999;
	obj.directionSet = false;
	var _dir = irandom_range(0, 360);
	var _list = ds_list_create();
	var _num = collision_circle_list(obj.x, obj.y, 250, oEnemy, false, true, _list, true);
	if (_num > 0) {
		if (obj.shoots > 0) {
			obj.enemyTarget = _list[| 0];
		}
		else {
			var _chance = irandom_range(0, ds_list_size(_list) - 1);
			obj.enemyTarget = _list[| _chance];
		}
		if (obj.enemyTarget != noone and instance_exists(obj.enemyTarget)) {
			_dir = point_direction(obj.x, obj.y, obj.enemyTarget.x, obj.enemyTarget.y - 8);
		}
	}
	obj.direction = irandom_range(_dir - 30, _dir + 30);
	if (obj.direction - _dir < -180) {
		obj.direction = _dir;
	}
	obj.image_angle = obj.direction;
	obj.speed = obj.upg[$ "speed"];
	ds_list_destroy(_list);
}

function aik_step(obj) {
	if (obj.enemyTarget == noone) {
		obj.speed = 0;
	}
	if (instance_exists(obj.enemyTarget)) {
		if (!obj.directionSet) {
			obj.image_angle = point_direction(obj.x, obj.y, obj.enemyTarget.x, obj.enemyTarget.y - 8);
			obj.directionSet = true;
		}
		obj.enemyDirection = point_direction(obj.x, obj.y, obj.enemyTarget.x, obj.enemyTarget.y - 8);
		if (obj.aikFollow and obj.speed > 0) {
			obj.direction += angle_difference(obj.enemyDirection, obj.direction) * 0.25;
			obj.image_angle = obj.direction;
		}
		with (obj) {
			/// @localvar {Any} enemyTarget 
			if (distance_to_object(enemyTarget) < 22) {
				speed = 0;
				if (!obj.beamLaunched) {
					obj.beamLaunched = true;
					var _beam = sAkiBeam;
					var _size = 1;
					if (obj.upg[$ "level"] == obj.upg[$ "maxlevel"]) {
						_beam = sAkiBeam2;
						_size = 1.30;
						obj.mindmg = obj.mindmg * 1.30;
						obj.maxdmg = obj.maxdmg * 1.30;
					}
					//if (obj.enemyTarget != noone) {
						obj.beam = instance_create_depth(obj.x, obj.y, obj.depth, oUpgradeAttach, {upg : obj.upg, hits : 9999, sprite_index : _beam, image_index : 0, image_angle : obj.image_angle, mindmg : obj.mindmg, maxdmg : obj.maxdmg, image_xscale : _size, image_yscale : _size, applyDebuff : [BuffNames.DefDown, 3, obj.upg[$ "chance"]]});
					//}
				}
			}
		}
	}
}

function aik_on_destroy(obj) {
	if (instance_exists(obj.beam)) {
		instance_destroy(obj.beam);
	}
}

function aik_animation_end(obj) {
	if (instance_exists(obj) and (obj.sprite_index == sAkiBeam or obj.sprite_index == sAkiBeam2)) {
		instance_destroy(obj);
	}
}