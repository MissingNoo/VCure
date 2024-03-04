#region Locals Initialization
menuClick = false;
centered = false;
mousePrevious = [0,0];
released=false;
zKey = 0;
xKey = 0;
eKey = 0;
leftKey = 0;
rightKey = 0;
upKey = 0;
downKey = 0;
isP=global.gamePaused;
debug=false;
revives = 0;
event = 0;
unlockedAchievements = [];
reset_timer();
#endregion
#region Globals Initialization
global.showhpui = true;
#endregion
#region Selection screen
characterSelected = false;
selectedCharacter = 1;
#region Character Sprite
characterSubImage = [0, 0, 0];
spriteChangeTimer = 3;
currentSprite = 0;
#endregion
#region Outfits
selectingOutfit = false;
selectedOutfit = 0;
global.selectedOutfit = 0;
maxOutfits = 0;
outfitSelected = false;
outfitIdleAnimation = [0, 0];
outfitIdleSpeed = 0;
selected=0;
maxselected = selected;
color=c_white;
#endregion
#endregion
#region Stage
#region Anvil
gAnvilWeapon1 = global.null;
gAnvilWeapon2 = global.null;
gAnvilWeapon1Position = 0;
gAnvilWeapon2Position = 0;
canCollab = false;
anvilconfirm = false;
upgradeCoinValue = 0;
#endregion
#region LevelUp
upgradeconfirm = false;
holoarrowspr=0;
#endregion
#endregion
#region Screen
GW = display_get_gui_width();
GH = display_get_gui_height();
if (os_type == os_android and !global.guiSet) {
    gui_set();
}
#endregion
#region Menu
justopened = 0;
lastmenu = PMenus.Pause;
editOption = false;
mousein = false;
enum MenuOptionsEnum {
	//Map,
	Singleplayer,
	Multiplayer,
	Achieves,
	Shop,
	//Leaderboard,
	//Settings,
	//Credits,
	Quit
}
//menuOptions = ["Singleplayer", "Multiplayer", "Armory", "Achievements", "Shop", "Quit"];
menuOptions = [lexicon_text("MainMenu.Singleplayer"), lexicon_text("MainMenu.Multiplayer"), lexicon_text("MainMenu.Achievements"), lexicon_text("MainMenu.Shop"), lexicon_text("MainMenu.Quit")];
#endregion
#region Unused
//guiOffset = 0;
//HP = 1;
//androidoffset = 0;
//if (os_type == os_android) {
	//androidoffset = 4;
	//display_set_gui_size(display_get_width()/1.5, display_get_height()/1.5);
	//window_set_size(display_get_width(),display_get_height());
	//show_message_async(string(1366) + ":" + string(display_get_width()/1.5) + "=" + string(1366 - (display_get_width()/1.5)))
	//guiOffset = round((display_get_width()/1.5) - 1366) / 6.50;
	//guiOffset = 48;
	//show_message_async(string(guiOffset));
	//display_set_gui_size(2340/1.5, 1080/1.5);
