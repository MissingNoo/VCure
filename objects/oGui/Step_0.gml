#region Screen Size
GW = display_get_gui_width();
GH = display_get_gui_height();
#endregion
if (os_type == os_android) {
    startX = GW - 150;
	startY = 0 + 10;
	zButton = [startX,								startY, startX + 120,			 startY + 45, "Z"];
	zB.rectangle(zButton[0], zButton[1], zButton[2], zButton[3]);
	xButton = [startX - 140,					startY, startX - 140 + 120, startY + 45, "X"];
	xB.rectangle(xButton[0], xButton[1], xButton[2], xButton[3]);
	pButton = [startX - 280,					startY, startX - 280 + 120, startY + 45, "P"];
	pB.rectangle(pButton[0], pButton[1], pButton[2], pButton[3]);
	plusButton = [startX - 420,			startY, startX - 420 + 120, startY + 45, ">"];
	minusButton = [startX - 560,		startY, startX - 560 + 120, startY + 45, "<"];
	houseButton = [startX - 700,		startY, startX - 700 + 120, startY + 45, "H"];
	hB.rectangle(houseButton[0], houseButton[1], houseButton[2], houseButton[3]);
	guiminus = [startX - 420,				startY, startX - 420 + 120, startY + 45, "Gui +"];
	guiminusButton.rectangle(guiminus[0], guiminus[1], guiminus[2], guiminus[3]);
	guiplus = [startX - 560,					startY, startX - 560 + 120, startY + 45, "Gui -"];
	guiplusButton.rectangle(guiplus[0], guiplus[1], guiplus[2], guiplus[3]);
	if (!is_undefined(global.guiScale)) {
	    gui_set();
	}
	else {
		global.guiScale = 1.5;
	}
}
#region Misc
isP=global.gamePaused;
if (TouchX1 != mousePrevious[0]) {
    mousePrevious[0] = TouchX1;
	x = TouchX1;
	y = TouchY1;
}
if (TouchY1 != mousePrevious[1]) {
    mousePrevious[1] = TouchY1;
	x = TouchX1;
	y = TouchY1;
}
if (device_mouse_check_button_pressed(0, mb_left)) {
    x = device_mouse_x_to_gui(0);
	y = device_mouse_y_to_gui(0);
}
if (device_mouse_check_button_released(0, mb_left)) {
    x = 0;
	y = 0;
	if (instance_exists(oLobby)) {
		oLobby.clicked = false;
	}
}
#endregion
#region Title Screen
//if (instance_number(oTitleRunning) == 0 and room == rInicio) {
//    instance_create_layer(0,0, "Instances", oTitleRunning);
//}	
if (room == rInicio and instance_exists(oClient)) {
    instance_destroy(oClient);//feather disable once GM2017
	global.IsHost = true;
}
if (room == rStage1 and !instance_exists(oClient)) {
	instance_create_layer(1895, 1880, "Instances", oClient);
    instance_create_layer(1895, 1880, "Instances", oPlayer);
}
#endregion	
#region Input
//feather disable GM1044
zKey = input_check_pressed("accept") or menuClick;
menuClick = false;
xKey = input_check_pressed("cancel");
eKey = input_check_pressed("action");
leftKey = input_check_pressed("left");
if (buttonClick(minusButton)) { leftKey = true; }
rightKey = input_check_pressed("right");
if (buttonClick(plusButton)) { rightKey = true; }
upKey = input_check_pressed("up");
downKey = input_check_pressed("down");
//feather enable GM1044
#endregion
#region Pause Menu
if (activeMenu == PMenus.Pause) { editOption = false; }
if (xKey and global.gamePaused and !ANVIL and !GoldenANVIL) {
	if (!editOption) {
		if (activeMenu != PMenus.Pause and room != rInicio) {
		    activeMenu = PMenus.Pause;
		}
		else{
			pause_game();
			justopened = 0;
		}
	}
	else{
		editOption = false;
		justopened = 1;
	}
}
#endregion
#region Start Menu
if (room == rInicio and !global.gamePaused) {
	if (keyboard_check_pressed(vk_home) and keyboard_check(vk_shift)) {
	    room_goto(rStageCreator);
	}
	if (zKey) {
	    switch (selected) {
			//case MenuOptionsEnum.Map:{
			//	global.player=CHARACTERS[irandom_range(1, array_length(CHARACTERS) - 1)];
			//	//room_goto(rDungeon);
			//	room_goto(rMap);
			//	audio_stop_sound(global.musicPlaying);
			//	break;}
	        case MenuOptionsEnum.Singleplayer:{
				resetSidebar();
				stageSelected = false;
				characterSelected = false;
				global.singleplayer = true;
				selected=0;
				selectingOutfit = false;
				selectedOutfit = 0;
				maxOutfits = 0;
				outfitSelected = false;
	            room_goto(rCharacterSelect);
	            break;}
			case MenuOptionsEnum.Multiplayer:{
				resetSidebar();
				if (os_type == os_gxgames) {
				    show_message_async("Incompatible with browser versions");
					break;
				}
				global.singleplayer = false;
				//instance_create_layer(0, 0, "Instances", oClient);
				characterSelected = false;					
				selected=0;
				selectingOutfit = false;
				selectedOutfit = 0;
				maxOutfits = 0;
				outfitSelected = false;
	            room_goto(rCharacterSelect);
	            break;}
			//case MenuOptionsEnum.Settings:{
			//	keyboard_clear(ord("Z"));
			//	pause_game();
			//	activeMenu = PMenus.Settings;
			//	break;}
			case MenuOptionsEnum.Shop:{
				DEBUG
					global.holocoins = 99999;
				ENDDEBUG
				keyboard_clear(ord("Z"));
				room_goto(rShop);
				break;}
	        case MenuOptionsEnum.Quit:{
				Save_Data_Structs();
	            game_end();
	            break;}
	        case MenuOptionsEnum.Achieves:{
				room_goto(rAchievements);
	            break;}
	    }
	}
}
#endregion
#region LevelUp control
if (global.upgrade) {
	if (holoarrowspr <= 8) { holoarrowspr+=.25; } else { holoarrowspr=0; } // arrow sprite index
	if (zKey) {
		if (selected == 4) {
			if (global.rerolls > 0) {
				//feather disable once GM2016
				random_upgrades();
				global.rerolls--;
			}
			return;
		}
		for (var i = 0; i < 6; i++) 
		{	
			if (global.upgradeOptions[selected][$ "name"] == "null") { break; }
			if (global.upgradeOptions[selected][$ "id"] == ItemIds.Holocoin){ 
				var coins = 50;//feather disable once GM2017
				for (var j = 1; j < global.shopUpgrades.MoneyGain.level; ++j) {
					coins = coins + ((coins * 20) / 100);
				}
				global.newcoins += coins;
				break; 
			}
			if (global.upgradeOptions[selected][$ "id"] == ItemIds.Hamburguer){ HP += 10; break; }
			if (global.upgradeOptions[selected][$ "style"] == ItemTypes.Weapon) {
				#region Upgrade existing weapon
				if (UPGRADES[i][$ "name"] == global.upgradeOptions[selected][$ "name"] ) 
				{
					//show_message(global.upgradesAvaliable[UPGRADES[i][$"id"]]);
					var newlevel = UPGRADES[i][$ "level"] + 1;
					UPGRADES[i] = global.upgradesAvaliable[UPGRADES[i].id][newlevel];
					share_weapon(i);
					break;
				}			
				#endregion
				#region new weapon
				if (UPGRADES[i][$ "name"] == "null") 
				{
					for (var j=0; j<array_length(global.upgradesAvaliable); j++) 
					{
						if (global.upgradesAvaliable[j][1][$ "name"] == global.upgradeOptions[selected][$ "name"]) 
						{
							UPGRADES[i]=global.upgradesAvaliable[j][1];
							share_weapon(i);
						}
					}
					break;
				}
				#endregion
			}
			else if (global.upgradeOptions[selected][$ "style"] == ItemTypes.Item) {
				#region Upgrade existing item
				if (playerItems[i][$ "name"] == global.upgradeOptions[selected][$ "name"] ) 
				{
					var newlevel = playerItems[i][$ "level"] + 1;
					playerItems[i] = ItemList[playerItems[i][$ "id"]][newlevel];
					share_item(i);
					break;
				}
				#endregion
			
				#region new item
				if (playerItems[i][$ "name"] == "") 
				{
					for (var j=0; j<array_length(ItemList); j++) 
					{
						if (ItemList[j][1][$ "name"] == global.upgradeOptions[selected][$ "name"]) 
						{
							playerItems[i]=ItemList[j][1];
							share_item(i);
						}
					}
					break;
				}
				#endregion
			}
			else if (global.upgradeOptions[selected][$ "style"] == ItemTypes.Perk) {
				#region Upgrade existing item
				if (PLAYER_PERKS[i][$ "name"] == global.upgradeOptions[selected][$ "name"] ) 
				{
					var newlevel = PLAYER_PERKS[i][$ "level"]+1;
					PLAYER_PERKS[i] = PERK_LIST[PLAYER_PERKS[i][$ "id"]][newlevel];
					break;
				}
				#endregion
			}
		}
		global.xp -= oPlayer.neededxp;
		global.upgrade = 0;
		pause_game();
		upgradesSurface();
	}
}
#endregion
#region Anvil
if (ANVIL) {
	var selectedThing;
	if (anvilSelectedCategory == 0) {
		selectedThing = UPGRADES[anvilSelected];
	}else{
		selectedThing = playerItems[anvilSelected];
	}
	var level = selectedThing[$ "level"];
	var maxlevel = selectedThing[$ "maxlevel"];	
	if (xKey) {
		if (anvilconfirm and !upgradeconfirm) {
		    anvilconfirm = false;
		}
		if (anvilconfirm and upgradeconfirm) {
		    upgradeconfirm = false;
		}	    
	}
	if (zKey) {
		var _finishAnvil = false;
		if (upgradeconfirm) {
		    if (anvilSelectedCategory == 0) {
				if (level < maxlevel) {
				    UPGRADES[anvilSelected] = global.upgradesAvaliable[UPGRADES[anvilSelected][$ "id"]][UPGRADES[anvilSelected][$ "level"] + 1];
					_finishAnvil = true;
				}
				else if (global.newcoins >= upgradeCoinValue) {
					var _bonusdmg = 0;
					switch (oPlayer.blacksmithLevel) {
					    case 0:
					        _bonusdmg = 2;
					        break;
					    case 1:
					        _bonusdmg = 2;
					        break;
					    case 2:
					        _bonusdmg = 2.5;
					        break;
					    case 3:
					        _bonusdmg = 3;
					        break;
					    default:
					        break;
					}
					if (!variable_struct_exists(UPGRADES[anvilSelected], "bonusLevel")) {
					    variable_struct_set(UPGRADES[anvilSelected], "bonusLevel", 1);
						UPGRADES[anvilSelected][$ "bonusDamage"] = [_bonusdmg];
					}
					else{
						variable_struct_set(UPGRADES[anvilSelected], "bonusLevel", variable_struct_get(UPGRADES[anvilSelected], "bonusLevel") + 1);
						array_push(UPGRADES[anvilSelected][$ "bonusDamage"], _bonusdmg);
					}
					global.newcoins -= upgradeCoinValue;
					_finishAnvil = true;
				}
			}
			if (anvilSelectedCategory == 1) {
				if (level < maxlevel) {
					playerItems[anvilSelected] = global.itemList[playerItems[anvilSelected][$ "id"]][playerItems[anvilSelected][$ "level"] + 1];
					_finishAnvil = true;
				}
			}
			if (_finishAnvil) {
			    ANVIL = false;
				anvilconfirm = false;
				upgradeconfirm = false;
				pause_game();
			}
		}	
		if (!upgradeconfirm and anvilconfirm) {
		    upgradeconfirm = true;
		}
		if (!anvilconfirm and ANVIL and selectedThing!=global.null and selectedThing != global.nullitem) {
			if (anvilSelectedCategory == 1 and level < maxlevel) {
			    anvilconfirm = true;
			}
			if (anvilSelectedCategory == 0) {
			    anvilconfirm = true;
			}
		}
		upgradesSurface();
	}
}
#endregion
#region Golden Anvil
if (GoldenANVIL) {
	if (zKey and canCollab) {
	    UPGRADES[gAnvilWeapon1Position] = global.null;
	    UPGRADES[gAnvilWeapon2Position] = global.null;
		for (var i = 0; i < array_length(Collabs); ++i) {
		    if (is_array(Collabs[i]) and ((Collabs[i][0] == gAnvilWeapon1[$ "id"] and Collabs[i][1] == gAnvilWeapon2[$ "id"]) or (Collabs[i][0] == gAnvilWeapon2[$ "id"] and Collabs[i][1] == gAnvilWeapon1[$ "id"]))) {
				var _n = min(gAnvilWeapon1Position, gAnvilWeapon2Position);
			    UPGRADES[_n] = WEAPONS_LIST[i][1];
				UPGRADES[_n][$ "materials"] = [];
				UPGRADES[_n][$ "materials"][0] = gAnvilWeapon1;
				UPGRADES[_n][$ "materials"][1] = gAnvilWeapon2;
				break;
			}
		}	
		for (var i = 0; i < array_length(UPGRADES) - 1; ++i) {
		    if (UPGRADES[i] == global.null and UPGRADES[i+1] != global.null) {
			    UPGRADES[i] = UPGRADES[i + 1];
			    UPGRADES[i + 1] = global.null;
				i=0;
			}
		}
		GoldenANVIL = false;
		gAnvilWeapon1 = global.null;
	    gAnvilWeapon2 = global.null;
		gAnvilWeapon1Position = 0;
		gAnvilWeapon2Position = 0;
		canCollab = false;
		pause_game();
		upgradesSurface();
		return;
	}
	if (xKey) {
	    gAnvilWeapon1 = global.null;
	    gAnvilWeapon2 = global.null;
		gAnvilWeapon1Position = 0;
		gAnvilWeapon2Position = 0;
		canCollab = false;
	}	
}
#endregion
if (room == rCharacterSelect or room == rAchievements) {
    if (instance_number(oTriangle) == 0) {
		instance_create_layer(0,0, "Instances", oTriangle);
	}
}
#region Select Character room
if (room == rCharacterSelect) {
	sidebar[2] = lerp(sidebar[2], sidebar[3], 0.25);
	sidebar[0] = lerp(sidebar[0], sidebarOpen ? sidebar[1] : 65, 0.1);
	#region Character sprite
	characterSubImage[1] = sprite_get_number(currentSprite == 0 ? CHARACTERS[selectedCharacter][?"sprite"] : CHARACTERS[selectedCharacter][?"runningsprite"]);
	characterSubImage[2] = sprite_get_speed(currentSprite == 0 ? CHARACTERS[selectedCharacter][?"sprite"] : CHARACTERS[selectedCharacter][?"runningsprite"]);
	if (characterSubImage[0] < characterSubImage[1]) {
		characterSubImage[0] += ((1/60) * characterSubImage[2]) * Delta;
	}
	if (characterSubImage[0] > characterSubImage[1]) {
		characterSubImage[0] = 0;
	}
	if (spriteChangeTimer > 0) {
	    spriteChangeTimer -= 1/60 * Delta;
	}
	if (spriteChangeTimer < 0) {
	    spriteChangeTimer = 3;
		switch (currentSprite) {
		    case 0:
		        currentSprite = 1;
		        break;
		    case 1:
		        currentSprite = 0;
		        break;
		}
	}
	#endregion
	if (selectingOutfit) {
		if (xKey) {
			selectingOutfit = false;
			characterSelected = false;
		}
		if (zKey) {
			var _isUnlocked = CHARACTERS[selectedCharacter][?"outfits"][selectedOutfit][$ "unlocked"];
			if (_isUnlocked) {
			    selectingOutfit = false;
			    outfitSelected = true;
				global.selectedOutfit = selectedOutfit;
			}
			return;
		}
	}
	if (!stageSelected and characterSelected and outfitSelected) {
		if (xKey) {
		    characterSelected = false;
			outfitSelected = false;
			selectedOutfit = 0;
			selected = 0;
			return;
		}
	}
	if (xKey) {
		if (!characterSelected) {
			sidebarOpenByButton = !sidebarOpenByButton;
			return;
		}
	}
	if (zKey) {
		if (stageSelected) {
			room_goto(stages[0].roomname);
		}
		if (!stageSelected and characterSelected and outfitSelected) {
			stageSelected = true;
			if (selected == 0) { global.stageType = StageTypes.Stage; }
			if (selected == 1) { global.stageType = StageTypes.Endless; }
			return;
		}
		if (!characterSelected) {
			if (sidebarOpenByButton) { sidebarOpenByButton = false; return; }
			if (!CharacterData[CHARACTERS[selectedCharacter][?"id"]].unlocked) { return; }
			global.player=CHARACTERS[selectedCharacter];
			audio_stop_sound(global.musicPlaying);
			audio_play_sound(snd_char_selected,0,0);
			switch (global.singleplayer) {
				case true:{
					global.mode = "stage";
					//room_goto(Room1);
					characterSelected = true;
					maxOutfits = array_length(CHARACTERS[selectedCharacter][?"outfits"]) - 1;
					var _unlockedOutfits = 0;
					for (var i = 0; i < maxOutfits; ++i) {
						if (CHARACTERS[selectedCharacter][?"outfits"][i][$ "unlocked"]) {
						    _unlockedOutfits += 1;
						}
					}
					if (maxOutfits > 0 and _unlockedOutfits > 1) {
					    selectingOutfit = true;
					}
					else{outfitSelected = true;}
					break;}
				case false:{
					global.mode = "menu";
					room_goto(rLobby);
					break;}
			}
			return;
		}
	}
	
}
#endregion
#region PauseMenu
if (global.gamePaused and !global.upgrade and !ANVIL) {
	pauseMenu[activeMenu][PM.YScale] = 0.75;
	for (var i = 1; i < array_length(pauseMenu[activeMenu][PM.Options]); ++i) {
		if (i < 5) {
		    pauseMenu[activeMenu][PM.YScale] += .1 * i;
		}			
	}	
    if (zKey){
		var _option = pauseMenu[activeMenu][PM.Options][selectedOption];
		switch (_option[1]) {
		    case PM.Bool:
		        variable_global_set(_option[2], !variable_global_get(_option[2]));
		        break;
		    default:
		        // code here
		        break;
		}
		//if (activeMenu == PMenus.Settings and justopened > 0) {
		//	if (!pauseMenu[PMenus.Settings][PM.Bool][selectedOption]) {
		//		editOption = true;
		//	}
		//}
		justopened += 1;
		//var optionIs = "";
		//for (var i = 1; i < string_length(pauseMenu[activeMenu][PM.Options][selectedOption]); ++i) {
		//	if (string_copy(pauseMenu[activeMenu][PM.Options][selectedOption],i,1) == ":") {
		//	    break;
		//	}
		//	if (string_copy(pauseMenu[activeMenu][PM.Options][selectedOption],i,1) == " ") {
		//		i++;
		//	}
		//    optionIs = optionIs + string_copy(pauseMenu[activeMenu][PM.Options][selectedOption],i,1);
		//}
		
		//variable_global_set(optionIs, !variable_global_get(optionIs));
		//loadSettingValues();
		
		lastmenu = activeMenu;
		switch (pauseMenu[activeMenu][PM.Options][selectedOption][0]) {
			case "Skills":{
		        
		        break;}
			case "????":{
		        
		        break;}
			case "Resume":{
		        pause_game();
		        break;}
		    case "Settings":{
		        activeMenu = PMenus.Settings;
		        break;}
			case "Quit":{
				global.mode = "menu";
				pause_game();
		        room_goto(rInicio);
		        break;}
		}
		
		#region settings controlaudio_sound_get_gain(global.musicPlaying));
		#endregion
		if (activeMenu != lastmenu) {
		    selectedOption=0;
			startOption = 0;
			totalOptions = array_length(pauseMenu[activeMenu][PM.Options]);
		}
	}	
	if (leftKey or rightKey){
		var _option = pauseMenu[activeMenu][PM.Options][selectedOption]
		switch (_option[1]) {
		    case PM.Slider:
		        variable_global_set(_option[2], variable_global_get(_option[2]) + (rightKey*0.1) - (leftKey*0.1));
				if (variable_global_get(_option[2]) > 1) { variable_global_set(_option[2], 1); }
				if (variable_global_get(_option[2]) < 0) { variable_global_set(_option[2], 0); }
		        break;
		    default:
		        // code here
		        break;
		}
	}
	//	var optionIs = "";
	//	for (var i = 1; i < string_length(pauseMenu[activeMenu][PM.Options][selectedOption]); ++i) {
	//		if (string_copy(pauseMenu[activeMenu][PM.Options][selectedOption],i,1) == ":") {
	//		    break;
	//		}
	//	    optionIs = optionIs + string_copy(pauseMenu[activeMenu][PM.Options][selectedOption],i,1);
	//	}
	//	switch (optionIs) {
	//	    case "Music Volume":{
	//	        global.musicVolume += (rightKey*0.1) - (leftKey*0.1);
	//			if (global.musicVolume > 1) {
	//			    global.musicVolume = 1;
	//			}
	//			if (global.musicVolume < 0) {
	//			    global.musicVolume = 0;
	//			}
	//			loadSettingValues();
	//	        break;}
	//		case "Sound Volume":{
	//	        global.soundVolume += (rightKey*0.1) - (leftKey*0.1);
	//			if (global.soundVolume > 1) {
	//			    global.soundVolume = 1;
	//			}
	//			if (global.soundVolume < 0) {
	//			    global.soundVolume = 0;
	//			}
	//			loadSettingValues();
	//	        break;}
	//	}
	//}
}
#endregion
#region Debug
if (keyboard_check(ord("B"))) {
    var _xx = GW;
	var _xn = 1;
	var _yy = GH;
	var _yn = 1;
	while (_xx > TouchX1) {
	    _xn += .005;
		_xx = GW/_xn;
	}
	while (_yy > TouchY1) {
	    _yn += .005;
		_yy = GH/_yn;
	}
	a = _xn;
	b = _yn;
	//show_message(string(_xn));
}
if (keyboard_check(ord("N"))) {
    var _xx = GW;
	var _xn = 1;
	var _yy = GH;
	var _yn = 1;
	while (_xx > TouchX1) {
	    _xn += .005;
		_xx = GW/_xn;
	}
	while (_yy > TouchY1) {
	    _yn += .005;
		_yy = GH/_yn;
	}
	c = _xn;
	d = _yn;
	//show_message(string(_xn));
}

if (keyboard_check_pressed(vk_end) and global.debug) {
	debuglog = !debuglog;
    show_debug_log(debuglog)
}
if(input_check_pressed("gm")) {global.guiScale -= .05; if (os_type == os_android) { gui_set();}};
if(input_check_pressed("gp")) {global.guiScale += .05; if (os_type == os_android) { gui_set();}};
DEBUG
if((keyboard_check(vk_escape) and room == rCharacterSelect)) {room_goto(rInicio);}
ENDDEBUG
#endregion