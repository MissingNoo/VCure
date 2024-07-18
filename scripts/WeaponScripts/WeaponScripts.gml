//Feather disable GM2064
enum WeaponEvent {
	BeginStep,
	Step,
	OnHit,
	AnimationEnd,
	Draw,
	PerkOnHit = 100,
	PerkDraw = 101,
	Null = 102,
}
function brick_step(o){
	if (o == 0) {
		default_behaviour();
		direction = global.arrowDir;
	}
	else {
		image_angle -= 6;
	}
}
function ceotears_step(o){
	if (o == 0) {
	    if (instance_exists(oEnemy)) {
			// random_set_seed(current_time * global.upgradeCooldown[0]);
			var enemies = instance_number(oEnemy);
			if (enemies == 0) { instance_destroy(); }
			//var ce = instance_nearest(x,y-50.75,oEnemy);
			// // randomize;
			//if (ce != 0) {
				ce = instance_find(oEnemy, irandom_range(0,enemies-1));
				direction = point_direction(x,y,ce.x, ce.y);
				image_angle = point_direction(x,y,ce.x, ce.y);
			//}
			if (shoots>0) {
				for (var i = 1; i < shoots; ++i) {
					spawn_upgrade();
					//alarm[0]=1;
					dAlarm[0]=1;
				}
			}
		} else instance_destroy();
	}
	else {
		
	}
}
function fanbeam_step(o){
	if (o == 0) {
	    image_xscale = owner.image_xscale;
		if(shoots == -1){
			image_xscale = image_xscale * -1;
		}
		if (shoots>0) {
			for (var i = 1; i < shoots; ++i) {
				spawn_upgrade();
				//alarm[0]=1;
				dAlarm[0]=1;
			}
		}
	}
	else {
		
	}
}
function absolutewall_step(o){
	if (o == 0) {
	    if (global.player[?"flat"]) {
			image_xscale = image_xscale * 1.20;
			image_yscale = image_yscale * 1.20;
			mindmg = mindmg * 1.20;
			maxdmg = maxdmg * 1.20;
		}
	}
	else {
		var _offset = 0;
		switch (wallNumber) {
			case 0:
				_offset = 0;
				break;
			case 1:
				_offset = 90;
				break;
			case 2:
				_offset = 180;
				break;
			case 3:
				_offset = 270;
				break;
		}
		image_angle = global.arrowDir + _offset;
		x = owner.x;
		y = owner.y - 16;
		image_xscale = image_yscale + 0.5;
		extra.x = x;
		extra.y = y;
		extra.image_angle = image_angle;
		extra.image_xscale = image_xscale;
		extra.image_yscale = image_yscale;
	}
}
function cuttingboard_step(o){
	if (o == 0) {
	    if (global.player[?"flat"]) {
			image_xscale = image_xscale * 1.30;
			image_yscale = image_yscale * 1.30;
			mindmg = mindmg * 1.30;
			maxdmg = maxdmg * 1.30;
		}
		direction = arrowDir + 180 + diroffset;
		speed = upg[$ "speed"];
		image_angle = arrowDir + diroffset;
	}
	else {
		if (distance_to_point(xstart, ystart) > 5) {
			speed -= .30 * Delta;
			if (speed < 0) {
				speed = 0;
			}
		}
	}
}
function holobomb_step(o){
	if (o == 0) {
	    x = owner.x + irandom_range(-50,50);			
		y = owner.y + (irandom_range(-50,50)*-1);
		//alarm[0] = 1;
		depth=owner.depth;
	}
	else {
		
	}
}
function glowstick_step(o){
	if (o == 0) {
	    if (instance_exists(oEnemy)) {
			var enemies = instance_number(oEnemy);
			if (enemies == 0) { instance_destroy(); }
			ce = instance_find(oEnemy, irandom_range(0,enemies-1));
			direction = point_direction(x,y,ce.x, ce.y);
			image_angle = point_direction(x,y,ce.x, ce.y);
			if (shoots>0) {
				for (var i = 1; i < shoots; ++i) { spawn_upgrade(); }
			}
		} else instance_destroy();
	}
	else {
		if (hits <= 0) {
			sprite_index = sGlowstickThumbExplosion;
			speed = 0;
		}
		if (distance_to_object(owner) > 200) {
			direction = point_direction(x,y,owner.x, owner.y);
		}
	}
}
function idolsong_step(o){
	if (o == 0) {
	    if (idolDir == 90) {
			idolDir = 270;
			idolStartX= oPlayer.x + 20;
			direction = idolDir;
		}else{
			idolDir = 90;
			idolStartX= oPlayer.x - 20;
			//xstart = xstart - 20;
			direction = idolDir;
			//image_xscale = image_xscale * -1;
		}
	}
	else {
		x = sine_wave(current_time  / 1000, 1 * (shoots % 2) ? 1 : -1, upg[$ "travelWidth"], idolStartX);
	}
}
function psychoaxe_step(o){
	if (o == 0) {
	    orbitoffset = 0;
		orbitLength = 0;
	}
	else {
		x = xxstart + lengthdir_x(round(orbitLength), round(orbitPlace));
		y = yystart + lengthdir_y(round(orbitLength), round(orbitPlace));
		orbitPlace -= 4;
		orbitLength += 0.75;
		image_angle += 10;
	}
}
function wamywater_step(o){
	if (o == 0) {
	    image_angle = arrowDir + diroffset;
	}
	else {
		
	}
}
function pipipistol_step(o){
	if (o == 0) {
	    default_behaviour();
		direction = arrowDir;
		image_angle = arrowDir;
		//alarm[0] = 10;
		//if (shoots % 2) {
		if (shoots == -1) {
			sprite_index = sBulletBlue;
			var enemies = instance_number(oEnemy);
			ce = instance_find(oEnemy, irandom_range(0,enemies-1));
			try{
				direction = point_direction(x,y,ce.x, ce.y);
				image_angle = point_direction(x,y,ce.x, ce.y);
			}
			catch (err){
				direction = point_direction(x,y, 0, 0);
				image_angle = point_direction(x,y, 0, 0);
			}				
		}
	}
	else {
		
	}
}
function heavyartillery_step(o){
	if (o == 0) {
	    default_behaviour();
		mindmg = (UPGRADES[0].mindmg*333)/100;
		maxdmg = (UPGRADES[0].maxdmg*333)/100;
		var closest = instance_nearest(oPlayer.x ,oPlayer.y, oEnemy);
		if (!instance_exists(closest)) { instance_destroy(); }
		x=closest.x;
		y=closest.y;
	}
	else {
		
	}
}
function mold_step(o){
	if (o == 0) {
	    default_behaviour();
		mindmg = (UPGRADES[0].mindmg*33)/100;
		maxdmg = (UPGRADES[0].maxdmg*33)/100;
	}
	else {
		
	}
}
function encurse_step(o){
	if (o == 0) {
	    direction = arrowDir;
		image_angle  = arrowDir;
	}
	else {
		
	}
}
function xpotato_step(o){
	if (o == 0) {
	    direction = irandom_range(0,360);
	}
	else {
		
	}
}
function micomet_step(o){
	if (o == 0) {
	    instance_create_layer(x + irandom_range(-200, 200), y + irandom_range(-200, 200), "Upgrades", oUpgrade,{
			upg : WEAPONS_LIST[Weapons.MiCometMeteor][1],
			speed : WEAPONS_LIST[Weapons.MiCometMeteor][1][$ "speed"],
			hits : WEAPONS_LIST[Weapons.MiCometMeteor][1][$ "hits"],
			shoots : WEAPONS_LIST[Weapons.MiCometMeteor][1][$ "shoots"],
			sprite_index : WEAPONS_LIST[Weapons.MiCometMeteor][1][$ "sprite"],
			level : WEAPONS_LIST[Weapons.MiCometMeteor][1][$ "level"],
			mindmg: WEAPONS_LIST[Weapons.MiCometMeteor][1][$ "mindmg"],
			maxdmg: WEAPONS_LIST[Weapons.MiCometMeteor][1][$ "maxdmg"]
		});
	}
	else {
		
	}
}
function bonebros_step(o){
	if (o == 0) {
	    
	}
	else {
		slashTimer += 1 * Delta;
		bulletTimer += 1 * Delta;
		if (slashTimer > 5) {
			slashTimer = 0;
			instance_create_layer(x, y, "Upgrades", oUpgrade,{
				upg : WEAPONS_LIST[Weapons.BoneBrosSlash][1],
				speed : WEAPONS_LIST[Weapons.BoneBrosSlash][1][$ "speed"],
				hits : WEAPONS_LIST[Weapons.BoneBrosSlash][1][$ "hits"],
				shoots : WEAPONS_LIST[Weapons.BoneBrosSlash][1][$ "shoots"],
				sprite_index : WEAPONS_LIST[Weapons.BoneBrosSlash][1][$ "sprite"],
				level : WEAPONS_LIST[Weapons.BoneBrosSlash][1][$ "level"],
				mindmg: WEAPONS_LIST[Weapons.BoneBrosSlash][1][$ "mindmg"],
				maxdmg: WEAPONS_LIST[Weapons.BoneBrosSlash][1][$ "maxdmg"],
				direction : global.arrowDir + irandom_range(0, 30)
			});
		}
		if (bulletTimer > 3) {
			bulletTimer = 0;
			instance_create_layer(x, y, "Upgrades", oUpgrade,{
				upg : WEAPONS_LIST[Weapons.BoneBrosBullet][1],
				speed : WEAPONS_LIST[Weapons.BoneBrosBullet][1][$ "speed"],
				hits : WEAPONS_LIST[Weapons.BoneBrosBullet][1][$ "hits"],
				shoots : WEAPONS_LIST[Weapons.BoneBrosBullet][1][$ "shoots"],
				sprite_index : WEAPONS_LIST[Weapons.BoneBrosBullet][1][$ "sprite"],
				level : WEAPONS_LIST[Weapons.BoneBrosBullet][1][$ "level"],
				mindmg: WEAPONS_LIST[Weapons.BoneBrosBullet][1][$ "mindmg"],
				maxdmg: WEAPONS_LIST[Weapons.BoneBrosBullet][1][$ "maxdmg"],
				direction : (global.arrowDir + 180) + irandom_range(0, 30)
			});
		}
	}
}
function bonebros_bullet_step(o){
	if (o == 0) {
	    image_angle = direction;
	}
	else {
		
	}
}
function bonebros_slash_step(o){
	if (o == 0) {
	    image_angle = direction;
	}
	else {
		
	}
}
function blfujoshi_step(o){
	if (o == 0) {
	    instance_create_layer(x, y, "Upgrades", oUpgrade,{
			upg : WEAPONS_LIST[Weapons.BLFujoshiAxe][1],
			speed : WEAPONS_LIST[Weapons.BLFujoshiAxe][1][$ "speed"],
			hits : WEAPONS_LIST[Weapons.BLFujoshiAxe][1][$ "hits"],
			shoots : WEAPONS_LIST[Weapons.BLFujoshiAxe][1][$ "shoots"],
			sprite_index : WEAPONS_LIST[Weapons.BLFujoshiAxe][1][$ "sprite"],
			level : WEAPONS_LIST[Weapons.BLFujoshiAxe][1][$ "level"],
			mindmg: WEAPONS_LIST[Weapons.BLFujoshiAxe][1][$ "mindmg"],
			maxdmg: WEAPONS_LIST[Weapons.BLFujoshiAxe][1][$ "maxdmg"]
		});
		instance_create_layer(x, y, "Upgrades", oUpgrade,{
			upg : WEAPONS_LIST[Weapons.BLFujoshiBook][1],
			speed : WEAPONS_LIST[Weapons.BLFujoshiBook][1][$ "speed"],
			hits : WEAPONS_LIST[Weapons.BLFujoshiBook][1][$ "hits"],
			shoots : WEAPONS_LIST[Weapons.BLFujoshiBook][1][$ "shoots"],
			sprite_index : WEAPONS_LIST[Weapons.BLFujoshiBook][1][$ "sprite"],
			level : WEAPONS_LIST[Weapons.BLFujoshiBook][1][$ "level"],
			mindmg: WEAPONS_LIST[Weapons.BLFujoshiBook][1][$ "mindmg"],
			maxdmg: WEAPONS_LIST[Weapons.BLFujoshiBook][1][$ "maxdmg"]
		});
	}
	else {
		
	}
}
function blfujoshibook_step(o){
	if (o == 0) {
	    
	}
	else {
		orbitLength = 100;
		x = owner.x + lengthdir_x(orbitLength, round(orbitPlace));
		y = owner.y - 16 + lengthdir_y(orbitLength, round(orbitPlace));
		orbitPlace -= 8;
	}
}
function blfujoshiaxe_step(o){
	if (o == 0) {
	    
	}
	else {
		orbitLength = 190;
		x = owner.x + lengthdir_x(orbitLength, round(orbitPlace));
		y = owner.y - 16 + lengthdir_y(orbitLength, round(orbitPlace));
		orbitPlace -= 10;
	}
}
function eldritchhorror_step(o){
	if (o == 0) {
	    dAlarm[3] = irandom(100);
		depth = layer_get_depth("Pools") + 1;
		x = oPlayer.x + irandom_range(-200, 200);
		y = oPlayer.y + irandom_range(-200, 200);
		ps = part_system_create();
		ps2 = part_system_create();
		part_system_depth(ps, depth-1);
		part_system_depth(ps2, depth-1);
		part_system_color(ps, c_white, .5);
		part_system_color(ps2, c_white, .5);
		part_system_draw_order( ps, false);
		part_system_draw_order( ps2, false);
		var _scale = 0.75;
		var _speed = 1;
		var ptype1 = part_type_create();
		part_type_sprite( ptype1, sEldricthHorrorSmoke, true, true, false);
		part_type_size( ptype1, 1, 1, 0, 0 );
		part_type_scale( ptype1, _scale, _scale);
		part_type_speed( ptype1, _speed, _speed, 0, 0);
		part_type_direction( ptype1, 180, 0, 0, 0);
		part_type_gravity( ptype1, 0, 270);
		part_type_orientation( ptype1, 0, 0, 0, 0, false);
		part_type_colour3( ptype1, $FFFFFF, $FFFFFF, $FFFFFF );
		part_type_alpha3( ptype1, 1, 1, 1);
		part_type_blend( ptype1, false);
		part_type_life( ptype1, 80, 80);
		var ptype2 = part_type_create();
		part_type_sprite( ptype2, sEldricthHorrorSmoke, true, true, false);
		part_type_size( ptype2, 1, 1, 0, 0 );
		part_type_scale( ptype2, _scale, _scale);
		part_type_speed( ptype2, _speed, _speed, 0, 0);
		part_type_direction( ptype2, 0, 0, 0, 0);
		part_type_gravity( ptype2, 0, 270);
		part_type_orientation( ptype2, 0, 0, 0, 0, false);
		part_type_colour3( ptype2, $FFFFFF, $FFFFFF, $FFFFFF );
		part_type_alpha3( ptype2, 1, 1, 1);
		part_type_blend( ptype2, false);
		part_type_life( ptype2, 80, 80);

		var pemit1 = part_emitter_create( ps );
		var pemit2 = part_emitter_create( ps2 );
		var _shape = ps_shape_ellipse;
		var _size = sprite_get_width(sEldricthHorrorPool);
		var _number = 1;
		part_emitter_region( ps, pemit1, -_size, _size, -_size, _size, _shape, ps_distr_linear );
		part_emitter_stream(ps, pemit1, ptype1, _number);
		part_emitter_region( ps2, pemit2, -_size, _size, -_size, _size, _shape, ps_distr_linear );
		part_emitter_stream(ps2, pemit2, ptype2, _number);

		part_system_position(ps, x, y);
		part_system_position(ps2, x, y);

	}
	else {
		
	}
}
function breatheintypeasacoco_step(o){
	if (o == 0) {
	    asaDirection = random_range(-1,1);
		asaRotationSpeed = irandom_range(-10, 10);
		asaSpeed = irandom_range(1, 8);
		asaDuration = random_range(0.8, 1.2);
		vspd = -11;
	}
	else {
		if (sprite_index == sBreathAsacoco) {
			image_xscale = 1;
			image_yscale = 1;
			image_angle += (asaRotationSpeed * asaDirection) * Delta;
		}
		else{
			image_xscale = upg[$ "size"];
			image_yscale = upg[$ "size"];
		}
		if (vspd < 50 and asaDuration > 0) {
			vspd += 0.40 * Delta;
		}
		if (asaDuration > 0) {
			asaDuration -= 1/60 * Delta;
		}
		else{
			vspd = 0;
			hspd = 0;
			speed = 0;
			asaSpeed = 0;
			sprite_index = sBombExplosion;
			image_angle = 0;
			image_index = 0;
		}
		y += vspd * Delta;
		x += (asaSpeed * asaDirection) * Delta;
	}
}
function elitecooking_step(o){
	if (o == 0) {
	    x = owner.x + irandom_range(-100,100);
		y = owner.y + (irandom_range(-100,100)*-1);
	}
	else {
		if (poolSize != 1) {
			poolSize -= 1;
			extra.poolSize = poolSize;
		}
	}
}
function streamoftears_step(o){
	if (o == 0) {
	    image_xscale = upg[$ "sizeX"];
		image_yscale = upg[$ "sizeY"];
	}
	else {
		if (shoots == -1) {
			x = owner.x + lengthdir_x(16, round(orbitPlace));
			y = owner.y + lengthdir_y(16, round(orbitPlace));
			orbitPlace += 2 * Delta;
			image_angle = point_direction(owner.x, owner.y, x, y);
		}
		else{
			x = owner.x - lengthdir_x(16, round(orbitPlace));
			y = owner.y - lengthdir_y(16, round(orbitPlace));
			orbitPlace += 2 * Delta;
			image_angle = point_direction(owner.x, owner.y, x, y);
		}
	}
}
function ringoffitness_step(o){
	if (o == 0) {
	    for (var i = 0; i < global.player[?"ballsize"]; ++i) {
			image_xscale = image_xscale * 1.10;
			image_yscale = image_xscale;
		}
		x = owner.x + lengthdir_x(20, ringDir);
		y = owner.y + lengthdir_y(20, ringDir);
		direction = point_direction(owner.x, owner.y, x, y);
		for (var i = 0; i < shoots - 1; ++i) {
			ringDir+= 24;
			//var _x = x + lengthdir_x(20, round(ringDir));
			//var _y = y + lengthdir_y(20, round(ringDir));
			//var dirr = point_direction(_x, _y, owner.x, owner.y);
			instance_create_depth(owner.x, owner.y, depth, oUpgrade,{
				upg : WEAPONS_LIST[Weapons.RingOfFitness][1],
				speed : WEAPONS_LIST[Weapons.RingOfFitness][1][$ "speed"],
				hits : WEAPONS_LIST[Weapons.RingOfFitness][1][$ "hits"],
				shoots : -1,
				sprite_index : WEAPONS_LIST[Weapons.RingOfFitness][1][$ "sprite"],
				level : WEAPONS_LIST[Weapons.RingOfFitness][1][$ "level"],
				mindmg: WEAPONS_LIST[Weapons.RingOfFitness][1][$ "mindmg"],
				maxdmg: WEAPONS_LIST[Weapons.RingOfFitness][1][$ "maxdmg"],
				ringDir,
				owner,
				firstBall : false
				//x : _x,
				//y : _y,
				//direction : dirr,
			});	
		}
	}
	else {
		
	}
}
function imdie_step(o){
	if (o == 0) {
	    direction = global.arrowDir;
	}
	else {
		
	}
}
function imdieexplosion_step(o){
	if (o == 0) {
	    explosionSize += .10;
		image_xscale = explosionSize;
		image_yscale = explosionSize;
		oGame.shakeMagnitude = 2;
	}
	else {
		
	}
}
function eletricpulse_step(o){
	if (o == 0) {
	    
	}
	else {
		x = owner.x;
		y = owner.y;
	}
}
function amepistol_step(o){
	switch (o) {
	    case WeaponEvent.BeginStep:
			if (shoots > 0 and oPlayer.slowTime) {
			    global.upgradeCooldown[Weapons.AmePistol] = global.upgradeCooldown[Weapons.AmePistol] / 2;
			}
			amePistolLastHit = false;
	        direction = global.arrowDir;
			image_angle = global.arrowDir;
	        break;
	    case WeaponEvent.Step:
	        // code here
	        break;
	    case WeaponEvent.OnHit:
	        if (hits == 1 and !amePistolLastHit and upg[$"level"] >= 4) {
			    amePistolLastHit=true;
				hits+=5;
				direction = random(360);
			}
	        break;
	}
}
function aik_step(o){
	switch (o) {
	    case WeaponEvent.BeginStep:
			enemyTarget = noone;
			image_alpha = .999;
			directionSet = false;
			var _dir = irandom_range(0, 360);
			var _list = ds_list_create();
			var _num = collision_circle_list(x, y, 250, oEnemy, false, true, _list, true);
			if (_num > 0) {
				if (shoots > 0) {
				    enemyTarget = _list[| 0];
				}
				else {
					var _chance = irandom_range(0, ds_list_size(_list) - 1);
				    enemyTarget = _list[| _chance];
				}
				if (enemyTarget != noone and instance_exists(enemyTarget)) {
				    _dir = point_direction(x, y, enemyTarget.x, enemyTarget.y - 8);
				}
			}
			direction = irandom_range(_dir - 30, _dir + 30);
			if (direction - enemyDirection < -180) {
				direction = enemyDirection;
			}
			image_angle = direction;
			speed = upg[$ "speed"];
			//else {
			//	speed = 0;
			//}
			ds_list_destroy(_list);
	        break;
	    case WeaponEvent.Step:
			if (enemyTarget == noone) {
				speed = 0;
			}
	        if (instance_exists(enemyTarget)) {
				if (!directionSet) {
					image_angle = point_direction(x, y, enemyTarget.x, enemyTarget.y - 8);
				    directionSet = true;
				}
			    enemyDirection = point_direction(x, y, enemyTarget.x, enemyTarget.y - 8);
				//if (direction > enemyDirection) {
				//    direction -= 2;
				//}
				//if (direction < enemyDirection) {
				//    direction += 2;
				//}
				if (aikFollow and speed > 0) {
				    //if (direction - enemyDirection < -180) {
					//	lowest = direction - enemyDirection;
					//	direction = enemyDirection;
					//}
					direction += angle_difference(enemyDirection, direction) * 0.25;
					image_angle = direction;
				}
				
				if (distance_to_object(enemyTarget) < 22) {
					speed = 0; 
				}
			}
			if (speed == 0) {
				if (!beamLaunched) {
					beamLaunched = true;
					var _beam = sAkiBeam;
					var _size = 1;
					if (upg[$ "level"] == upg[$ "maxlevel"]) {
					    _beam = sAkiBeam2;
					    _size = 1.30;
						mindmg = mindmg * 1.30;
						maxdmg = maxdmg * 1.30;
					}
					if (enemyTarget != noone) {
					    instance_create_depth(x, y, depth, oUpgradeAttach, {upg, sprite_index : _beam, image_angle, mindmg, maxdmg, image_xscale : _size, image_yscale : _size, applyDebuff : [BuffNames.DefDown, 3, upg[$ "chance"]]});
					}
				}
			}
	        break;
	    case WeaponEvent.OnHit:
	        // code here
	        break;
	    case WeaponEvent.AnimationEnd:
			if (sprite_index == sAkiBeam or sprite_index == sAkiBeam2) {
			    instance_destroy();
			}
	        break;
	}
}
function bellydance_step(o){ //TODO add animation
	switch (o) {
	    case WeaponEvent.BeginStep:
			var _lv = Buffs[BuffNames.BellyDance][$ "level"];
			mindmg = (mindmg * _lv) * count;
			maxdmg = (maxdmg * _lv) * count;
	        break;
	    case WeaponEvent.Step:
	        image_xscale += 0.25;
	        image_yscale = image_xscale;
	        break;
	    case WeaponEvent.Draw:
	        draw_sprite_ext(sprite_index, 0, x, y, image_xscale, image_yscale, 0, c_white, 0.5);
	        break;
		
	}
}
function _step(o){
	switch (o) {
	    case WeaponEvent.BeginStep:
	        // code here
	        break;
	    case WeaponEvent.Step:
	        // code here
	        break;
	    case WeaponEvent.OnHit:
	        // code here
	        break;
	}
}
function update_sprite_info(obj, newframe = 0){
	obj.current_frame = newframe;
	obj.last_frame = sprite_get_number(obj.sprite_index);
	obj.sprite_speed = sprite_get_speed(obj.sprite_index);
	obj.sprite_speed_type = sprite_get_speed_type(obj.sprite_index);
}