//}
//lastinputs = array_create(10);
//if (os_type == os_android) {
//    //display_set_gui_size(1280,720);
//	if (!instance_exists(oJoystick)) {
//	    instance_create_depth(0,0,0,oJoystick);
//	}	
//}
//global.upgrades=ds_map_create();
//image_speed=5;
//sprindex=0;
//if (instance_number(oTitleRunning) < 15 and room == rInicio) {
//    instance_create_layer(0,0, "Instances", oTitleRunning);
//}
#endregion
#region Android Specific
startX = GW - 150;
startY = 0 + 10;
zButton = [startX,								startY, startX + 120,			 startY + 45, "Z"];
xButton = [startX - 140,					startY, startX - 140 + 120, startY + 45, "X"];
pButton = [startX - 280,					startY, startX - 280 + 120, startY + 45, "P"];
plusButton = [startX - 420,			startY, startX - 420 + 120, startY + 45, ">"];
minusButton = [startX - 560,		startY, startX - 560 + 120, startY + 45, "<"];
houseButton = [startX - 700,		startY, startX - 700 + 120, startY + 45, "H"];
holdPositions = [[0, 0, 0, 0], [0, 0, 0, 0]]
if (os_type == os_android) {
	zB = input_virtual_create();
	zB.rectangle(zButton[0], zButton[1], zButton[2], zButton[3]);
	zB.button("accept");

	xB = input_virtual_create();
	xB.rectangle(xButton[0], xButton[1], xButton[2], xButton[3]);
	xB.button("cancel");

	pB = input_virtual_create();
	pB.rectangle(pButton[0], pButton[1], pButton[2], pButton[3]);
	pB.button("pause");

	hB = input_virtual_create();
	hB.rectangle(houseButton[0], houseButton[1], houseButton[2], houseButton[3]);
	hB.button("house");
}
//feather disable once GM2017
function android_gui_button(pos){
	draw_set_alpha(0.5);
	draw_set_color(c_white);
	draw_rectangle(pos[0], pos[1], pos[2], pos[3], false);
	draw_set_alpha(1);
	draw_set_color(c_black);
	draw_rectangle(pos[0], pos[1], pos[2], pos[3], true);
	draw_text(pos[0] + 70, pos[1] + 22.5, pos[4]);
	draw_set_color(c_white);
}
#endregion
#region Debug
debuglog = false;
global.a=1;
a=2;
b=2;
c=2;
d=2;
e=1;
f=1;
g=1;
h=1;
minute = 0;
second = 0;
#endregion
#region PauseMenu	
activeMenu = PMenus.Pause;
enum PM{	
	Title,
	XScale,
	YScale,
	Options,
	Bool,
	BoolValue,
	Lenght
}
enum PMenus{
	Pause,
	Settings,
	Graphics,
	Lenght
}
for (var i = 0; i < PMenus.Lenght; ++i) {
	pauseMenu[i] = array_create(PMenus.Lenght, 0);
	//show_message(string(pauseMenu));
	for (var j = 0; j < PM.Lenght; ++j) {
		pauseMenu[i][j] = 0;
	}
}
	
pauseMenu[PMenus.Pause][PM.Title] = "PAUSED";
pauseMenu[PMenus.Pause][PM.XScale] = 2;
pauseMenu[PMenus.Pause][PM.Options] = ["Skills", "????", "Resume", "Settings", "Quit"];
//pauseMenu[PMenus.Pause][PM.Options] = ["Skills"];
pauseMenu[PMenus.Pause][PM.YScale] = 0.75;
#region Settings
	pauseMenu[PMenus.Settings][PM.Title] = "SETTINGS";
	pauseMenu[PMenus.Settings][PM.XScale] = 2.5;
	
	function loadSettingValues(){
		pauseMenu[PMenus.Settings][PM.Options][0] = "Music Volume: " + string(round(global.musicVolume*100)) + "%";
		pauseMenu[PMenus.Settings][PM.Options][1] = "Sound Volume: " + string(round(global.soundVolume*100)) + "%";
		pauseMenu[PMenus.Settings][PM.Bool][2] = true;
		pauseMenu[PMenus.Settings][PM.BoolValue][2] = global.damageNumbers;
		pauseMenu[PMenus.Settings][PM.Options][2] = "damage Numbers: ";
		pauseMenu[PMenus.Settings][PM.Bool][3] = true;
		pauseMenu[PMenus.Settings][PM.BoolValue][3] = global.screenShake;
		pauseMenu[PMenus.Settings][PM.Options][3] = "screen Shake: ";
		pauseMenu[PMenus.Settings][PM.Bool][4] = true;
		pauseMenu[PMenus.Settings][PM.BoolValue][4] = global.spawnEnemies;
		pauseMenu[PMenus.Settings][PM.Options][4] = "spawnEnemies: ";
		pauseMenu[PMenus.Settings][PM.Options][5] = "gamePad: ";
		pauseMenu[PMenus.Settings][PM.Bool][5] = true;
		pauseMenu[PMenus.Settings][PM.BoolValue][5] = global.gamePad;
		pauseMenu[PMenus.Settings][PM.Options][6] = "showhpui: ";
		pauseMenu[PMenus.Settings][PM.Bool][6] = true;
		pauseMenu[PMenus.Settings][PM.BoolValue][6] = global.showhpui;
		//pauseMenu[PMenus.Settings][PM.Options][1] = "guiScale: " + string(round(global.guiScale*100)) + "%";
	}
	loadSettingValues();
	//pauseMenu[PMenus.Pause][PM.Options] = ["Skills"];
	pauseMenu[PMenus.Settings][PM.YScale] = 0.75;
	#endregion
