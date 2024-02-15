#region Start
randomize();
#region ShopUpgrades
if (!variable_global_exists("ShopUpgrades")) {
    global.shopUpgrades = {
		Hp : {
			name:"Max HP Up",
			desc : "Increase Max HP by 4% per level. (Max 40%) ",
			sprite : sHudHPIcon,
			level : 0,
			maxlevel : 10,
			tab : GlobalShopTabs.Stats,
			costs : [200, 500, 1200, 2750, 6000, 12000, 18000, 24000, 30000, 36000]
		},
		Atk : {
			name:"ATK Up",
			desc : "Increase all damage by 6% per level. (Max 60%) ",
			sprite : sHudAtkIcon,
			level : 0,
			maxlevel : 10,
			tab : GlobalShopTabs.Stats,
			costs : [300, 750, 1800, 4100, 9100, 18000, 25000, 31000, 37000, 43000 ]
		},
		Spd : {
			name:"SPD Up",
			desc : "Increase movement speed by 6% per level. (Max 60%) ",
			sprite : sHudSpdIcon,
			level : 0,
			maxlevel : 10,
			tab : GlobalShopTabs.Stats,
			costs : [200, 500, 1200, 2750, 6000, 12000, 18000, 24000, 30000, 36000]
		},
		Crit : {
			name:"Crit Up",
			desc : "Increase critical hit chance by 2% per level. (max 10%) ",
			sprite : sHudCrtIcon,
			level : 0,
			maxlevel : 5,
			tab : GlobalShopTabs.Stats,
			costs : [300, 750, 1800, 4100, 9100 ]
		},
		PickUp : {
			name:"Pick Up Range",
			desc : "Increase base pick up range by 10% per level. (Max 100%) ",
			sprite : sHudPickupIcon,
			level : 0,
			maxlevel : 10,
			tab : GlobalShopTabs.Stats,
			costs : [200, 500, 1200, 2750, 6000, 12000, 18000, 24000, 30000, 36000 ]
		},
		Haste : {
			name:"Haste Up",
			desc : "Increase attack speed by 4% per level. (Max 20%) ",
			sprite : sHudCooldownIcon,
			level : 0,
			maxlevel : 5,
			tab : GlobalShopTabs.Stats,
			costs : [400, 1000, 2400, 5500, 12000 ]
		},
		Regeneration : {
			name:"Regeneration",
			desc : "Slowly heals 1 HP every 5 seconds. +1 HP per level. (Max 5 HP/ 5 seconds) ",
			sprite : sHudRegenerationIcon,
			level : 0,
			maxlevel : 5,
			tab : GlobalShopTabs.Stats,
			costs : [200, 500, 1200, 2750, 6000]
		},
		SpecialAtk : {
			name:"Special Attack",
			desc : "Unlocks the Special Attack for all characters. Press the secondary button (default: X) to use. ",
			sprite : sHudSpecialUnlockIcon,
			level : 0,
			maxlevel : 1,
			tab : GlobalShopTabs.Enhancements,
			costs : [500]
		},
		SpecialCooldown : {
			name:"Special Cooldown Reduction",
			desc : "Reduces the cooldown time of special attack by 3% per level. (Max 15%) ",
			sprite : sHudSpecialCooldownIcon,
			level : 0,
			maxlevel : 5,
			tab : GlobalShopTabs.Stats,
			costs : [500, 1250, 3000, 6900, 15000 ]
		},
		Growth : {
			name:"Growth",
			desc : "Increase the damage of Character Main Weapons and Special Attacks by 2% per in-game level. ",
			sprite : sHudGrowthIcon,
			level : 0,
			maxlevel : 1,
			tab : GlobalShopTabs.Enhancements,
			costs : [1000]
		},
		ExpGain : {
			name:"EXP Gain Up",
			desc : "Increases the amount of EXP gained by 4% per level. (max 20%) ",
			sprite : sXP,
			level : 0,
			maxlevel : 5,
			tab : GlobalShopTabs.Stats,
			costs : [300, 750, 1800, 4100, 9100 ]
		},
		FoodDrop : {
			name:"Food Drops Up",
			desc : "Increases the rate that food is dropped by 4% per level. (max 20%) ",
			sprite : sHamburger,
			level : 0,
			maxlevel : 5,
			tab : GlobalShopTabs.Stats,
			costs : [150, 375, 900, 2000, 4500 ]
		},
		MoneyGain : {
			name:"Money Gain Up",
			desc : "Increases the amount of HoloCoins gained by 20% per level. (Max 200%) ",
			sprite : sPhaseCoin,
			level : 0,
			maxlevel : 10,
			tab : GlobalShopTabs.Stats,
			costs : [400, 1000, 2400, 5500, 12000, 20000, 30000, 40000, 50000, 60000 ]
		},
		Reroll : {
			name:"Reroll",
			desc : "Grants a use of Reroll when leveling up. ",
			sprite : sHudRerollIcon,
			level : 0,
			maxlevel : 5,
			tab : GlobalShopTabs.Enhancements,
			costs : [2500, 5000, 7500, 10000, 12500 ]
		},
		Enchantment : {
			name : "Enchantments",
			sprite : sHudHPIcon,
			level : 0,
			maxlevel : 1,
			tab : GlobalShopTabs.Enhancements,
			costs : [1000]
		},
		EnhacementRate : {//TODO: yeah....
			name:"Enhancement Rate Up",
			desc : "Increases the chance of success during enhancements by 3% per level. (Max 15%) ",
			sprite : sHudHPIcon,
			level : 0,
			maxlevel : 5,
			tab : GlobalShopTabs.Stats,
			costs : [300, 750, 1800, 4100, 9100 ]
		},
		Defense : {
			name:"Defense Up",
			desc : "Increases defense, reducing damage taken by 3% per level. (Max 15%) ",
			sprite : sHudDefenseIcon,
			level : 0,
			maxlevel : 5,
			tab : GlobalShopTabs.Stats,
			costs : [500, 1250, 3000, 6900, 15000 ]
		},
		GRankOff : {//TODO: maybe implement G-ranks before...
			name:"G Rank Off",
			desc : "Turn off bonuses gained from G Ranks on all characters. ",
			sprite : sHudHPIcon,
			level : 0,
			maxlevel : 1,
			tab : GlobalShopTabs.Others,
			costs : [0]
		},
		Hardcore : {//TODO: score system and bonus score
			name:"Hardcore",
			desc : "Ultimate challenge! HP is set to 1. Gain massive bonus score the longer you survive in Endless Mode. ",
			sprite : sHudHPIcon,
			level : 0,
			maxlevel : 1,
			tab : GlobalShopTabs.Others,
			costs : [0]
		},
	}
}
global.shopUpgradesJSON = json_stringify(global.shopUpgrades);
#endregion
global.holocoins = 0;
Load_Data_Structs();
global.holocoins ??= 0;
#region Font
//global.newFont = font_add("pixelade.ttf", 10, false, false, 32, 128);
//global.newFont = font_add("Silver.ttf", 32, false, false, 32, 128);
var fstr = "!\"#$%&\'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^~`abcdefghijklmnopqrstuvwxyz{|}~";
//if (os_type != os_android) {
    //global.newFont[1] = font_add_sprite_ext(sPixelFont, fstr, true, 1);
	//global.newFont[2] = font_add_sprite_ext(sPixelFont, fstr, true, 2);
    global.newFont[1] = font_add("Silver.ttf", 13, false, false, 32, 128);
	global.newFont[2] = font_add("Silver.ttf", 13, false, false, 32, 128);
