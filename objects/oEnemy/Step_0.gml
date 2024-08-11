/*if (enemyinfo != -1 and setinfo) {
	setinfo = false;
	var names = variable_struct_get_names(enemyinfo);
	for (var i = 0; i < array_length(names); i++) {
		self[$ names[i]] = enemyinfo[$ names[i]];
	}
	initiate_enemy(EnemyList[thisEnemy]);
	
}*/
updatedebuffs();
if (!firstlook and instance_exists(target)) {
    firstlook = true;
	if (boss) {
		if(target.x < x) image_xscale = -2;
		if(target.x > x) image_xscale = 2;
		image_yscale = 2;
	}
	else{
		if(target.x < x) image_xscale = xscale * -1;
		if(target.x > x) image_xscale = xscale;
		image_yscale = yscale;
	}
}
if (!instance_exists(target)) { target = noone; }
if (infected and target == oPlayer) { target = noone; }
if (infected and variable_instance_exists(target, "infected") and target.infected) { target = noone; }
if (infected and target == noone) { //TODO multiplayer
	var _list = ds_list_create();
	var _num = collision_circle_list(x,y, 1000, oEnemy, false, true, _list, true);
	for (var i = 0; i < ds_list_size(_list); ++i) {
		if (variable_instance_get(_list[| i], "infected") == false) {
			target = _list[| i];
			if (instance_exists(target)) {
				sendMessage(0, {
					command : Network.InfectMob,
					id : enemyID,
					target : target.enemyID,
					hp,
					baseSPD,
				});
			}
			break;
		}
	}
	ds_list_destroy(_list);
}
if (justSpawned and thisEnemy == Enemies.FubuZilla) {
	justSpawned = false;
    fanbeamAlarm = fanbeamCooldown;
}
var _canmove = true;
if (global.gamePaused and !global.singleplayer) {
    _canmove = true;
}
if (global.gamePaused and global.singleplayer) {
    _canmove = false;
}
if(_canmove and instance_exists(target)){
	if (infected) {
	    hp -= baseHP / 5000;
		infectedAttackTimer--;
	}
	if (lightningTimer > 0) {
		lightningTimer -= 1*Delta;
	}
	else{
		lightningMarked = false;
	}
	if (damagedAlarm > 0) {
	    damagedAlarm-= 1*Delta;
	}
	if (damagedAlarm < 0) {
		damagedAlarm= 0;
	    damaged=false;
	}
	if (canattackAlarm > 0) {
	    canattackAlarm -= 1*Delta;
	}
	if (canattackAlarm < 0) {
		canattackAlarm = 0;
	    canattack=true;
	}
	if (lifetimeAlarm > 0) {
	    lifetimeAlarm -= 1*Delta;
	}
	if (lifetimeAlarm < 0) {
		lifetimeAlarm = 0;
		dropxp = false;
	    hp = 0;
	}
	#region Fubuzilla
	if (fanbeamAlarm > 0) {
	    fanbeamAlarm -= 1*Delta;
	}
	if (fanbeamFiring > 0) {
	    fanbeamFiring -= 1*Delta;
	}
	if (fanbeamFiring < 0) {
		fanbeamFiring = 0;
		var angle = image_xscale > 0 ? 0 : 180;
		instance_create_depth(x + (35 * image_xscale), y - 55, depth - 1, oFubuzillaBeam, {image_angle : angle, owner : id});
	}
	if (fanbeamAlarm < 0) {
		fanbeamAlarm = fanbeamCooldown;
		fanbeamFiring = 200;
	}
	#endregion
	#region Smol Ame
	if (thisEnemy == Enemies.SmolAme) {
		if (sprite_index == sSmolAmeGroundpound) {
		    speed = 0;
			canwalk = false;
		}
		else{ canwalk = true; }
		if (groundPounding) {
		    image_alpha = .99;
		}
		else { image_alpha = 1;}
	    if (groundPoundTimer > 0) { groundPoundTimer -= 1/60 * Delta; }
		if (groundPoundTimer < 0) {
			groundPoundTimer = 0;
			goingDownTimer = 10;
			groundPounding = true;
			image_index = 0;
			sprite_index = sSmolAmeJump;
			ametp = true;
			goingDownTimer = 4;
			goingDown = true;
		}
		if (goingDownTimer > 0) { goingDownTimer -= 1/60 * Delta; }
	}
	#endregion
	image_speed = oImageSpeed * Delta;
	//if (lifetime != "-" and lifetime > 0 and alarm[3] == -1) {
	if (lifetime != "-" and lifetime > 0 and lifetimeAlarm == 0) {
	    //alarm[3] = lifetime * 60;
	    lifetimeAlarm = lifetime * 60;
	}
	if (instance_exists(target)) {
		if (pattern == Patterns.Horde or pattern == Patterns.WallLeftRight or pattern == Patterns.StampedeRight) { followPlayer = false;}
		if (followPlayer) {
			var _bossoffset = 0;
			if (thisEnemy == Enemies.FubuZilla) {
			    _bossoffset = 32;
			}
			direction=point_direction(x,y,target.x,target.y + _bossoffset);
			if (boss) {
				if(target.x < x) image_xscale = -2;
				if(target.x > x) image_xscale = 2;
				image_yscale = 2;
			}
			else{
				if(target.x < x) image_xscale = xscale * -1;
				if(target.x > x) image_xscale = xscale;
				image_yscale = yscale;
			}
		}
	}
	if (customSpawn and distance_to_point(dieX, y) < 10) {
		dropxp = false;
		hp = 0;
	}
	
	if (hp<=0) {
		if (!saved) {
			saved = true;
		    var part = part_system_create(part_saved);
			//feather disable once GM2017
			part_system_position(part, x, y - (sprite_get_height(sprite_index) /2));
			if (carryingBomb) {
			    instance_create_depth(x, y, depth, oUpgrade,{
					upg : WEAPONS_LIST[Weapons.ImDieExplosion][1],
					speed : WEAPONS_LIST[Weapons.ImDieExplosion][1][$ "speed"],
					hits : WEAPONS_LIST[Weapons.ImDieExplosion][1][$ "hits"],
					shoots : WEAPONS_LIST[Weapons.ImDieExplosion][1][$ "shoots"],
					sprite_index : WEAPONS_LIST[Weapons.ImDieExplosion][1][$ "sprite"],
					level : WEAPONS_LIST[Weapons.ImDieExplosion][1][$ "level"],
					mindmg: WEAPONS_LIST[Weapons.ImDieExplosion][1][$ "mindmg"],
					maxdmg: WEAPONS_LIST[Weapons.ImDieExplosion][1][$ "maxdmg"],
					image_xscale : 0,
					image_yscale : 0,
				});
			}
			if (dropxp) {
				global.defeatedEnemies += 1;
			    instance_create_layer(x,y,"Instances",oXP, {xp : xp});
			}
		}		
		if (!deathSent) {
		    deathSent = true;
			sendMessageNew(Network.DestroyInstance, {instancedata : json_stringify({id : enemyID, type : "enemy"})});
		}
		
		image_alpha-=.05 * Delta;
		x-=image_xscale;
		if (boss and global.screenShake == 1) {
			oGame.shakeMagnitude=6;
		}
		if (image_alpha <= 0) {
		    instance_destroy();
		}
	}
	// Feather disable once GM2016
	atk = ((baseATK + (2 * global.timeA)) * (1 + (global.timeB / 25))) * atkMult;
	if (canwalk) {
	    speed = ((baseSPD + (0.12 * global.timeA)) * (1 + (global.timeB / 25)) * spdMult) * Delta;
		if (distance_to_point(target.x, target.y - 8) < 3) {
		    speed = 0;
		}
		if (groundPounding) {
		    speed = speed / 1.5;
		}
		if (oPlayer.spaghettiEaten) {
			for (var i = 0; i < array_length(PLAYER_PERKS); ++i) {
			    if (PLAYER_PERKS[i].id == PerkIds.TrashBear) {
				    speed = speed * PLAYER_PERKS[i].spdDebuff;
				}
			}
		    
		}
		for (var i = 0; i < array_length(debuffs); ++i) {
		    if (other.debuffs[i].id == BuffNames.Paralyzed) {
			    speed = 0;
			}
		}
	}
	else{
		speed = 0;
	}
	
	var debuffLenght = array_length(debuffs);	
	#region debuff cooldown
	if (debuffLenght > 0) {	
		for (var i = 0; i < debuffLenght; ++i) {
			if (!variable_struct_exists(debuffs[i], "cooldown")) { continue; }
		    if (debuffs[i].cooldown > 0) {
			    debuffs[i].cooldown -= 1/60 * Delta;
				//show_message(debuffs[i].cooldown);
			}
			else {
			    array_delete(debuffs, i, 1);
				i--;
				debuffLenght-=1;
			}
		}
	}
	#endregion
}
var pausedamaged = false;
