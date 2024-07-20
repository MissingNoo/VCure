//Feather disable GM2064
if (keyboard_check_pressed(vk_f8)) {
    show_message("Game data cleared! Reload the game!");
	file_delete("settings");
	
	file_delete("sava_data.bin");
	Granks = array_create(Characters.Lenght, 0);
	UnlockableItems = array_create(ItemIds.Length, false);
	UnlockableWeapons = array_create(Weapons.Length, false);
	UnlockableAchievements = array_create(AchievementIds.Length, false);
	for (var i = 0; i < Characters.Lenght; ++i) {
	    global.characterdata[i] = {
			unlocked : false,
			outfits : [],
			grank : 0,
		};
	}
	global.holocoins = 0;
	Save_Data_Structs();
	global.initialConfigDone = false;
}

if (RELEASE) { 
    global.debug = false;
	//Feather disable once GM2017
	DebugManager.show = false;
}
if (keyboard_check_pressed(vk_f11)) {
    window_set_fullscreen(not window_get_fullscreen());
}
DEBUG
//if (keyboard_check_pressed(vk_home)) {
//    Minutes = 6;
//	Seconds = 55;
//}
ENDDEBUG
//if (global.debug and keyboard_check_pressed(vk_home)) {
//    var importedSave = {};
//	importedSave.unlockedWeapons = [];
//	importedSave.unlockedItems = [];
//	if (!file_exists(working_directory + "save_n.dat")) { exit; }
//	var file = file_text_open_read(working_directory + "save_n.dat");
//	importedSave = json_parse(base64_decode(file_text_readln(file)));
//	#region Items
//	var _unlockedItems = "Unlocked Holocure Items:";
//	for (var i = 0; i < array_length(importedSave.unlockedItems); ++i) {
//		for (var j = 0; j < array_length(ItemList); ++j) {
//			if (importedSave.unlockedItems[i] == string_replace_all(ItemList[j][1].name, " ", "") and variable_struct_exists(ItemList[j][1], "unlocked")) {
//				_unlockedItems += string($"{ItemList[j][1].name} \n");
//				UnlockableItems[ItemList[j][1].id] = true;
//				load_unlocked();
//			}
//		}
//	}
//	show_message(_unlockedItems);
//	#endregion
//}

//if (keyboard_check_pressed(vk_alt)) {
//    window_set_size(1280/1.5, 720/1.5);
//	window_center();
//}
#region Gamepad detection
if (input_profile_get(0) == "gamepad") {
    global.gamePad = true;
}
else{
	global.gamePad = false;
}
#endregion
#region Unused
//if (keyboard_check(vk_home)) {
//	for (var i = 0; i < array_length(UnlockableWeapons); ++i) {
//	    UnlockableWeapons[i] = true;
//	}
//	for (var i = 0; i < array_length(UnlockableItems); ++i) {
//	    UnlockableItems[i] = true;
//	}
//	for (var i = 0; i < array_length(Achievements); ++i) {
//	    Achievements[i][$"unlocked"] = true;
//	}
//	load_unlocked();
//	UnlockableOutfits[Outfits.AmeliaO1] = true;
//	UnlockableOutfits[Outfits.AmeliaO2] = true;
//	unlocked_outfits_load();
//}
//if (keyboard_check_pressed(vk_end)) {
	//Minutes = 19;
	//Seconds = 58;	
	//instance_create_depth(x,y,depth, oAchNotify);
	//for (var i = 0; i < array_length(UnlockableWeapons); ++i) {
	//    UnlockableWeapons[i] = false;
	//}
	//for (var i = 0; i < array_length(UnlockableItems); ++i) {
	//    UnlockableItems[i] = false;
	//}
	//for (var i = 0; i < array_length(Achievements); ++i) {
	//    Achievements[i][$"unlocked"] = false;
	//}
	//load_unlocked();
	//UnlockableOutfits[Outfits.AmeliaO1] = false;
	//UnlockableOutfits[Outfits.AmeliaO2] = false;
	//unlocked_outfits_load();
//}

//if (instance_exists(oPlayer)) {
    
//}
//if (keyboard_check_pressed(RIGHTKEY) or keyboard_check_pressed(LEFTKEY) or keyboard_check_pressed(UPKEY)  or keyboard_check_pressed(DOWNKEY) or device_mouse_check_button_pressed(0,mb_left)) {
//	global.GamePad = false;
//}
//if (gamepad_button_check_pressed(global.gPnum, gp_start)) {
//	global.GamePad = true;
//}
//if (!//global.padset) {
//	global.GamePad = false;
//    //global.padset = true;
//}

