bclick = clamp(bclick - 1, 0, infinity);
#region Screen Size
//GW = display_get_gui_width();
//GH = display_get_gui_height();
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
	if (room == rInicio) {
	    guiminus = [startX - 420,				startY, startX - 420 + 120, startY + 45, "Gui +"];
		guiminusButton.rectangle(guiminus[0], guiminus[1], guiminus[2], guiminus[3]);
		guiplus = [startX - 560,					startY, startX - 560 + 120, startY + 45, "Gui -"];
		guiplusButton.rectangle(guiplus[0], guiplus[1], guiplus[2], guiplus[3]);
	}
	else {
		guiminus = [0,0,0,0, "Gui +"];
		guiminusButton.rectangle(guiminus[0], guiminus[1], guiminus[2], guiminus[3]);
		guiplus = [0,0,0,0, "Gui -"];
		guiplusButton.rectangle(guiplus[0], guiplus[1], guiplus[2], guiplus[3]);
	}
	if (!is_undefined(global.guiScale)) {
	    gui_set();
	}
	else {
		global.guiScale = 1.5;
	}
}
else {
	global.guiScale = 2;
	gui_set();
}
#region Misc
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
/*
if (room == rInicio and instance_exists(oClient)) {
    instance_destroy(oClient);//feather disable once GM2017
	global.IsHost = true;
}
if (room == rStage1 and !instance_exists(oClient)) {
	instance_create_layer(1895, 1880, "Instances", oClient);
    instance_create_layer(1895, 1880, "Instances", oPlayer);
}
*/
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
if (xKey and global.gamePaused and !isBusy) {
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
			case MenuOptionsEnum.Map:
				global.player=CHARACTERS[0];
				//room_goto(rDungeon);
				room_goto(rHoloHouseEntrance);
				audio_stop_sound(global.musicPlaying);
				break;
	        case MenuOptionsEnum.Singleplayer:
				global.singleplayer = true;
				selected=0;
	            room_goto(rCharacterSelect);
	            break;
			case MenuOptionsEnum.Multiplayer:
				if (os_type == os_gxgames) {
				    show_message_async("Incompatible with browser versions");
					break;
				}
				global.singleplayer = false;
				//instance_create_layer(0, 0, "Instances", oClient);
				selected=0;
				global.stageType = StageTypes.Stage;
	            room_goto(rLobby);
	            break;
			//case MenuOptionsEnum.Settings:{
			//	keyboard_clear(ord("Z"));
			//	pause_game();
			//	activeMenu = PMenus.Settings;
			//	break;}
			case MenuOptionsEnum.Shop:
				keyboard_clear(ord("Z"));
				room_goto(rShop);
				break;
	        case MenuOptionsEnum.Quit:
				Save_Data_Structs();
	            game_end();
	            break;
	        case MenuOptionsEnum.Achieves:
				room_goto(rAchievements);
	            break;
	    }
	}
}
#endregion
#region LevelUp control
if (global.upgrade) {
	
}
#endregion
if (room == rCharacterSelect or room == rAchievements) {
    if (instance_number(oTriangle) == 0) {
		instance_create_layer(0,0, "Instances", oTriangle);
	}
}
#region PauseMenu
if (global.gamePaused and !isBusy) {
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
			case "Skills":
		        
		        break;
			case "????":
		        
		        break;
			case "Resume":
		        pause_game();
		        break;
		    case "Settings":
		        activeMenu = PMenus.Settings;
		        break;
			case "Quit":
				global.mode = "menu";
				pause_game();
		        room_goto(rInicio);
		        break;
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

//if (keyboard_check_pressed(vk_end) and global.debug) {
	//debuglog = !debuglog;
    //show_debug_log(debuglog)
//}
if(input_check_pressed("gm")) {global.guiScale -= .05; if (os_type == os_android) { gui_set();}};
if(input_check_pressed("gp")) {global.guiScale += .05; if (os_type == os_android) { gui_set();}};
DEBUG
if((keyboard_check(vk_escape) and room == rCharacterSelect)) {room_goto(rInicio);}
ENDDEBUG
#endregion