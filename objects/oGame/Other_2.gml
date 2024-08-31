randomize();
global.IsHost = false;
global.characterdataJSON = undefined;
global.fishamount = undefined;
global.rodsowned = undefined;
global.cropamounts = undefined;
global.soilamounts = undefined;
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
		Hold : {
			name:"Hold",
			desc : "Let you hold a option until the next level up",
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
global.sand = 0;
global.equippedrod = 0;
global.musicVolume = 0.25;
Load_Data_Structs();
global.equippedrod ??= 0;
global.sand ??= 0;
global.holocoins ??= 0;
#region Font
//global.newFont = font_add("pixelade.ttf", 10, false, false, 32, 128);
//global.newFont = font_add("Silver.ttf", 32, false, false, 32, 128);
//var fstr = "!\"#$%&\'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^~`abcdefghijklmnopqrstuvwxyz{|}~";
var fstr = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ[]{}()<>=?*:!%0123456789./, \"|";
//if (os_type != os_android) {
global.fonts = [-1, -1];
global.newFont[1] = font_add_sprite_ext(sHFont, fstr, true, 1);
global.fonts[1] = font_add_sprite_ext(sDmgFont, "0123456789KO!", true, 1);
scribble_font_bake_outline_4dir("sDmgFont", "fDmg", c_black, true);
scribble_font_set_default("sHFont");
scribble_font_bake_outline_4dir("sHFont", "sHFontOutline", c_black, true);
//global.newFont[2] = font_add_sprite_ext(sPixelFont, fstr, true, 2);
//global.newFont[1] = font_add("Silver.ttf", 13, false, false, 32, 128);
global.newFont[2] = font_add("Silver.ttf", 13, false, false, 32, 128);
//}
//else {
//	global.newFont[1] = font_add("Silver.ttf", 16, false, false, 32, 128);
//	global.newFont[2] = font_add("Silver.ttf", 32, false, false, 32, 128);
//}

draw_set_font(global.newFont[1]);
#endregion
#region Populate Items
//if (is_string(global.characterdataJSON)) {
//	var arr = json_parse(global.characterdataJSON);
//	for (var i = 0; i < array_length(arr); ++i) {
//		var _names = struct_get_names(arr[i]);
//		for (var j = 0; j < array_length(_names); ++j) {
//			global.characterdata[i][$ _names[j]] = arr[i][$ _names[j]];
//		}
//	}
//}
if (is_string(global.fishamount)) {
	var arr = json_parse(global.fishamount);
	for (var i = 0; i < array_length(arr); ++i) {
		Fishes.data[i].amount = arr[i].amount;
	}
}
if (is_string(global.rodsowned)) {
	var arr = json_parse(global.rodsowned);
	for (var i = 0; i < array_length(arr); ++i) {
		Rods[i].owned = arr[i].owned;
	}
}
if (is_string(global.cropamounts)) {
	var arr = json_parse(global.cropamounts);
	for (var i = 0; i < array_length(arr); ++i) {
		global.crops[i].seedamount = arr[i].seedamount;
		global.crops[i].amount = arr[i].amount;
	}
}
if (is_string(global.soilamounts)) {
	var arr = json_parse(global.soilamounts);
	for (var i = 0; i < array_length(arr); ++i) {
		global.farmsoils[i].amount = arr[i].amount;
	}
}
for (var i = 0; i < array_length(global.farmplots); i += 1) {
	updatecropinfo(global.farmplots[i]);
}
#region lower arrays
//for (var i = 0; i < "NullChar"; ++i) {
//	global.characterdata[i][$ "stagefirstclear"][StageID.Length] = false;
//}
#endregion
populate_items();
populate_upgrades();
populate_collabs();
populate_characters();
populate_buffs()
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
ini_open("settings");
global.playerid = ini_read_real("Settings", "playerid", -1);
global.username = ini_read_string("Settings", "Username", "Player");
ini_close();
#endregion