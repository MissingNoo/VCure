/// @instancevar {any} owner 
/// @instancevar {Any} upg 
/// @instancevar {Any} shotType 
oid = irandom(999999);
paused = false;
alpha = 1;
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
	if (!global.singleplayer) {
		sendMessageNew(Network.DestroyInstance, {instancedata : json_stringify({id : oid, type : "upg"})});
	}
	//instance_destroy();
	x = 9999999;
	y = 9999999;
	visible = false;
	paused = true;
	ds_stack_push(global.upinstances, self.id);
}]);
reverseshoots = -1;
if (upg[$ "attackdelay"] == undefined) {
	upg[$ "attackdelay"] = 0.001;
}
atkdelayalarm = array_length(dAlarm);
array_push(dAlarm, [upg.attackdelay, function() {
	if (shoots > 1) {
		shoots--;
		/// @localvar {Any} orbitoffset 
		spawn_upgrade(owner.x, owner.y-8, upg, {upg : upg, arrowDir : arrowDir, shoots : -1, reverseshoots : reverseshoots, remaining_shoots : shoots, orbitPlace : (orbitoffset * shoots)});
		//instance_create_layer(, "Upgrades", oUpgradeNew, );
		reverseshoots -= 1;
		dAlarm[atkdelayalarm][0] = upg.attackdelay;
	}}]);
//else if (shoots > 0) { show_debug_message($"Weapon {upg.name} has multiple projectiles but no attackdelay entry") };

#region Cooldown
var cooldown = upg[$ "cooldown"];
if (upg[$ "canBeHasted"] == true) {
	cooldown = cooldown - ((cooldown * oPlayer.weaponHaste) / 100);
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
original_scale = [image_xscale, image_yscale];
calc = get_bonus_percent(BonusType.WeaponSize);
if (image_xscale > 0) { 
	image_xscale = image_xscale + ((image_xscale * calc) / 100); 
}
else {
	image_xscale = image_xscale * -1;
	image_xscale = image_xscale + ((image_xscale * calc) / 100); 
	image_xscale = image_xscale * -1; 
}
image_yscale = image_xscale;
#endregion

if (upg[$ "create"] != undefined) {
	upg.create(self.id);
}
if (!global.singleplayer and sendspawn) {
	sendspawn = false;
	var updata = {};
	var names = ["direction", "image_xscale", "image_yscale", "image_angle", "sprite_index", "oid"];
	for (var i = 0; i < array_length(names); i++) {
		updata[$ names[i]] = self[$ names[i]];
	}
	sendMessageNew(Network.SpawnUpgrade, {id : upg.id, level : upg.level, updata : json_stringify(updata)});
}
visible = true;