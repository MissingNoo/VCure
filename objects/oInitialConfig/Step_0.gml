var confirm = keyboard_check_pressed(vk_enter);
if (os_type == os_android and point_in_rectangle(MX, MY, oGui.zButton[0], oGui.zButton[1], oGui.zButton[2], oGui.zButton[3]) and mouse_click) {
	confirm = true;
}
var updown = -keyboard_check_pressed(vk_up) + keyboard_check_pressed(vk_down);
switch (currentStep) {
	case ConfigSteps.Language:
		selectedLanguage[0] += updown;
		if (selectedLanguage[0] > selectedLanguage[1]) { selectedLanguage[0] = 0; }
		if (selectedLanguage[0] < 0) { selectedLanguage[0] = selectedLanguage[1]; }
		if (confirm) {
			ini_open("Settings");
			ini_write_string("Settings", "Language", languages[selectedLanguage[0]][0]);
			ini_close();
			lexicon_language_set(languages[selectedLanguage[0]][0]);
			keyboard_string = playername;
			currentStep++;
		}
		break;
	case ConfigSteps.PlayerName:
		if (string_length(keyboard_string) > 15) {
			keyboard_string = string_copy(keyboard_string, 1, 15);
		}
		if (confirm) {
		    global.username = playername;
			ini_open("Settings");
			ini_write_string("Settings", "Username", global.username);
			ini_close();
			currentStep++;
		}
		playername = keyboard_string;		
		break;
	case ConfigSteps.ShowNames:
		if (updown != 0) { showOtherNames = !showOtherNames; }
		if (confirm) {
			global.showOtherNames = !showOtherNames;
			currentStep++;
		}
		break;
	case ConfigSteps.Anonymous:
		if (updown != 0) { sendMyName = !sendMyName; }
		if (confirm) {
			global.sendMyName = !sendMyName;
			currentStep++;
		}
		break;
	case ConfigSteps.FinalInfo:
		if (updown != 0) { finalAccept = !finalAccept; }
		if (confirm) {
			if (!finalAccept) {
				global.initialConfigDone = true;
			    Save_Data_Structs();
				room_goto(rInicio);
			}
			else{
				currentStep = 0;
			}
		}
		break;
}
