/*var _oldsprite = sprite_index;
var _oldsub = subImg;
switch (upg[$ "id"]) {
	case Weapons.UrukaNote:{
		if (sprite_index == sNoteExplosion) {
		    instance_destroy();
		}
		break;}
	case Weapons.Mold:{
		instance_destroy();
		break;}
	case Weapons.LiaBolt:{
		if (sprite_index == sLiaBoltShock) {
		    instance_destroy();
		}
		break;}
	case Weapons.EliteLavaBucket:{
		
		break;}
	case Weapons.FanBeam:{
		image_alpha = 0;
		instance_destroy();
		break;
	}
	case Weapons.HoloBomb:{
		if (sprite_index == sBombExplosion) {
		    instance_destroy();
		}
		break;}
	case Weapons.Glowstick:{
		if (sprite_index == sGlowstickThumbExplosion) {
		    instance_destroy();
		}
		else{
			subImg = 0;
		}
		break;}
	case Weapons.WamyWater:{
		    instance_destroy();
		break;}
	case Weapons.HeavyArtillery:{
		    instance_destroy();
		break;}
	case Weapons.Shockwave:{
		    instance_destroy();
		break;}
	case Weapons.XPotatoExplosion:{
		    instance_destroy();
		break;}
	#region Collabs
	#region MiComet
	case Weapons.MiCometMeteor:{
		if (sprite_index == sMiCometSplash) {
			//instance_create_depth(x, y - (sprite_get_height(WEAPONS_LIST[Weapons.MiCometPool][1][$ "sprite"]) * WEAPONS_LIST[Weapons.MiCometPool][1][$ "size"]) / 2, depth, oUpgrade,{
			//		upg : WEAPONS_LIST[Weapons.MiCometPool][1],
			//		speed : WEAPONS_LIST[Weapons.MiCometPool][1][$ "speed"],
			//		hits : WEAPONS_LIST[Weapons.MiCometPool][1][$ "hits"],
			//		shoots : WEAPONS_LIST[Weapons.MiCometPool][1][$ "shoots"],
			//		sprite_index : WEAPONS_LIST[Weapons.MiCometPool][1][$ "sprite"],
			//		level : WEAPONS_LIST[Weapons.MiCometPool][1][$ "level"],
			//		mindmg: WEAPONS_LIST[Weapons.MiCometPool][1][$ "mindmg"],
			//		maxdmg: WEAPONS_LIST[Weapons.MiCometPool][1][$ "maxdmg"]
			//	});
			instance_destroy();
		}
		if (sprite_index == sMiComet) {
			subImg = 0;
		    sprite_index = sMiCometSplash;
		}
		break;}
	case Weapons.MiCometPool:{
		if (sprite_index == sLavaPoolLoop) {
		    subImg = 0;
		}
		if (sprite_index == sLavaPoolStart) {
			subImg = 0;
		    sprite_index = sLavaPoolLoop;
		}
		if (sprite_index == sLavaPoolEnd) {
			image_alpha = 0;
		}
		break;}
	#endregion
	#region Breathin
	case Weapons.BreatheInTypeAsacoco:{
		if (sprite_index == sBombExplosion) {
		    instance_destroy();
		}
		break;}
	#endregion
	#endregion
    default:
        subImg = 0;
        break;
}
maxImg = sprite_get_number(sprite_index);
sprSpeed = sprite_get_speed(sprite_index);
sprSpeedType = sprite_get_speed_type(sprite_index);
if (sprite_index != _oldsprite) {
sendMessage(0, {
		command : Network.UpdateUpgrade,
		socket,
		upgID,
		extrainfo : json_stringify({sprite_index, image_index : _oldsub})
	});
}