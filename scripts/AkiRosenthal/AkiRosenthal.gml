function aki_rosenthal_initialize() {
	createCharacterNew({ //TODO: Special, belly dance fade when close to screen border, 
		id : "Aki Rosenthal",
		name : "Aki Rosenthal",
		agency : "Hololive",
		portrait : sAkiPortrait,
		bigArt : sPlaceholderArt,
		sprite : sAkiIdle,
		runningsprite : sAkiRun,
		hp : 80,
		atk : 1.1,
		speed : 1.5,
		crit : 1,
		weapon : Weapons.Aik,
		ballsize : 3,
		flat : false,
		unlockedbydefault : true,
		finished : true
	});
	
	#region Belly Dancing
	create_perk({
		id : PerkIds.BellyDancing,
		on_cooldown : belly_dancing_on_cooldown,
		name : "Belly Dancing",
		maxlevel : 3, 
		weight : 1,
		thumb : sAkiPerk2,
		cooldown : 1,
		characterid : "Aki Rosenthal"
	});
	#endregion
	
	#region Mukirose
	create_perk({
		on_cooldown : perk_mukirose_on_cooldown,
		id : PerkIds.Mukirose,
		name : "Mukirose",
		maxlevel : 3, 
		weight : 1,
		thumb : sAkiPerk3,
		cooldown : [3, 3, 2.01, 2.01],
		characterid : "Aki Rosenthal"
	});
	#endregion
	
	#region Aromatherapy
	create_perk({
		on_cooldown : perk_aromateraphy_on_cooldown,
		draw : perk_aromatherapy_draw,
		id : PerkIds.Aromatherapy,
		name : "Aromatherapy",
		maxlevel : 3, 
		weight : 1,
		thumb : sAkiPerk1,
		cooldown : 1.5,
		characterid : "Aki Rosenthal",
	});
	#endregion
	
	var sp = new Special(SpecialIds.Shallys, "Aki Rosenthal", "Shallys", sAkiSpecial, 60);
	SPECIAL_LIST[SpecialIds.Shallys] = sp;
}

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