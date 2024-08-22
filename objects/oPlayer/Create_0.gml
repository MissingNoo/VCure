/// @instancevar {Integer} blacksmithLevel
#region debug overlay
/// @instancevar {Any} dbg_slider_int 
/// @instancevar {Any} dbg_same_line 
/// @instancevar {Any} dbg_sprite_button 
/// @instancevar {Any} dbg_view_exists 
/// @instancevar {Any} dbg_view
/// @instancevar {Any} dbg_section
/// @instancevar {Any} dbg_text_input
/// @instancevar {Any} ref_create
/// @instancevar {Any} dbg_checkbox    
/// @instancevar {Any} dbg_view_delete 
/// @instancevar {Any} dbg_button 
inspector = -1;
weaponview = -1;
itemview = -1;
levelupweaponpos = 0;
levelupweapon = function() {
	var pos = oPlayer.levelupweaponpos;
	if (UPGRADES[pos].level < UPGRADES[pos].maxlevel) {
		UPGRADES[pos] = global.upgradesAvaliable[UPGRADES[pos].id][UPGRADES[pos].level + 1];
		oGui.upgradesSurface();
	}
}
leveldownweapon = function() {
	var pos = oPlayer.levelupweaponpos;
	if (UPGRADES[pos].level > 1) {
		UPGRADES[pos] = global.upgradesAvaliable[UPGRADES[pos].id][UPGRADES[pos].level - 1];
		oGui.upgradesSurface();
	}
}
openweaponview = function() {
	var pos = oPlayer.levelupweaponpos;
	if (dbg_view_exists(weaponview)) {
		dbg_view_delete(weaponview);
	}
	weaponview = dbg_view($"{UPGRADES[pos].name}", true, GW/2, GH/2, 400, 500);
	dbg_button("Level +", levelupweapon);
	dbg_same_line();
	dbg_button("Level -", leveldownweapon);
	dbg_section("Stats");
	_names = struct_get_names(UPGRADES[pos]);
	for (var i = 0; i < array_length(_names); i += 1) {
		if (is_real(UPGRADES[pos][$ _names[i]])) {
			dbg_slider_int(ref_create(UPGRADES[pos], _names[i]), 0, 999, $"{_names[i]}:", 1);
		}
	}
}
openItemView = function() {
	var pos = oPlayer.itemselected;
	if (dbg_view_exists(itemview)) {
		dbg_view_delete(itemview);
	}
	itemview = dbg_view($"{playerItems[pos].name}", true, GW/2, GH/2, 400, 500);
	dbg_button("Level +", levelupweapon);
	dbg_same_line();
	dbg_button("Level -", leveldownweapon);
	dbg_section("Stats");
	_names = struct_get_names(playerItems[pos]);
	for (var i = 0; i < array_length(_names); i += 1) {
		if (is_real(playerItems[pos][$ _names[i]])) {
			dbg_slider_int(ref_create(playerItems[pos], _names[i]), 0, 999, $"{_names[i]}:", 1);
		}
	}
}
updateInspector = function() {
	if (dbg_view_exists(inspector)) {
		dbg_view_delete(inspector);
	}
	if (!dbg_view_exists(inspector)) {
		inspector = dbg_view($"Player", false, 500, 8 * 30);
		dbg_section("Player");
		dbg_slider_int(ref_create(global, "hp"), 0, MAXHP, $"HP:", 1);
		dbg_checkbox(ref_create(self.id, "immortal"), "Immortal:");
		dbg_button("Level UP", function(){ global.xp += oPlayer.neededxp; });
		dbg_same_line();
		dbg_button("Reroll", function(){ random_upgrades(); });
		dbg_button("Skill Cooldown", function(){ oPlayer.skilltimer = 999; });
		dbg_button("Spawn Anvil", function(){ instance_create_depth(oPlayer.x, oPlayer.y + 20, oPlayer.depth, oAnvil); });		
		
		#region Weapons
		dbg_section("Weapons");
		var n0 = UPGRADES[0].name;
		dbg_button(n0, function(){
			oPlayer.levelupweaponpos = 0;
			openweaponview();
		}, string_width(n0) * 2);
		var n1 = UPGRADES[1].name;
		dbg_same_line();
		dbg_button(n1, function(){
			oPlayer.levelupweaponpos = 1;
			openweaponview();
		}, string_width(n1)*2);
		var n2 = UPGRADES[2].name;
		dbg_button(n2, function(){
			oPlayer.levelupweaponpos = 2;
			openweaponview();
		}, string_width(n2)*2);
		var n3 = UPGRADES[3].name;
		dbg_same_line();
		dbg_button(n3, function(){
			oPlayer.levelupweaponpos = 3;
			openweaponview();
		}, string_width(n3)*2);
		var n4 = UPGRADES[4].name;
		dbg_button(n4, function(){
			oPlayer.levelupweaponpos = 4;
			openweaponview();
		}, string_width(n4)*2);
		var n5 = UPGRADES[5].name;
		dbg_same_line();
		dbg_button(n5, function(){
			oPlayer.levelupweaponpos = 5;
			openweaponview();
		}, string_width(n5)*2);
		#endregion
		#region Items
		dbg_section("Items");
		dbg_button(playerItems[0].name, function(){
			oPlayer.selectedItem = 0;
			openItemView();
		});
		dbg_same_line();
		dbg_button(playerItems[1].name, function(){
			oPlayer.selectedItem = 1;
			openItemView();
		});
		dbg_button(playerItems[2].name, function(){
			oPlayer.selectedItem = 2;
			openItemView();
		});
		dbg_same_line();
		dbg_button(playerItems[3].name, function(){
			oPlayer.selectedItem = 3;
			openItemView();
		});
		dbg_button(playerItems[4].name, function(){
			oPlayer.selectedItem = 4;
			openItemView();
		});
		dbg_same_line();
		dbg_button(playerItems[5].name, function(){
			oPlayer.selectedItem = 5;
			openItemView();
		});
		#endregion
		dbg_button("Update", updateInspector);
	}
}
#endregion
sendpostimer = 0;
event_inherited();
initializePlayer(global.player);
updateInspector();
buffs = [];
lockSprite = false;
moving = false;
characterHeight = sprite_get_height(sprite_index);
#region Variables related to items
idolCostumeLevel = 0;
pimanLevel = 0;
pimanUsable = false;
justBandageHealing = 0;
haveBandage = false;
bandageLevel = 0;
bandageHealSeconds = 0;
#endregion
#region Player Variables
#region Perks
#region Aki
aromateraphy = [false, 0, 0, 0, 0];
mukirose = [false, 0, 0, 0, 0];
#endregion
#region Anya
bladeForm = false;
bladeFormTimer = 0;
bladeFormEnd = function(){
	bladeForm = false;
	immortal = false;
	lockSprite = false;
	image_angle = 0;
	rotationSpeed = 0;
};
rotationSpeed = 0;
bladeFormAfterImages = [];
afterImageTimer = BLADE_FORM_AFTERIMAGE_COOLDOWN;
afterImageTimerEnd = function(a){
	afterImageTimer = BLADE_FORM_AFTERIMAGE_COOLDOWN;
	bladeFormAfterImages = [];
	array_push(bladeFormAfterImages, image_angle);
	if (array_length(bladeFormAfterImages) >= 5) {
	    array_shift(bladeFormAfterImages);
	}
};
#endregion
#region Amelia
slowTime = false;
slowTimeTimer = 0;
slowTimeEnd = function(){ slowTime = false; };
#endregion
#endregion
if (!instance_exists(oCam)) {
    instance_create_depth(x,y,0,oCam);
}
reset_timer();
reset_pool();
// Feather disable once GM2017
global.rerolls = global.shopUpgrades.Reroll.level;
critChance = 0;
oImageSpeed = image_speed;
pickupRadius = 35;
originalPickupRadius = pickupRadius;
//feather disable once GM2017
in_range = noone;
canShoot=1;
neededxp = 79;
atkpercentage=0;
v=0;
global.arrowDir=0;
canMove=true;
ospd = spd;
healSeconds = 0;
dAlarm = array_create(11, -1);
weaponHaste = 0;
renderDistance = x + (view_wport[0] / 2);
immortal = false;
global.defeatedEnemies = 0;
skilltimer = 0;
special = SPECIAL_LIST[global.player[?"special"]];
specialcooldown = special.cooldown;
dead = false;
x1 = 0;
x2 = 0;
y1 = 0;
y2 = 0;
global.lastsequence = undefined;
invencibilityFrames = 0;
#region Uruka
spaghettiEaten = false;
monsterUsed = false;
monsterTimer = 0;
#endregion
#region Lia
menhera = false;
menheraTimer = 0;
menheraKills = 0;
liaLikers = 0;
#endregion
#region Pippa
wallMart = false;
wallmartTimer = 0;
#endregion
#endregion
#region Multiplayer
socket = 1;
if (global.singleplayer) {
	global.roomname = "";
	//feather disable once GM2017
	global.IsHost = true;
}
#endregion
#region Android Controls restart
if (variable_global_exists("aim")) {
    global.aim.destroy();
}
global.aim = input_virtual_create();
global.aim.rectangle(GW/2, GH/2, GW, GH);
//aim.circle(GW/1.2, GH/1.25, 60);
global.aim.follow(false);
if (variable_global_exists("move")) {
    global.move.destroy();
}
global.move = input_virtual_create();
//global.move.circle(GW/6, GH/1.25, 60);
global.move.rectangle(0, GH/2, GW/2, GH);
//aim.circle(GW/1.2, GH/1.25, 60);
global.move.follow(false);
#endregion
#region Unused
//global.testvar = "";
#region redgura unused
	//redgura = false;
	////feather disable once GM2017
	//part_red = undefined;
	////feather disable once GM2017
	//redstop = function(){redgura = false; part_system_destroy(part_red); part_red = undefined;}
	//redtime = time_source_create(time_source_game, 10, time_source_units_seconds,redstop);
#endregion
//lef =0;
//dow=0;
//rig=0;
//upp=0;
#endregion
function tickTimer(arr){
	var _count = variable_instance_get(self, arr[0]);
	if (_count == -1) { exit; }
	if (_count >= 0) {
	    variable_instance_set(self, arr[0], _count - ((1/60) * Delta));
	}
	if (_count < 0) {
		variable_instance_set(self, arr[0], -1);
		arr[1]();
	}
}