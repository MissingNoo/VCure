if (instance_number(oXP) > 150) {
	instance_create_depth(x, y, depth, oRainbowXP);
}
/// @instancevar {Any} can_collab
/// @instancevar {Any} tick_powers
#region Debug
//feather disable GM2017
//DebugManager.debug_add_config("Anvil", DebugTypes.Button, undefined, undefined, function(){instance_create_depth(oPlayer.x,oPlayer.y + 20, depth, oAnvil);});
//DebugManager.debug_add_config("Add 100 coins", DebugTypes.Button, undefined, undefined, function(){global.newcoins+=100;});
#endregion
if (!instance_exists(oCamWorld)) { instance_create_depth(x, y, depth, oCamWorld); }
can_collab();
if (!global.gamePaused and device_mouse_check_button_pressed(0, mb_left) and os_type != os_android and !(instance_exists(DebugManager) and mouse_on_area(DebugManager.screenarea))) {
    mouseAim = !mouseAim;
	if (!mouseAim) {
	    global.arrowDir = 0;
	}
}
var baseScore = (global.defeatedEnemies * 75) + (global.minibossDefeated * 428) + (global.bossDefeated * 2251) + (max(0, global.minutes - 30) * 20126) + (min(59, global.minutes) * 126) + (min(59, global.seconds) * 10) + (global.level * 1219);
var hardcoreBonus = 0;
if (global.shopUpgrades.Hardcore.level == 1) {
	hardcoreBonus = floor(baseScore * (global.minutes * 0.01 + global.hours* 1.2));
}
global.score = floor(baseScore + hardcoreBonus);
//WEAPONS_LIST[Weapons.BlBook][1].enchantment = Enchantments.Size;
#region ATK
var calc = 0;
calc += get_bonus_percent(BonusType.Damage, "Atk", 6)
atkpercentage = clamp(calc, 1, infinity);
#endregion
#region critChance
var calc = 0;
calc += real(string_replace(string(global.player[?"crit"]), "1.", ""));
calc += get_bonus_percent(BonusType.Critical, "Crit", 2)
critChance = calc;
#endregion
#region Haste
weaponHaste = get_bonus_percent(BonusType.Haste, "Haste", 4);
#endregion
image_speed = global.gamePaused ? 0 : oImageSpeed * Delta;
socket = global.socket;
if (global.gamePaused) { return; }
if (invencibilityFrames > 0) { invencibilityFrames--; }

