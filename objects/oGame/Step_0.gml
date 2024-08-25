/// @instancevar {Any} fpsArray
/// @instancevar {Any} is_mouse_over_debug_overlay 
if (is_mouse_over_debug_overlay())
{
    window_set_cursor(cr_default);
}
else {
	window_set_cursor(cr_none);
}
if (!global.gamePaused){
	for (var i = array_length(dAlarm) - 1; i >= 0 ; ++i) {
		if (dAlarm[i][0] > 0) {
			dAlarm[i][0] -= 1 * Delta;
		}
		if (dAlarm[i][0] < 0 and dAlarm[i][0] != -1) {
			dAlarm[i][0] = -1;
			dAlarm[i][1]();
			array_delete(dAlarm, i, 1);
		}
	}
}

if (keyboard_check_pressed(vk_f11)) {
    window_set_fullscreen(not window_get_fullscreen());
}
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
#region Gamepad detection
if (input_profile_get(0) == "gamepad") {
    global.gamePad = true;
}
else{
	global.gamePad = false;
}
#endregion
#region Unused
if (keyboard_check(vk_home)) {
	for (var i = 0; i < array_length(UnlockableWeapons); ++i) {
	    UnlockableWeapons[i] = true;
	}
	for (var i = 0; i < array_length(UnlockableItems); ++i) {
	    UnlockableItems[i] = true;
	}
	for (var i = 0; i < array_length(Achievements); ++i) {
	    Achievements[i][$"unlocked"] = true;
	}
	load_unlocked();
	unlocked_outfits_load();
}
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
	var insts = [oEnemy, oAnvil, oUpgradeNew, oDropParent, oBubba, oBubbaBark, oMascot, oChest];
	#region Stage1
	if (room == rStage1) {
		//TODO: some upgrades not teleporting
	    if (oPlayer.x < 610) {
			xx = oCamWorld.x - oPlayer.x;
			px = oPlayer.x;
			py = oPlayer.y;
		    oPlayer.x = 3170;
			oCamWorld.x = oPlayer.x + xx;
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
			xx = oCamWorld.x - oPlayer.x;
			px = oPlayer.x;
			py = oPlayer.y;
		    oPlayer.x = 610;
			oCamWorld.x = oPlayer.x + xx;
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
			xx = oCamWorld.x - oPlayer.x;
			yy = oCamWorld.y - oPlayer.y;
			px = oPlayer.x;
			py = oPlayer.y;
		    oPlayer.y = 3170;
			oCamWorld.y = oPlayer.y + yy;
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
			xx = oCamWorld.x - oPlayer.x;
			yy = oCamWorld.y - oPlayer.y;
			px = oPlayer.x;
			py = oPlayer.y;
		    oPlayer.y = 610;
			oCamWorld.y = oPlayer.y + yy;
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
					x += 2560;
				}
			}
		}
		if (oPlayer.x < room_width / 2) {
			with (oMapItemParent) {
				if (x >= 2655) {
					x -= 2560;
				}
			}
		}
		if (oPlayer.y > room_height / 2) {
			with (oMapItemParent) {
				if (y < 1100) {
					y += 2560;
				}
			}
		}
		if (oPlayer.y < room_height / 2) {
			with (oMapItemParent) {
				if (y >= 2655) {
					y -= 2560;
				}
			}
		}
	}
	#endregion
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
if (instance_exists(oPlayer) and canspawn == true and global.gamePaused == false and global.IsHost and room != rDebugStage) {
	var place = irandom_range(1,4);
	var _x = oPlayer.x;
	var _y = oPlayer.y;
	switch (place) {
	    case 1:
	        _y -= view_hport[0] - 16;
			_x += random_range(0, view_wport[0] + 16);
	        break;
	    case 2:
	        _y += view_hport[0] + 16;
			_x += random_range(0, view_wport[0] + 16);
	        break;
	    case 3:
	        _x -= view_wport[0] - 16;
			_y += random_range(0, view_hport[0] + 16);
	        break;
	    case 4:
	        _x += view_wport[0] + 16;
			_y += random_range(0, view_hport[0] + 16);
	        break;
	}
    canspawn=false;
	var _spawnTimer = global.spawnTimer;
	global.spawnTimer = clamp(global.spawnTimer - 1/250, 10, infinity);
	#region Spawn Timer modifiers
	if (oPlayer.menhera) {
	    _spawnTimer = 10;
	}
	#endregion
	alarm[0] = _spawnTimer;
	if (instance_number(oEnemy) < 50) {
		instance_create_layer(_x, _y, "Instances", oEnemy);
	}
}
#endregion
#region Time
if (global.gamePaused == false and instance_exists(oPlayer)) {
	global.seconds+=(1/60) * Delta ;
	#region Skills Cooldown
	for (var i = 0; i < array_length(PLAYER_PERKS); ++i) {
		global.perkCooldown[PLAYER_PERKS[i].id] = clamp(global.perkCooldown[PLAYER_PERKS[i].id] - ((1/60) * Delta), 0, infinity);
		if (global.perkCooldown[PLAYER_PERKS[i].id] <= 0 and PLAYER_PERKS[i][$ "level"] > 0) {
			global.perkCooldown[PLAYER_PERKS[i].id] = PLAYER_PERKS[i].cooldown;
		    if (variable_struct_exists(PLAYER_PERKS[i], "on_cooldown")) {
				PLAYER_PERKS[i][$ "on_cooldown"]({
					level : PLAYER_PERKS[i][$ "level"]
				});
			}
			if (variable_struct_exists(PLAYER_PERKS[i], "bonus")) {
				if (variable_struct_exists(PLAYER_PERKS[i], "bonusType")) {
					var perkid = PLAYER_PERKS[i][$ "id"];
					var level = PLAYER_PERKS[i][$ "level"];
					if (is_array(PLAYER_PERKS[i][$ "bonusType"])) {
						for (var j = 0; j < array_length(PLAYER_PERKS[i][$ "bonusType"]); ++j) {
							var typebonus = PLAYER_PERKS[i][$ "bonusType"][j];
							var bonusvalue = PLAYER_PERKS[i][$ "bonusValue"][j][level];
							PerkBonuses[typebonus][perkid] = bonusvalue;
						}
					}
					else{
						var typebonus = PLAYER_PERKS[i][$ "bonusType"];
						var bonusvalue = PLAYER_PERKS[i][$ "bonusValue"][level];
						PerkBonuses[typebonus][perkid] = bonusvalue;
					}
				}
			}
		}
	}
	//feather disable once GM1041
	for (var i = 0; i < array_length(UPGRADES); ++i) {
		if (UPGRADES[i] != global.null) {
			var _bonus = 1;
			if (oPlayer.wallMart) {
			    _bonus = 7;
			}
			global.upgradeCooldown[UPGRADES[i].id] = clamp(global.upgradeCooldown[UPGRADES[i].id] - ((1 * _bonus) * Delta), 0, infinity);
		}
	}
	for (var i = 0; i < array_length(global.itemCooldown); ++i) {
		global.itemCooldown[i] = clamp(global.itemCooldown[i] - ((1/60) * Delta), 0, infinity);
	}
	#endregion
	#region buff coldown
	for (var i = array_length(PlayerBuffs) -1; i >= 0; --i) {
		if (variable_struct_exists(PlayerBuffs[i], "cooldown")) {
			if (PlayerBuffs[i].cooldown > 0) {
				PlayerBuffs[i].cooldown -= 1/60 * Delta;
			}
			#region unused
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
			#endregion
			if (PlayerBuffs[i].cooldown <= 0) {
				PlayerBuffs[i][$ "cooldown"] = PlayerBuffs[i][$ "baseCooldown"];
				if (PlayerBuffs[i][$ "func"] != undefined) {
					PlayerBuffs[i][$ "func"](i);
				}
				if (PlayerBuffs[i][$ "permanent"] == false or PlayerBuffs[i][$ "permanent"] == undefined) {
					if (PlayerBuffs[i][$ "leave"] != undefined) {
						PlayerBuffs[i][$ "leave"](i);
					}
					array_delete(PlayerBuffs, i, 1);
				}
			}
		}
	}
	//			switch (PlayerBuffs[i][$ "id"]) {
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
	
	if (Minutes >= 30 and !endlessminutemark) {
	    endlessminutemark = true;
		if (!CharacterData[char_pos(global.player[? "name"], CharacterData)][$ "stagefirstclear"][global.currentStage]) {
		    CharacterData[char_pos(global.player[? "name"], CharacterData)][$ "stagefirstclear"][global.currentStage] = true;
			if (global.stageHard) {
			    CharacterData[char_pos(global.player[? "name"], CharacterData)].fandomxp += 20;
			}
			else {
			    CharacterData[char_pos(global.player[? "name"], CharacterData)].fandomxp += 14;
			}
		}
		else {
			if (global.stageHard) {
			    CharacterData[char_pos(global.player[? "name"], CharacterData)].fandomxp += 10;
			}
			else {
			    CharacterData[char_pos(global.player[? "name"], CharacterData)].fandomxp += 7;
			}
		}
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