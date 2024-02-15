var _extra = {};
var _oldspeed = speed;
var _olddir = direction;
xpreviousprevious = x - (x - xprevious);
ypreviousprevious = y - (y - yprevious);
#region unused
//if (global.testvar == "") {
//    global.testvar = upg;
//}
#endregion

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
		case Weapons.ElectricPulse:{
			x = owner.x;
			y = owner.y;
			break;}
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
	if (speed > 0 and upg[$ "id"] != Weapons.CuttingBoard) {
	    speed=upg[$ "speed"] * Delta;
	}
	afterimage_step();	
	switch (upg[$ "id"]) {
		case Weapons.Brick:{
			image_angle -= 6;
			break;
		}
		case Weapons.PlugAsaCoco:{
			//if (alarm_get(1) > 0) {
			if (dAlarm[1] > 0) {
			    y-=1.75;
				_extra.asay = y;
				// feather disable once GM1041
				if (instance_exists(ce)) {
					direction = point_direction(x,y,ce.x, ce.y);
					image_angle = point_direction(x,y,ce.x, ce.y);
				}				
			}else {image_alpha = 1;}		
			break;}
		case Weapons.BlBook:{
			blbook_step();
			break;}
		case Weapons.BLFujoshiBook:{
			blfujoshibook_step();
			break;}
		case Weapons.BLFujoshiAxe:{
			blfujoshiaxe_step();
			break;}
		case Weapons.BoneBros:{
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
			break;}
		case Weapons.AbsoluteWall:{
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
			//orbitPlace = _offset;
			//orbitLength = 100;
			//image_angle = global.arrowDir + _offset;
			image_angle = global.arrowDir + _offset;
			//x = owner.x + lengthdir_x(orbitLength, round(orbitPlace));
			x = owner.x;
			//y = owner.y - 16 + lengthdir_y(orbitLength, round(orbitPlace));
			y = owner.y - 16;
			image_xscale = image_yscale + 0.5;
			_extra.x = x;
			_extra.y = y;
			_extra.image_angle = image_angle;
			_extra.image_xscale = image_xscale;
			_extra.image_yscale = image_yscale;
			break;}
		case Weapons.LiaBolt:{
			image_xscale = 0.2;
			image_yscale = 0.2;
			if (lightningTarget != noone and instance_exists(lightningTarget)) {
			    x = lightningTarget.x;
				y = lightningTarget.y;
				_extra.lx = x;
				_extra.ly = y;
			}
			break;}
		case Weapons.PsychoAxe:{
			psycho_axe_step();
			break;}
		case Weapons.CuttingBoard:{
			if (distance_to_point(xstart, ystart) > 5) {
				speed -= .30 * Delta;
				if (speed < 0) {
				    speed = 0;
				}
			}
			break;}
		case Weapons.Glowstick:{
			if (hits <= 0) {
			    sprite_index = sGlowstickThumbExplosion;
				speed = 0;
			}
			if (distance_to_object(owner) > 200) {
			    direction = point_direction(x,y,owner.x, owner.y);
			}
			break;}
		case Weapons.SpiderCooking:{
			x = owner.x;
			y = owner.y - (sprite_get_height(global.player[?"sprite"]) / 3);
			break;}
		case Weapons.IdolSong:{
			x = sine_wave(current_time  / 1000, 1 * (shoots % 2) ? 1 : -1, upg[$ "travelWidth"], idolStartX);
			break;}
		case Weapons.UrukaNote:{
			if (sprite_index == sMonsterPulse or sprite_index == sNoteExplosion) {
			    break;
			}
			//x = sine_wave(current_time  / 1000, 1 * (shoots % 2) ? 1 : -1, upg[$ "travelWidth"], noteStartX);
			//x = sine_wave(current_time  / 1000, 1, upg[$ "travelWidth"], noteStartX);
			//y = cose_wave(current_time  / 1000, 1 * (shoots % 2) ? 1 : -1, upg[$ "travelWidth"], noteStartY);
			y = cose_wave(coscounter / 1000, 1 * upDown, upg[$ "travelWidth"], noteStartY);
			if (image_xscale < 0) {
			    image_xscale = image_xscale * -1;
			}
			//y = cose_wave(current_time  / 1000, -1, upg[$ "travelWidth"], noteStartY);
			if (upg.level >= 4) {
				var _sizeGain = 0.003;
			    image_xscale += _sizeGain;
			    image_yscale += _sizeGain;
				sizeGained = image_xscale;
			}
			break;}
		case Weapons.BounceBall:{
			//if (direction != 270) {
			//    direction += 15 * (direction > 270) ? 1 : -1 ;
			//}
			
			//if (direction < 270) {
			//    direction += 5;
			//}
			//if (direction > 270) {
			//    direction -= 5;
			//}
			if (vspeed < upg[$ "speed"]) {
				vspeed += 0.55 * Delta;
			}
			move_and_collide(hspd, vspd, oEnemy);
			image_angle+=10;
			break;
		}
		case Weapons.BreatheInTypeAsacoco:{
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
			break;}
		case Weapons.EliteLavaBucket:{
			_extra.lx = x;
			_extra.ly = y;
			break;}
		case Weapons.EliteCooking:{
			if (poolSize != 1) {
			    poolSize -= 1;
				_extra.poolSize = poolSize;
			}			
			break;}
		case Weapons.StreamOfTears:{
			stream_of_tears();
			break;}
			case Weapons.ImDieExplosion:{
				explosionSize += .10;
				image_xscale = explosionSize;
				image_yscale = explosionSize;
				oGame.shakeMagnitude = oGui.e;
				break;}
		//case Weapons.XPotato:{
		//	image_angle += .5;
		//	if (x > oPlayer.x + (view_wport[0] / 2)) { direction += 180; }
		//	if (x < oPlayer.x - (view_wport[0] / 2)) { direction += 180; }
		//	if (y > oPlayer.y + (view_hport[0] / 2)) { direction += 180; }
		//	if (y < oPlayer.y - (view_hport[0] / 2)) { direction += 180; }
		//	break;
		//}
	}
}
#endregion



if (hits <= 0 and upg[$ "id"] != Weapons.Glowstick) {
	image_alpha=0;
}
//exit;
//cansend += 1/60;
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
//else { exit; }

//sendMessage({
//	command : Network.UpdateUpgrade,
//	socket,
//	upgID,
//	sprite_index,
//	direction,
//	x,
//	y,
//	image_alpha,
//	image_angle,
//	image_xscale,
//	image_yscale,
//	afterimg : json_stringify(afterimage),
//	extrainfo : ""
//});