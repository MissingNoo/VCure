if (!instance_exists(oEnemy)) { instance_destroy(); }
if (global.gamePaused) { exit; }
maxImg = sprite_get_number(sprite_index);
sprSpeed = sprite_get_speed(sprite_index);
sprSpeedType = sprite_get_speed_type(sprite_index);

if (socket == oPlayer.socket) {
    owner = instance_nearest(x,y,oPlayer);
}else{
	owner = instance_nearest(x,y, oSlave);
}

#region Start
// Feather disable GM2016
if (a==0) {
	_extrainfo = {upg : upg[$"id"]};
if (shoots > 0 and WEAPONS_LIST[upg.id][1].enchantment == Enchantments.Projectile) {
	shoots += 1;
}
speed = upg[$ "speed"];
mindmg = upg[$ "mindmg"];
maxdmg = upg[$ "maxdmg"];
if (WEAPONS_LIST[upg.id][1].enchantment == Enchantments.Damage) {
    mindmg = mindmg * 1.15;
    maxdmg = maxdmg * 1.15;
}
hits = upg[$ "hits"];
if (variable_struct_exists(upg, "size")) {
	    image_xscale = upg[$ "size"];
	    image_yscale = upg[$ "size"];
	}
if (variable_struct_exists(upg, "bolts")) {
    bolts = bolts == -1 ? upg[$ "bolts"] : -1;
}
if (shoots == 0) {
    shoots = upg[$ "shoots"];
}
if (shoots > 1) {
	arrowDir = global.arrowDir;
	if (variable_struct_exists(upg, "attackdelay")) {
		//alarm[0] = upg[$ "attackdelay"];
		dAlarm[0] = upg[$ "attackdelay"];
	}
	else{
		//alarm[0] = 1;
		dAlarm[0] = 1;
	}
}
sprite_index=upg[$ "sprite"];
subImg = 0;
image_index = 0;
image_speed = 0;


	var randomEnemy;
	//feather disable once GM2017
	#region Growth damage bonus
	if (upg[$ "perk"] and global.shopUpgrades.Growth.level == 1) {
	    for (var i = 0; i < global.level; ++i) {
		    mindmg = mindmg + (mindmg* 2 / 100);
			maxdmg = maxdmg+ (maxdmg* 2 / 100);
		}
	}
	#endregion
	var cooldown = upg[$ "cooldown"];
	if (upg[$ "canBeHasted"] == true and oPlayer.weaponHaste != 0) {
	    cooldown -= (cooldown * oPlayer.weaponHaste) - cooldown;
		//show_debug_message(string($ "{upg[$ "cooldown"]}/{cooldown}/{oPlayer.weaponHaste}"));
	}
	var minCooldown = upg[$ "minimumcooldown"];
	if (cooldown < minCooldown) {
	    cooldown = minCooldown;
	}
	if (WEAPONS_LIST[upg.id][1].enchantment == Enchantments.Cooldown) {
		cooldown = cooldown * 0.9;
	}
	global.upgradeCooldown[upg[$ "id"]] = cooldown;
	dAlarm[1] = upg[$ "duration"];
	image_speed=1;
	image_alpha=1;
	a=1;
	//if (shoots > 0) {
	//    show_debug_message("Spawned: " + string(upg[$ "id"]) + " Name: " + upg[$ "name"] + " Level: " + string(upg[$ "level"]) + " shoots: " + string(shoots) + " cooldown: " + string(upg[$ "cooldown"]) );
	//}
	if (variable_struct_exists(upg, "sound") and upg[$ "sound"] != "") {
		if (is_array(upg[$ "sound"])) {
			var snd = irandom_range(0, array_length(upg[$ "sound"])-1);
		    audio_play_sound(upg[$ "sound"][snd],0,0);
		}else{
			audio_play_sound(upg[$ "sound"],0,0);
		}
	    
	}
	//show_message(string(image_xscale));
	if (variable_struct_exists(upg, "func")) {
	    upg[$ "func"](0);
	}
	//else {
	//	default_behaviour();
	//}
	if (sprite_index==sBlank and !variable_struct_exists(upg, "collab")) {
			instance_destroy();
	}
	if (variable_struct_exists(upg, "size")) {
	    image_xscale = upg[$ "size"];
	    image_yscale = upg[$ "size"];
	}
	if (WEAPONS_LIST[upg.id][1].enchantment == Enchantments.Size) {
		image_xscale = image_xscale * 1.15;
		image_yscale = image_yscale * 1.15;
	}
	originalSize = [image_xscale, image_yscale];
	for (var i = 0; i < array_length(Bonuses[BonusType.WeaponSize]); ++i) {
	    if (Bonuses[BonusType.WeaponSize][i] != 0 and upg[$ "id"] != Weapons.HoloBomb) {
			if (image_xscale > 0) { 
				image_xscale = image_xscale * Bonuses[BonusType.WeaponSize][i]; 
			}
			else {
				image_xscale = image_xscale * (Bonuses[BonusType.WeaponSize][i] * -1); 
			}
			//image_yscale = image_yscale * Bonuses[BonusType.WeaponSize][i];
			image_yscale = image_xscale;
		}
	}
	{ //online code
		_extrainfo.uid = upg.id;
		if (speed != 0) {
		    _extrainfo.speed = speed;
		}
		if (image_xscale != 1) {
		    _extrainfo.xscale = image_xscale;
		}
		if (image_yscale != 1) {
		    _extrainfo.yscale = image_yscale;
		}
		_extrainfo.speed = speed;
		_extrainfo.shoots = shoots;
		if (variable_struct_exists(upg, "afterimage")) {
		    _extrainfo.afterimageColor = upg.afterimageColor;
		}
		//vars = variable_instance_get_names(self);
		//savedvars = {};
		//for (var i = 0; i < array_length(vars); ++i) {
		//    variable_struct_set(savedvars, vars[i], variable_instance_get(self, vars[i]));
		//}
		//sendvars = json_stringify(savedvars);
		if (!variable_instance_exists(self, "sent")) {
			sent = true;
			sendMessage({
				command : Network.SpawnUpgrade,
				socket : oClient.connected,
				x,
				y,
				sprite_index,
				direction,
				image_angle,
				upgID,
				//haveafterimage : (variable_struct_exists(upg, "afterimage")) ? true : false,
				extraInfo : json_stringify(_extrainfo)
			});
		}
	}	
}
#endregion