var zKey, xKey, eKey, upKey, downKey;
zKey = oGui.zKey;
xKey = oGui.xKey;
eKey = oGui.eKey;
upKey = keyboard_check_pressed(vk_up)  or gamepad_button_check_pressed(global.gPnum, gp_padu);
downKey = keyboard_check_pressed(vk_down)  or gamepad_button_check_pressed(global.gPnum, gp_padd);
if (mousein and device_mouse_check_button_released(0,mb_left)) { zKey = true; }
if (image_alpha < 0.65) {
    image_alpha += 0.05;
}

if (downKey) {
    if (selectedOption < array_length(options) - 1) {
	    selectedOption += 1;
	}
	else{
		selectedOption = 0;
	}
}

if (upKey) {
    if (selectedOption > 0) {
	    selectedOption -= 1;
	}
	else{
		selectedOption = array_length(options) - 1;
	}
}

if (zKey) {
    switch (options[selectedOption]) {
	    case "Retry":
	        show_message_async("not ready yet");
	        break;
	    case "Character Select":
			pause_game();
			global.gamePaused = false;
	        room_goto(rCharacterSelect);
	        break;
	    case "Main Menu":
			pause_game();
			global.gamePaused = false;
	        room_goto(rInicio);
	        break;
		case "Submit Highscore":
			var build = {
				character : NAME,
				weapons : [],
				items : [],
				level : global.level
			}
			for (var i = 0; i < array_length(UPGRADES); i += 1) {
				array_push(build.weapons, [UPGRADES[i].name, UPGRADES[i].level]);
			}
			for (var i = 0; i < array_length(playerItems); i += 1) {
				array_push(build.items, [playerItems[i].name, playerItems[i].level]);
			}
			var year = current_year;
			var month = $"{current_month < 10 ? "0" : ""}{current_month}";
			var day = $"{current_day < 10 ? "0" : ""}{current_day}";
			var scoredata = {
				score : global.score,
				build : json_stringify(build),
				date : $"{year}{month}{day}"
			}
			if (cansubmit) {
				cansubmit = false;
				sendMessageNew(Network.SubmitScore, scoredata);
			}
			break;
	    default:
	        // code here
	        break;
	}
}