startOption = 0;
	totaloptions = array_length(pauseMenu[activeMenu][PM.Options]);
#endregion
#region Stages
	stageSelected = false;
	stageModes = [
	{
		name : "STAGE MODE", 
		//desc : "Defeat the last boss to \ncomplete the stage!"
		desc : "Defeat the last boss to complete the stage!"
	},
	{
		name : "ENDLESS MODE", 
		//desc : "Survive for as long as \nyou can and reach the top \nof the leaderboards!"
		desc : "Survive for as long as you can and reach the top of the leaderboards!"
	},
	{
		name : "TIME MODE",
		desc : "Defeat 5000 targets as soon as possible! Shop upgrades are standardized"
		//desc : "Defeat 5000 targets as \nsoon as possible! \nShop upgrades are standardized"
	}];
	stages = [{name: "Stage 1", port : sStage1Port, roomname : rStage1}];
	selectedStage = 0;
#endregion
#region Functions
//feather disable once GM2017
#region Multiplayer
//feather disable once GM2017
function share_item(i){
	if (global.shareItems) {
		sendMessage({
			command : Network.AddItem,
			type : "item",
			id : playerItems[i][$ "id"],
			level : playerItems[i][$ "level"],
			pos : i
		});
	}
}
//feather disable once GM2017
function share_weapon(i){
	if (global.shareWeapons) {
		sendMessage({
			command : Network.AddItem,
			type : "weapon",
			id : UPGRADES[i].id,
			level : UPGRADES[i][$ "level"],
			pos : i
		});
	}
}
#endregion
function buttonClick(pos, ignoreSystem = false){
	if (os_type != os_android and !ignoreSystem) { exit; }
	var result = false;
	if (point_in_rectangle(oGui.x, oGui.y, pos[0], pos[1], pos[2], pos[3])){
		result = true;
		oGui.x = 0;
		oGui.y = 0;
	}
	return result;
}
function drawStats(){
	#region Stats
	var str;
	draw_set_halign(fa_center);
	if (global.upgrade) {
		draw_text_transformed(GW/5, GH/3.40, "LevelUP", 3, 3, 0);
	}
	draw_text_transformed(GW/5, GH/2.70, NAME, 2, 2, 0);
	var stats_offset=0;
	#region HP
	draw_sprite_stretched(sHeartShaded, 0, GW/11, GH/2.15, 25, 25);
	draw_set_halign(fa_left);
	draw_text_transformed(GW/8 - 15, GH/2.15, "HP", 1.5, 1.5, 0);
	draw_line(GW/8.80, GH/2, GW/3.40, GH/2);
	str = string(HP) + "/" + string(MAXHP);
	draw_set_halign(fa_right);
	draw_text_transformed(GW/3.40, GH/2.15, str, 1.5, 1.5, 0);
	draw_set_halign(fa_left);
	#endregion
	
	#region ATK
	stats_offset += 35;
	draw_sprite_stretched(sSwordBlue, 0, GW/11, GH/2.15 + stats_offset, 25, 25);
	draw_text_transformed(GW/8 - 15, GH/2.15 + stats_offset, "ATK", 1.5, 1.5, 0);
	draw_line(GW/8.80, GH/2 + stats_offset, GW/3.40, GH/2 + stats_offset);
	var calc = 0;
	calc += real(string_replace(string(global.player[?"atk"]), "1.", ""));
	for (var i = 0; i < array_length(Bonuses[BonusType.Damage]); ++i) {
		if (Bonuses[BonusType.Damage][i] != 0) {
			calc += real(string_replace(string(Bonuses[BonusType.Damage][i]), "1.", ""));
		}
	}
	for (var i = 0; i < array_length(PerkBonuses[BonusType.Damage]); ++i) {
		if (PerkBonuses[BonusType.Damage][i] != 0) {
			calc += real(string_replace(string(PerkBonuses[BonusType.Damage][i]), "1.", ""));
		}
	}
	str = ((calc > 0) ? "+" : "") + string_replace(string(calc), ".00", "") + "%";
	draw_set_halign(fa_right);
	draw_text_transformed(GW/3.40, GH/2.15 + stats_offset, str, 1.5, 1.5, 0);
	draw_set_halign(fa_left);
	#endregion
				
	#region SPD
	stats_offset += 35;
	draw_sprite_stretched(sHudSpdIcon, 0, GW/11, GH/2.15 + stats_offset, 25, 25);
	draw_text_transformed(GW/8 - 15, GH/2.15 + stats_offset, "SPD", 1.5, 1.5, 0);
	draw_line(GW/8.80, GH/2 + stats_offset, GW/3.40, GH/2 + stats_offset);
	calc = 0;
	calc += real(string_replace(string(global.player[?"speed"]), "1.", ""));
	for (var i = 0; i < array_length(Bonuses[BonusType.Speed]); ++i) {
		if (Bonuses[BonusType.Speed][i] != 0) {
			calc += real(string_replace(string(Bonuses[BonusType.Speed][i]), "1.", ""));
		}
	}
	for (var i = 0; i < array_length(PerkBonuses[BonusType.Speed]); ++i) {
		if (PerkBonuses[BonusType.Speed][i] != 0) {
			calc += real(string_replace(string(PerkBonuses[BonusType.Speed][i]), "1.", ""));							
		}
	}
	str = ((calc > 0) ? "+" : "") + string_replace(string(calc), ".00", "") + "%";
	draw_set_halign(fa_right);
	draw_text_transformed(GW/3.40, GH/2.15 + stats_offset, str, 1.5, 1.5, 0);
	draw_set_halign(fa_left);
	#endregion
				
	#region CRT
	stats_offset += 35;
	draw_sprite_stretched(sHudCrtIcon, 0, GW/11, GH/2.15 + stats_offset, 25, 25);
	draw_text_transformed(GW/8 - 15, GH/2.15 + stats_offset, "CRT", 1.5, 1.5, 0);
	draw_line(GW/8.80, GH/2 + stats_offset, GW/3.40, GH/2 + stats_offset);
	calc = oPlayer.critChance;
	str = ((calc > 0) ? "+" : "") + string_replace(string(calc), ".00", "") + "%";
	draw_set_halign(fa_right);
	draw_text_transformed(GW/3.40, GH/2.15 + stats_offset, str, 1.5, 1.5, 0);
	draw_set_halign(fa_left);
	#endregion
				
	#region Pickup
	stats_offset += 35;
	draw_sprite_stretched(sHudPickupIcon, 0, GW/11, GH/2.15 + stats_offset, 25, 25);
	draw_text_transformed(GW/8 - 15, GH/2.15 + stats_offset, "Pickup", 1.5, 1.5, 0);
	draw_line(GW/8.80, GH/2 + stats_offset, GW/3.40, GH/2 + stats_offset);
	calc = 0;
				
	for (var i = 0; i < array_length(Bonuses[BonusType.PickupRange]); ++i) {
		if (Bonuses[BonusType.PickupRange][i] != 0) {
			calc += real(string_replace(string(Bonuses[BonusType.PickupRange][i]), "1.", ""));
		}
	}
	for (var i = 0; i < array_length(PerkBonuses[BonusType.PickupRange]); ++i) {
		if (PerkBonuses[BonusType.PickupRange][i] != 0) {
		    calc += real(string_replace(string(PerkBonuses[BonusType.PickupRange][i]), "1.", ""));
		}
	}
	str = ((calc > 0) ? "+" : "") + string_replace(string(calc), ".00", "") + "%";
	draw_set_halign(fa_right);
	draw_text_transformed(GW/3.40, GH/2.15 + stats_offset, str, 1.5, 1.5, 0);
	draw_set_halign(fa_left);
	#endregion

	#region Haste
	stats_offset += 35;
	draw_sprite_stretched(sHudCooldownIcon, 0, GW/11, GH/2.15 + stats_offset, 25, 25);
	draw_text_transformed(GW/8 - 15, GH/2.15 + stats_offset, "Haste", 1.5, 1.5, 0);
	draw_line(GW/8.80, GH/2 + stats_offset, GW/3.40, GH/2 + stats_offset);
	calc = oPlayer.weaponHaste;
	for (var i = 0; i < array_length(Bonuses[BonusType.Haste]); ++i) {
		if (Bonuses[BonusType.Haste][i] != 0) {
			calc += real(string_replace(string(Bonuses[BonusType.Haste][i]), "1.", ""));
		}
	}
	for (var i = 0; i < array_length(PerkBonuses[BonusType.Haste]); ++i) {
		if (PerkBonuses[BonusType.Haste][i] != 0) {
		    calc += real(string_replace(string(PerkBonuses[BonusType.Haste][i]), "1.", ""));
		}
	}
	calc = string_replace(string(calc), "1.0", "");
	calc = string_replace(string(calc), "1.", "");
	str = ((calc > 0) ? "+" : "") + string(calc) + "%";
	draw_set_halign(fa_right);
	draw_text_transformed(GW/3.40, GH/2.15 + stats_offset, str, 1.5, 1.5, 0);
	draw_set_halign(fa_center);
	#endregion
	draw_set_halign(fa_left);
	#endregion
}
function drawStatsSelect(character){
	var stats_offset = 0;	
	var _x = GW/17.54;
	var _y = GH/1.54;
	var str;
	draw_set_color(c_white);
	var stats = [
		{
			spr : sHeartShaded,
			name : "HP",
			stat : character[?"hp"],
			suffix : ""
		},
		{
			spr : sSwordBlue,
			name : "ATK",
			stat : character[?"atk"],
			suffix : "x"
		},
		{
			spr : sHudSpdIcon,
			name : "SPD",
			stat : character[?"speed"],
			suffix : "x"
		},
		{
			spr : sHudCrtIcon,
			name : "CRT",
			stat : string_replace(character[?"crit"], "1.", ""),
			suffix : "%"
		},
		];		
		for (var i = 0; i < array_length(stats); ++i) {
			draw_sprite_ext(stats[i][$ "spr"], 0, _x, _y + stats_offset, 1.90, 1.90, 0, c_white, 1);
			draw_text_transformed(_x + 25, _y - 17 + stats_offset, stats[i][$ "name"], 2, 2, 0);
			draw_rectangle(_x + 27, _y + 12 + stats_offset, _x + 268, _y + 9 + stats_offset, false);
			draw_set_halign(fa_left);
			str = string(stats[i][$ "stat"]) + stats[i][$ "suffix"];
			draw_set_halign(fa_right);
			draw_text_transformed(_x + 265, _y - 17 + stats_offset, str, 2, 2, 0);
			draw_set_halign(fa_left);
			stats_offset += 40;
		}
}
#endregion
#region upgrades surface
itemsSurface = surface_create(window_get_width(), window_get_height());
function upgradesSurface(){
	if (surface_exists(itemsSurface)) {
	    surface_free(itemsSurface);
	}
	itemsSurface = surface_create(window_get_width(), window_get_height());
	surface_set_target(itemsSurface);
	var _x = GW/25.10
	var _y = GH/10.59;
	draw_sprite_ext(sItemsArea, 0, _x + 51, _y - 20, 16.45, 6.65, 0, c_white, 1);
	#region Weapons	
	var header = sBlank;
	var digit = sBlank;
	var offset=0;
	var yoffset = 0;
	var _itemsx;
	var _itemsy;
	if (global.showhpui) {
		_itemsx = _x + 76;
		_itemsy = _y + 4;
	}
	else{
		_itemsx = GW/12;
		_itemsy = GH/13;
	}
	for (var i = 0; i < array_length(UPGRADES); i++){ //for the size of the upgrade arrays
		draw_sprite_ext(sUiEmptySlotWeapon,0,_itemsx+offset,_itemsy,1.5,1.5,0,c_white,.5); //draw empty slots background
		if (UPGRADES[i]!=global.null){ //if there is a upgrade in the slot		
			var awakened = (UPGRADES[i][$ "level"] < UPGRADES[i][$ "maxlevel"]) ? 0 : 1; //check if weapon is awakened
			draw_sprite_ext(UPGRADES[i][$ "thumb"],awakened,_itemsx+offset,_itemsy,2,2,0,c_white,1); //draw weapon sprite
			DEBUG draw_text(_itemsx+offset, _itemsy-15,string(global.upgradeCooldown[UPGRADES[i].id])); ENDDEBUG
			switch (UPGRADES[i][$ "type"]){ //detect the type of upgrade
				case "red":{
					header = sUiLevelHeaderPink;
					digit = sUiDigitPink;
					break;}
				case "yellow":{
					header = sUiLevelHeaderYellow;
					digit = sUiDigitYellow;
					break;}
				case "white":{
					header = sUiLevelHeaderWhite;
					digit = sUiDigitWhite;
					break;}
			}
			draw_sprite_ext(header,0,_itemsx+offset,_itemsy,2,2,0,c_white,1); //draw type sprite
			draw_sprite_ext(digit,UPGRADES[i][$ "level"],_itemsx+5+offset,_itemsy,2,2,0,c_white,1); //draw level
		}		
		offset+=50;
	}
	#region Items
	offset=0;			
	yoffset = 60;
	for (var i = 0; i < array_length(playerItems); i++){ //for the size of the upgrade arrays
		draw_sprite_ext(sUiEmptySlotItem,0,_itemsx+offset,_itemsy+yoffset,1.5,1.5,0,c_white,.5); //draw empty slots background
		if (playerItems[i]!=global.nullitem) //if there is a upgrade in the slot
		{
			var awakened = (playerItems[i][$ "level"] < 7) ? 0 : 1; //check if weapon is awakened
			draw_sprite_ext(playerItems[i][$ "thumb"],awakened,_itemsx+offset,_itemsy+yoffset,2,2,0,c_white,1); //draw weapon sprite
			DEBUG draw_text(_itemsx+offset, _itemsy-15+yoffset,string(global.itemCooldown[playerItems[i][$ "id"]])); ENDDEBUG
			switch (playerItems[i][$ "type"]) //detect the type of upgrade
			{
				case "red":{
					header = sUiLevelHeaderPink;
					digit = sUiDigitPink;
					break;}
				case "yellow":{
					header = sUiLevelHeaderYellow;
					digit = sUiDigitYellow;
					break;}
				case "white":{
					header = sUiLevelHeaderWhite;
					digit = sUiDigitWhite;
					break;}
			}
			draw_sprite_ext(header,0,_itemsx+offset,_itemsy+yoffset,2,2,0,c_white,1); //draw type sprite
			draw_sprite_ext(digit,playerItems[i][$ "level"],_itemsx+5+offset,_itemsy+yoffset,2,2,0,c_white,1); //draw level
		}		
		offset+=50;
	}
	#endregion
	
	#region Perks
	offset=150;
	yoffset = 120;
	for (var i = 0; i < array_length(PLAYER_PERKS); i++){ //for the size of the upgrade arrays
		draw_sprite_ext(sUiEmptySlotItem,0,_itemsx+offset,_itemsy+yoffset,1.5,1.5,0,c_white,.5); //draw empty slots background
		if (PLAYER_PERKS[i]!=global.nullperk){ //if there is a upgrade in the slot
			var activated = PLAYER_PERKS[i][$ "level"] > 0  ? 1 : .5;
			draw_sprite_ext(PLAYER_PERKS[i][$ "thumb"],0,_itemsx+offset,_itemsy+yoffset,2,2,0,c_white, activated); //draw weapon sprite
			DEBUG draw_text(_itemsx+offset, _itemsy-15+yoffset,string(global.perkCooldown[PLAYER_PERKS[i][$ "id"]])); ENDDEBUG
			draw_sprite_ext(sUiLevelHeaderPink,0,_itemsx+offset,_itemsy+yoffset,2,2,0,c_white,1); //draw type sprite
			draw_sprite_ext(sUiDigitPink,PLAYER_PERKS[i][$ "level"],_itemsx+5+offset,_itemsy+yoffset,2,2,0,c_white,1); //draw level					        
		}		
		offset+=50;
	}
	#endregion
	surface_reset_target();
}
#endregion
#endregion
#region upgrades surface
boxcoins = 0;
temp = 0;
upspeed = 15;
itemdistance = 80;
itemsize = 2.50;
coinsAmount = -2;
resultY = -30;
resultSize = 3;
chestsize = 1.5;
chesttimer = 0;
chestmaxtimer = 4;
chestresult = false;
chestspr = 0;
boxoffset = 700;
boxaccept = false;
boxsurface = surface_create(128, 512);
chestAcceptRefuseX = 115;
multiChest = false;
multiChestX = 165;
rolledPrizes = [];
currentPrize = 0;
chestblacklist = [];
testvar = 0;
testvar2 = 0;
function nextPrize(){
	currentPrize++;
	switch (currentPrize) {
		case 1:
			part_system_position(shineSystem, GW/2, GH/2 + resultY);
			break;
		case 2:
			part_system_position(shineSystem, GW/2 + multiChestX, GH/2 + resultY);
			break;
		case 3:
			PrizeBox = false;
			pause_game();
			break;
	}
}
function acceptPrize(info){
	switch (info[0]) {
		case Rewards.Weapon:
			for (var i = 0; i < array_length(UPGRADES); ++i) {
				if (UPGRADES[i][$ "id"] == info[1]) {
					UPGRADES[i] = WEAPONS_LIST[UPGRADES[i][$ "id"]][UPGRADES[i][$ "level"] + 1];
					break;
				}
				if (UPGRADES[i] == global.null) {
					UPGRADES[i] = WEAPONS_LIST[info[1]][1];
					break;
				}
			}
			break;
		case Rewards.Item:
			for (var i = 0; i < array_length(playerItems); ++i) {
				if (playerItems[i][$ "id"] == info[1]) {
					playerItems[i] = ItemList[playerItems[i][$ "id"]][playerItems[i][$ "level"] + 1];
					break;
				}
				if (playerItems[i] == global.nullitem) {
					playerItems[i] = ItemList[info[1]][1];
					break;
				}
			}
			break;
	}
	upgradesSurface();
}
function boxitems(offset){
	if (surface_exists(boxsurface)) { surface_free(boxsurface); }
	boxsurface = surface_create(128, 512);
	surface_set_target(boxsurface);
	var _yoffset = 0;
	for (var i = 0; i < array_length(ItemList); ++i) {
	    draw_sprite_ext(ItemList[i][1][$ "thumb"], 0, 64, 0 - _yoffset + offset, itemsize, itemsize, 0, c_white, 1);
		_yoffset -= itemdistance;
	}
	for (var i = 0; i < array_length(WEAPONS_LIST); ++i) {
	    draw_sprite_ext(WEAPONS_LIST[i][1][$ "thumb"], 0, 64, 0 - _yoffset + offset, itemsize, itemsize, 0, c_white, 1);
		_yoffset -= itemdistance;
	}
	surface_reset_target();
}
//ParticleSystem7
//feather disable GM2017
coinsSystem = part_system_create();
part_system_draw_order(coinsSystem, true);

