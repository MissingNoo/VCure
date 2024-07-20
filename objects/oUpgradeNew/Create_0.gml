resetcooldown = false;
cooldownwasreset = false;
animate = true;
sprite_index = upg.sprite;
speed = upg.speed;
if (shoots == 0) {
    shoots = upg.shoots;
}
hits = upg.hits;
maxdmg = upg.maxdmg;
mindmg = upg.mindmg;
last_frame = sprite_get_number(sprite_index);
sprite_speed = sprite_get_speed(sprite_index);
sprite_speed_type = sprite_get_speed_type(sprite_index);
dAlarm = [];
array_push(dAlarm, [upg.duration, function() {
	instance_destroy();
}]);
if (upg[$ "attackdelay"] != undefined) {
	atkdelayalarm = array_length(dAlarm);
	array_push(dAlarm, [upg.attackdelay, function() {
		if (shoots > 1) {
			shoots--;
			instance_create_layer(oPlayer.x, oPlayer.y-8, "Upgrades", oUpgradeNew, {upg : upg, shoots : -1, remaining_shoots : shoots, orbitPlace : (orbitoffset * shoots)});
		    dAlarm[atkdelayalarm][0] = upg.attackdelay;
		}}]);
}

#region Cooldown
var cooldown = upg.cooldown;
if (upg.canBeHasted == true and oPlayer.weaponHaste != 0) {
	cooldown -= (cooldown * oPlayer.weaponHaste) - cooldown;
}
if (upg[$ "minimumcooldown"] != undefined and cooldown < upg.minimumcooldown) {
	cooldown = upg.minimumcooldown;
}
if (WEAPONS_LIST[upg.id][1].enchantment == Enchantments.Cooldown) {
	cooldown = cooldown * 0.9;
}
#region weapons that affect cooldown
if (oPlayer.slowTime and upg.id == Weapons.AmePistol) {
	cooldown = cooldown / 2;
}
#endregion
global.upgradeCooldown[upg.id] = cooldown;
#endregion

#region Sound
if (variable_struct_exists(upg, "sound") and upg[$ "sound"] != "") {
	if (is_array(upg[$ "sound"])) {
		var snd = irandom_range(0, array_length(upg[$ "sound"])-1);
		audio_play_sound(upg[$ "sound"][snd],0,0, global.soundVolume);
	}else{
		audio_play_sound(upg[$ "sound"],0,0, global.soundVolume);
	}	    
}
#endregion

#region Sprite size
if (variable_struct_exists(upg, "size")) {
	image_xscale = upg[$ "size"];
	image_yscale = upg[$ "size"];
}
if (WEAPONS_LIST[upg.id][1].enchantment == Enchantments.Size) {
	image_xscale = image_xscale * 1.15;
	image_yscale = image_yscale * 1.15;
}
for (var i = 0; i < array_length(Bonuses[BonusType.WeaponSize]); ++i) {
	if (Bonuses[BonusType.WeaponSize][i] != 0 and upg[$ "id"] != Weapons.HoloBomb) {
		if (image_xscale > 0) { 
			image_xscale = image_xscale * Bonuses[BonusType.WeaponSize][i]; 
		}
		else {
			image_xscale = image_xscale * (Bonuses[BonusType.WeaponSize][i] * -1); 
		}
		image_yscale = image_xscale;
	}
}
#endregion

if (upg[$ "create"] != undefined) {
	upg.create(self.id);
}
visible = true;