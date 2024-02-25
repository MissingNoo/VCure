var confirm = keyboard_check_pressed(vk_enter);
if (os_type == os_android and point_in_rectangle(MX, MY, oGui.zButton[0], oGui.zButton[1], oGui.zButton[2], oGui.zButton[3]) and mouse_click) {
	confirm = true;
}
switch (currentStep) {
	case ConfigSteps.Language:
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
			currentStep++;
		}
		playername = keyboard_string;		
		break;
	case ConfigSteps.ShowNames:
		if (confirm) {
			global.showOtherNames = !showOtherNames;
			currentStep++;
		}
		break;
	case ConfigSteps.Anonymous:
		if (confirm) {
			global.sendMyName = !sendMyName;
			currentStep++;
		}
		break;
	case ConfigSteps.FinalInfo:
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