//Emitter
_ctype1 = part_type_create();
part_type_sprite(_ctype1, sPhaseCoin, true, true, false)
part_type_size(_ctype1, 1, 1, 0, 0);
part_type_scale(_ctype1, 1.5, 1.5);
part_type_speed(_ctype1, 20, 25, 0, 0);
part_type_direction(_ctype1, 80, 100, 0, 0);
part_type_gravity(_ctype1, 0.75, 270);
part_type_orientation(_ctype1, 0, 0, 0, 0, false);
part_type_colour3(_ctype1, $FFFFFF, $FFFFFF, $FFFFFF);
part_type_alpha3(_ctype1, 1, 1, 1);
part_type_blend(_ctype1, false);
part_type_life(_ctype1, 100, 100);

part_system_position(coinsSystem, GW/2, GH/2 + 200);
part_system_automatic_draw(coinsSystem, false);

//ParticleSystem8
shineSystem = part_system_create();
part_system_draw_order(shineSystem, true);

//Emitter
var _ptype1 = part_type_create();
part_type_shape(_ptype1, pt_shape_spark);
part_type_size(_ptype1, 1, 1, 0, 0);
part_type_scale(_ptype1, 1, 1);
part_type_speed(_ptype1, 0.1, 0.1, 0, 0);
part_type_direction(_ptype1, 0, 360, 0, 0);
part_type_gravity(_ptype1, 0, 270);
part_type_orientation(_ptype1, 0, 0, 0, 0, false);
part_type_colour3(_ptype1, $FFFFFF, $FFFFFF, $FFFFFF);
part_type_alpha3(_ptype1, 1, 1, 1);
part_type_blend(_ptype1, false);
part_type_life(_ptype1, 10, 20);

