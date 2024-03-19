_extra = {};
var _oldspeed = speed;
var _olddir = direction;
xpreviousprevious = x - (x - xprevious);
ypreviousprevious = y - (y - yprevious);
if (socket == oPlayer.socket) {
    owner = instance_nearest(x,y,oPlayer);
}else{
	owner = instance_nearest(x,y, oSlave);
}
#region Connected to Character
if (!global.gamePaused) {
	if (subImg < maxImg and sprReset) {
	    subImg += sprSpeed / game_get_speed(sprSpeedType) * Delta;
		if (subImg > maxImg) {
		    subImg = maxImg;
			event_perform(ev_other, ev_animation_end);
		}
	}
	#region broadcasts
	switch (upg[$ "id"]) {
	    case Weapons.MiCometMeteor:
	        if (floor(subImg) == 2 and !summoned) {
			    summoned = true;
				instance_create_depth(x, y - (sprite_get_height(WEAPONS_LIST[Weapons.MiCometPool][1][$ "sprite"]) * WEAPONS_LIST[Weapons.MiCometPool][1][$ "size"]) / 2, depth, oUpgrade,{
					upg : WEAPONS_LIST[Weapons.MiCometPool][1],
					speed : WEAPONS_LIST[Weapons.MiCometPool][1][$ "speed"],
					hits : WEAPONS_LIST[Weapons.MiCometPool][1][$ "hits"],
					shoots : WEAPONS_LIST[Weapons.MiCometPool][1][$ "shoots"],
					sprite_index : WEAPONS_LIST[Weapons.MiCometPool][1][$ "sprite"],
					level : WEAPONS_LIST[Weapons.MiCometPool][1][$ "level"],
					mindmg: WEAPONS_LIST[Weapons.MiCometPool][1][$ "mindmg"],
					maxdmg: WEAPONS_LIST[Weapons.MiCometPool][1][$ "maxdmg"]
				});
			}
	        break;
	    default:
	        // code here
	        break;
	}
	#endregion
	for (var i = 0; i < array_length(dAlarm); ++i) {
	    if (dAlarm[i] != -1) {
		    dAlarm[i] -= 1 * Delta;
		}
		if (dAlarm[i] < 0 and dAlarm[i] != -1) {
		    dAlarm[i] = -1;
			event_user(i);
		}
	}
	if (aikFollowTimer > 0) {
	    aikFollowTimer -= (1/60) * Delta;
	}
	else {
		aikFollow = true;
	}
	if (speed > 0 and upg[$ "id"] != Weapons.CuttingBoard) {
	    speed=upg[$ "speed"] * Delta;
	}
	afterimage_step();
	if (variable_struct_exists(upg, "func")) {
	    upg[$ "func"](WeaponEvent.Step);
	}
}
#endregion

if (hits <= 0 and upg[$ "id"] != Weapons.Glowstick) {
	image_alpha=0;
}

if (image_alpha == 0 and cansend) {
    cansend = false;
	sendMessage({
		command: Network.DestroyUpgrade,
		upgID,	
	});
}
if (sendend) {
	sendend = false;
	sendMessage({
		command : Network.UpdateUpgrade,
		socket,
		upgID,
		extrainfo : json_stringify({orbitPlace, orbitLength, speed, image_angle, direction})
	});
}

if (_oldspeed != speed) { _extra.speed = speed; }
if (_olddir != speed) { _extra.direction = direction;  _extra.image_angle = image_angle; }

sendMessage({
		command : Network.UpdateUpgrade,
		socket,
		upgID,
		extrainfo : json_stringify(_extra)
	});