//}
//else {
//	global.newFont[1] = font_add("Silver.ttf", 16, false, false, 32, 128);
//	global.newFont[2] = font_add("Silver.ttf", 32, false, false, 32, 128);
//}

draw_set_font(global.newFont[1]);
#endregion
#region Populate Items
populate_items();
populate_upgrades();
populate_collabs();
populate_characters();
populate_perks();
populate_specials();
populate_outfits();
unlocked_outfits_load();
try{
	load_unlocked();
}
catch (err){
	//ignore
}
#endregion
#endregion
HP = 0;
global.currentFrame = 0;
#region fps mean
numSeconds = 3;
stepsPassed = 0;
fpsAverage = 0;
movingSum = 0;
fpsArraySize = 60 * numSeconds;
fpsArray[fpsArraySize-1] = 0;
for(var i=0;i<fpsArraySize;i++){
    fpsArray[i] = 0;
}
#endregion
//show_debug_overlay(true);
if (os_type != os_android) {
    window_set_size(1280, 720);
}
#region Delta Time initialization
targetDelta = 1 / 60;
actualDelta = 0;
#endregion
#region Locals Initialization
canspawn=true;
#region lines
linespos = -100;
alarm[1] = 1;
linesoff = 0;
#endregion
depth=99;
gamePausedImageSpeed =0;
#region Screen Shake
shakeFx = layer_get_fx("ShakeLayer");
shakeMagnitude = 0;
shakeSpeed = 1;
#endregion
#endregion
#region Globals initialization
global.mouseDown = false;
global.gamePad = false;
global.arrowDir = 0;
global.defeatedEnemies = 0;
global.spawnEnemies = 1;
global.musicPlaying = undefined;
global.debug=false;
global.gamePaused=false;
global.strafe = false;
global.minutesPast30 = 0;
global.hoursPast1= 0 ;
global.arrowDir=0;
#region Multiplayer Globals
global.shareXP = false;
global.shareItems = false;
global.shareWeapons = false;
global.pauseGame = false;
global.shareAnvils = false;
global.shareStamps = false;
global.shareBoxDrops = false;
global.allowHalu = false;
global.allowGrank = false;
global.scaleMobs = false;
global.socket = 0;
global.singleplayer = false;
global.roomname="";
#endregion
#endregion
#region Unused
//if (!variable_global_exists("mode")) {
//	global.mode = "menu";
//}
global.gPnum = 0;
#endregion
#region Stages
enum StageTypes{
	Stage,
	Endless
}
#endregion
#region SaveLoad
var variables = ["musicVolume","soundVolume","damageNumbers","screenShake", "gamePad"];
for (var i = 0; i < array_length(variables); ++i) {
	if (!variable_global_exists(variables[i])) {
		variable_global_set(variables[i], 1);
	}
	if (!variable_global_exists(variables[i]) and variable_global_get(variables[i]) == undefined) {
		variable_global_set(variables[i], 1);
	}
}
#endregion
reset_pool();
reset_timer();
//#region Lexicon Initialization
//lexicon_index_declare_from_json("english.json");
//lexicon_index_declare_from_json("ptbr.json");
//lexicon_language_set("English");
//#endregion