var _pemit1 = part_emitter_create(shineSystem);
part_emitter_region(shineSystem, _pemit1, -32, 32, -32, 32, ps_shape_rectangle, ps_distr_linear);
part_emitter_stream(shineSystem, _pemit1, _ptype1, -1);

//Emitter1
var _ptype2 = part_type_create();
part_type_shape(_ptype2, pt_shape_flare);
part_type_size(_ptype2, 1, 1, 0, 0);
part_type_scale(_ptype2, 1, 1);
part_type_speed(_ptype2, 0, 0, 0, 0);
part_type_direction(_ptype2, 0, 0, 0, 0);
part_type_gravity(_ptype2, 0, 0);
part_type_orientation(_ptype2, 0, 0, 0, 0, false);
part_type_colour3(_ptype2, $FFFFFF, $FFFFFF, $FFFFFF);
part_type_alpha3(_ptype2, 1, 1, 1);
part_type_blend(_ptype2, false);
part_type_life(_ptype2, 20, 20);

var _pemit2 = part_emitter_create(shineSystem);
part_emitter_region(shineSystem, _pemit2, -32, 32, -32, 32, ps_shape_rectangle, ps_distr_linear);
part_emitter_stream(shineSystem, _pemit2, _ptype2, -3);

part_system_position(shineSystem, GW/2, GH/2 + resultY);
part_system_automatic_draw(shineSystem, false);

#endregion
//feather enable GM2017
global.initialConfigDone = false;