#region drops
var _list = ds_list_create();
var _num = collision_circle_list(x, y, pickupRadius, oDropParent, false, true, _list, true);
var _drop = noone;
if (_num > 0) {
	for (var i = 0; i < _num; ++i) {
		_drop = _list[| i];
		_drop.direction = point_direction(_drop.x, _drop.y,oPlayer.x,oPlayer.y - 16);
		_drop.speed = (spd * 1.3) * Delta;
		_drop.onArea = true;
	}
}
#endregion
#region Menhera
if (menheraTimer > 0) {
	menheraTimer -= 1/60 * Delta;
}
if (menheraTimer <= 0) {
	menhera = false;
}
#endregion
#region Delta Alarms
for (var i = 0; i < array_length(dAlarm); ++i) {
	if (dAlarm[i] != -1) {
		dAlarm[i] -= 1 * Delta;
	}
	if (dAlarm[i] < 0 and dAlarm[i] != -1) {
		dAlarm[i] = -1;
		event_user(i);
	}
}
#endregion
#region Specials
tickTimer(["bladeFormTimer", bladeFormEnd]);
tickTimer(["afterImageTimer", afterImageTimerEnd]);
tickTimer(["slowTimeTimer", slowTimeEnd]);
if (skilltimer < specialcooldown + 10) { skilltimer+=1/60; }
if (input_check_pressed("cancel") and skilltimer > specialcooldown and global.shopUpgrades[$ "SpecialAtk"][$ "level"] == 1) { use_special(special);	}
if (global.lastsequence != undefined) {
	layer_sequence_x(global.lastsequence, oPlayer.x);
	layer_sequence_y(global.lastsequence, oPlayer.y);
}
#region Monster
if (monsterUsed) {
	monsterTimer -= 1/60*Delta;
	if (monsterTimer <= 0) {
		monsterUsed = false;
	}
}
#endregion
#region Anya
if (bladeForm) {
	image_xscale = 1;
	rotationSpeed += BLADE_FORM_ACCELERATION;
	if (rotationSpeed >  BLADE_FORM_MAX_ACCELERATION) {
	    rotationSpeed = BLADE_FORM_MAX_ACCELERATION;
	}
	image_angle -= rotationSpeed;
	immortal = true;
	lockSprite = true;
	if (rotationSpeed < BLADE_FORM_CHANGE_FORM) {
	    sprite_index = sAnyaBlade1;
	}
	else {
		sprite_index = sAnyaBlade2;
	}
}
#endregion
#endregion
tick_powers();
tick_items();
var previousSprite = sprite_index;
Movement();
#region Multiplayer sync
if (x != xprevious or y != yprevious or previousSprite != sprite_index) {
	sendMessage(0, {
		command : Network.Move,
		socket : socket,
		x : x,
		y : y, 
		image_xscale : image_xscale,
		sprite : sprite_index,
		spd
	});
}
#endregion
#region RedGura //UNUSED
//if(redgura){
//	//feather disable once GM2017
//	part_red ??= part_system_create(part_GuraRed);
//	//feather disable once GM2017
//	part_system_position(part_red, x, y);
//	// show_debug_message(time_source_get_time_remaining(redtime));
//	var _timestate = time_source_get_state(redtime);
//	if(_timestate == time_source_state_initial or _timestate == time_source_state_stopped){
//		time_source_start(redtime);
//	}
//}
#endregion
#region XP Check	
if (global.xp<0) {
	global.xp = 0;
}
if (global.xp >= neededxp) {
	global.level += 1;
	instance_create_depth(0, 0, 0, oLevelUpControl);
	pause_game();
}
#endregion
#region Life Checks
if (HP > MAXHP) {
	HP=MAXHP;
}
if (HP <= 0) {
	if (revives <= 0 and !dead) {
		canMove = false;
		dead = true;
		global.mode = "menu";
		global.holocoins += global.newcoins;
		image_alpha = 0;
		var heartOff = 0;
		for (var i = 0; i < 8; ++i) {
			var inst = instance_create_depth(x,y,depth, oDeathHeart,{direction : heartOff});
			heartOff += 45;
		}
		if (dAlarm[3] == -1) {
			dAlarm[3] = 60;
		}
	}
	else if (revives > 0){
		HP = MAXHP/2;
		revives -= 1;
		with (oEnemy) {
			if (!boss) {
				instance_destroy();
			}
		}
	}
	ANVIL = false;
	GoldenANVIL = false;
	global.upgrade = false;
	mouseAim = false;
}
#endregion
#region Healing
#region heal every five seconds if shop upgrade
if (global.shopUpgrades[$ "Regeneration"][$ "level"] > 0 and !global.gamePaused) {
	healSeconds+=1/60 * Delta;
	if (healSeconds > 5) {
		HP += 1 * global.shopUpgrades[$ "Regeneration"][$ "level"];
		healSeconds = 0;
	}
}
#endregion
#region Just Bandage Healing
if (haveBandage and justBandageHealing > 0) {
	bandageHealSeconds+=1/60 * Delta;
	if (bandageHealSeconds > 3) {
		var _amount = (HP * 10) / 100;
		if (_amount < 1) {
			_amount = 1;
		}
		HP += _amount;
		bandageHealSeconds = 0;
		justBandageHealing -= _amount;
		if (justBandageHealing < 0) {
			justBandageHealing = 0;
		}
	}
}
#endregion
#endregion
#region spd calc
calc = ospd;
calc += get_bonus_percent(BonusType.Speed, "Spd", 6);
spd = ospd + ((ospd * calc) / 100);
if (wallMart) { spd = spd * 0.25; }
#endregion
#region pickup calc
	//calc = 1;
	var _newRange = originalPickupRadius;
	_newRange += get_bonus_percent(BonusType.PickupRange, "PickUp", 10);
	pickupRadius = _newRange;
#endregion