//for (var i = 0; i < gamepad_get_device_count(); i++) {
//	if(gamepad_is_connected(i)){
//		global.gPnum = i;
//		gamepad_set_axis_deadzone(global.gPnum, 0.7);
//	}
//	if (os_type == os_android) {
//		if (device_mouse_check_button(0,mb_left)) {
//		    global.GamePad = false;
//		}
//	    if(global.GamePad){
//			if (instance_exists(oJoystick)) {
//				instance_destroy(oJoystick);
//			}
//		}
//		else{
//			if (!instance_exists(oJoystick)) {
//				instance_create_depth(0,0,0,oJoystick);
//			}
//		}
//	}
//}
#endregion
#region fps mean
var _idx = stepsPassed % fpsArraySize;
var _fps_real = 1 / ( delta_time / 1000000 );
movingSum -= fpsArray[_idx];
fpsArray[_idx] = _fps_real;
movingSum += _fps_real;
fpsAverage = movingSum / fpsArraySize;
#endregion
#region room limit, TODO: redo all this crap
if (instance_exists(oPlayer)) {
	var xx;
	var yy;
	var px;
	var py;
	if (room == rStage1) {	
		var insts = [oEnemy, oAnvil, oUpgrade, oDropParent, oBubba, oBubbaBark, oMascot, oChest, oUpgradeNew];
	    if (oPlayer.x < 610) {
			xx = oCam.x - oPlayer.x;
			px = oPlayer.x;
			py = oPlayer.y;
		    oPlayer.x = 3170;
			oCam.x = oPlayer.x + xx;
			if (instance_exists(oEvents)) {
			    for (var i = 0; i < array_length(oEvents.clouds); ++i) {
					oEvents.clouds[i][0] = oPlayer.x + (oEvents.clouds[i][0] - px);
				}
			}
		
			for (var i = 0; i < array_length(insts); ++i) {
			    with (insts[i]) {
				    xx = x - px;
					yy = y - py;
					x = oPlayer.x + xx;
					y = oPlayer.y + yy;
					xstart = xstart + xx;
					if (variable_instance_exists(self, "xxstart")) {
					    xxstart = xxstart + xx;
					    yystart = yystart + yy;
					}
				}
			}
		}
		if (oPlayer.x > 3170) {
			xx = oCam.x - oPlayer.x;
			px = oPlayer.x;
			py = oPlayer.y;
		    oPlayer.x = 610;
			oCam.x = oPlayer.x + xx;
			if (instance_exists(oEvents)) {
			    for (var i = 0; i < array_length(oEvents.clouds); ++i) {
				    oEvents.clouds[i][0] = oPlayer.x + (oEvents.clouds[i][0] - px);
				}
			}
		
			for (var i = 0; i < array_length(insts); ++i) {
			    with (insts[i]) {
				    xx = x - px;
					yy = y - py;
					x = oPlayer.x + xx;
					y = oPlayer.y + yy;
					xstart = xstart - xx;
					ystart = ystart + yy;
					if (variable_instance_exists(self, "xxstart")) {
					    xxstart = xxstart + xx;
					    yystart = yystart + yy;
					}
				}
			}
		}
		if (oPlayer.y < 610) {
			xx = oCam.x - oPlayer.x;
			yy = oCam.y - oPlayer.y;
			px = oPlayer.x;
			py = oPlayer.y;
		    oPlayer.y = 3170;
			oCam.y = oPlayer.y + yy;
			if (instance_exists(oEvents)) {
			    for (var i = 0; i < array_length(oEvents.clouds); ++i) {
				    oEvents.clouds[i][1] = oPlayer.y + (oEvents.clouds[i][1] - py);
				}
			}
			for (var i = 0; i < array_length(insts); ++i) {
			    with (insts[i]) {
				    xx = x - px;
					yy = y - py;
					x = oPlayer.x + xx;
					y = oPlayer.y + yy;
					ystart = ystart + yy;
					if (variable_instance_exists(self, "xxstart")) {
					    xxstart = xxstart + xx;
					    yystart = yystart + yy;
					}
				}
			}
		}
		if (oPlayer.y > 3170) {
			xx = oCam.x - oPlayer.x;
			yy = oCam.y - oPlayer.y;
			px = oPlayer.x;
			py = oPlayer.y;
		    oPlayer.y = 610;
			oCam.y = oPlayer.y + yy;
			if (instance_exists(oEvents)) {
			    for (var i = 0; i < array_length(oEvents.clouds); ++i) {
				    oEvents.clouds[i][1] = oPlayer.y + (oEvents.clouds[i][1] - py);
				}
			}
			for (var i = 0; i < array_length(insts); ++i) {
			    with (insts[i]) {
				    xx = x - px;
					yy = y - py;
					x = oPlayer.x + xx;
					y = oPlayer.y + yy;
					ystart = ystart - yy;
					if (variable_instance_exists(self, "xxstart")) {
					    xxstart = xxstart + xx;
					    yystart = yystart + yy;
					}
				}
			}
		}
		if (oPlayer.x > room_width / 2) {
			with (oMapItemParent) {
				if (x < 1100) {
					//currentside = 1;
					//lastside = 0;
					x += 2560;
				}
			}
		}
		if (oPlayer.x < room_width / 2) {
			with (oMapItemParent) {
				if (x >= 2655) {
					//currentside = 0;
					//lastside = 1;
					x -= 2560;
				}
			}
		}
		if (oPlayer.y > room_height / 2) {
			with (oMapItemParent) {
				if (y < 1100) {
					//currentside = 1;
					//lastside = 0;
					y += 2560;
				}
			}
		}
		if (oPlayer.y < room_height / 2) {
			with (oMapItemParent) {
				if (y >= 2655) {
					//currentside = 0;
					//lastside = 1;
					y -= 2560;
				}
			}
		}
	}
}
#endregion
#region Screen Shake
if (layer_exists("ShakeLayer")) {
    shakeFx = layer_get_fx("ShakeLayer");
	fx_set_single_layer(shakeFx, false);
	fx_set_parameter(shakeFx, "g_Magnitude", shakeMagnitude);
	fx_set_parameter(shakeFx, "g_ShakeSpeed", shakeSpeed);
}
// Fall to 0
if (shakeMagnitude > 0)
{
	shakeMagnitude -= 0.2;
}
#endregion
#region Strafe
var pressed = (input_check("accept") and !global.gamePaused) ? true : false;
global.strafe = pressed;
#endregion
#region Spawn
if (!instance_exists(oEvents)) {instance_create_layer(0,0,"Instances",oEvents);}
// Feather disable once GM2017
if (instance_exists(oPlayer) and canspawn == true and global.gamePaused == false and room == rStage1 and global.spawnEnemies == 1 and global.IsHost) {
	var place = irandom_range(1,4);
	var _x = oPlayer.x;
	var _y = oPlayer.y;
	switch (place) {
	    case 1:
	        _y -= 300;
			_x += random_range(0, view_wport[0]);
	        break;
	    case 2:
	        _y += 300;
			_x += random_range(0, view_wport[0]);
	        break;
	    case 3:
	        _x -= 400;
			_y += random_range(0, view_hport[0]);
	        break;
	    case 4:
	        _x += 400;
			_y += random_range(0, view_hport[0]);
	        break;
	}
    canspawn=false;
	var _spawnTimer = 60;
	#region Spawn Timer modifiers
	if (oPlayer.menhera) {
	    _spawnTimer = 10;
	}
	#endregion
	alarm[0] = _spawnTimer;
	instance_create_layer(_x, _y, "Instances", oEnemy);
}
#endregion
#region Time
if (global.gamePaused == false and instance_exists(oPlayer)) {
	global.seconds+=(1/60) * Delta ;
	#region Skills Cooldown
	for (var i = 0; i < array_length(global.perkCooldown); ++i) {
		global.perkCooldown[i] -= (1/60) * Delta;
		if (variable_struct_exists(PLAYER_PERKS[i], "func")) {
			PLAYER_PERKS[i][$ "func"](PLAYER_PERKS[i][$ "level"], WeaponEvent.PerkCooldown);
		}
	}
	//feather disable once GM1041
	for (var i = 0; i < array_length(UPGRADES); ++i) {
		if (UPGRADES[i] != global.null) {
			var _bonus = 1;
			if (oPlayer.wallMart) {
			    _bonus = 7;
			}
			global.upgradeCooldown[UPGRADES[i].id] -= (1 * _bonus) * Delta;
		}
	}
	for (var i = 0; i < array_length(global.itemCooldown); ++i) {
		if (global.itemCooldown[i] > 0) {
			global.itemCooldown[i] -= (1/60) * Delta;
		}   
	}
	#endregion
	#region buff coldown
	//for (var i = 0; i < array_length(PlayerBuffs); ++i) {
	//	if (variable_struct_exists(PlayerBuffs[i], "cooldown")) {
	//		if (PlayerBuffs[i].cooldown > 0) {
	//			PlayerBuffs[i].cooldown -= 1/60 * Delta;
	//			switch (PlayerBuffs[i][$ "id"]) {
	//				case BuffNames.SakeFood:{
	//					Bonuses[BonusType.Critical][ItemIds.Sake][1] = 1.05;
	//					break;}
	//				case BuffNames.Spaghetti:{
	//					oPlayer.spaghettiEaten = true;
	//					break;}
	//				case BuffNames.Soda:{
	//					var _spd = 1.03;
	//					var _crt = 1.03;
	//					var _haste = 1.03;
	//					for (var j = 0; j < array_length(PLAYER_PERKS); ++j) {
	//					    if (PLAYER_PERKS[j].id == PerkIds.SodaFueled and PLAYER_PERKS[j].level == 3) {
	//						    _spd = 1.09;
	//							_crt = 1.09;
	//							_haste = 1.09;
	//						}
	//					}
	//					PerkBonuses[BonusType.Critical][PerkIds.SodaFueled] = _crt;
	//					PerkBonuses[BonusType.Speed][PerkIds.SodaFueled] = _spd;
	//					PerkBonuses[BonusType.Haste][PerkIds.SodaFueled] = _haste;
	//					break;}
	//			}
	//		}
	//		if (PlayerBuffs[i].cooldown <= 0) {
	//			if (!variable_struct_exists(PlayerBuffs[i], "permanent")) {
	//				//PlayerBuffs[i].enabled = false;
	//				if (variable_struct_exists(PlayerBuffs[i], "count")) {
	//					PlayerBuffs[i][$ "count"] = 0;
	//				}
	//			}
	//			switch (PlayerBuffs[i][$ "id"]) {
	//				case BuffNames.Sake:{
	//					if (PlayerBuffs[i][$ "count"] < PlayerBuffs[i][$ "maxCount"]) {
	//						PlayerBuffs[i][$ "count"] += 1;
	//					}
	//					var _amount = (PlayerBuffs[BuffNames.Sake][$ "count"] < 10) ? "1.0{0}" : "1.{0}";
	//					Bonuses[BonusType.Critical][ItemIds.Sake][0] = real(string(_amount, PlayerBuffs[BuffNames.Sake][$ "count"]));
	//					Buffs[i][$ "cooldown"] = Buffs[i][$ "baseCooldown"];
	//					break;}
	//				case BuffNames.SakeFood:{
	//					Bonuses[BonusType.Critical][ItemIds.Sake][1] = 0;
	//					break;}
	//				case BuffNames.Spaghetti:{
	//					oPlayer.spaghettiEaten = false;
	//					break;}
	//				case BuffNames.Soda:{
	//					var _spd = 0;
	//					var _crt = 0;
	//					var _haste = 0;
	//					PerkBonuses[BonusType.Critical][PerkIds.SodaFueled] = _crt;
	//					PerkBonuses[BonusType.Speed][PerkIds.SodaFueled] = _spd;
	//					PerkBonuses[BonusType.Haste][PerkIds.SodaFueled] = _haste;
	//					break;}
	//				case BuffNames.BellyDance:
	//					Buffs[i][$ "cooldown"] = Buffs[i][$ "baseCooldown"];
	//					if (oPlayer.moving) {
	//						Buffs[BuffNames.BellyDance][$ "count"]++;
	//					}
	//					else if (Buffs[BuffNames.BellyDance][$ "count"] > 0) {
	//						instance_create_depth(oPlayer.x, oPlayer.y, oPlayer.depth, oUpgradeAttach, {upg : UPGRADES[0], mindmg : UPGRADES[0][$ "mindmg"], maxdmg : UPGRADES[0][$ "maxdmg"], sprite_index : sAkiCircle, step : bellydance_step, image_xscale : .1, image_yscale : .1, count : Buffs[BuffNames.BellyDance][$ "count"]})
	//						Buffs[BuffNames.BellyDance][$ "count"] = 0;
	//					}
	//					break;
	//				}
	//			}
	//		}	
	//	}
	#endregion
}

	if (global.seconds > 59) {
		global.seconds=0;	
		global.minutes+=1;	
		if (Minutes > 30) {
		    global.minutesPast30 += 1;
		}
	}
	
	if (global.minutes > 60) {
	    global.minutes = 0;
		global.hours+=1;
	}
	
	//a b
	global.timeA = max(0, Minutes - 23) + 37 * Hours;
	global.timeB = global.minutesPast30 + 60 * global.hoursPast1;
#endregion
#region in stage
if (global.musicPlaying != undefined) {
	//audio_sound_gain(global.musicPlaying, global.musicVolume, 0);
}
#endregion