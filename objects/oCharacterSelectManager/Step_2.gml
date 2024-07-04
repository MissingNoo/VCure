var _updown = - input_check_pressed("up") + input_check_pressed("down");
var _leftright = - input_check_pressed("left") + input_check_pressed("right");
switch (state) {
	case "stage":{
		if (!stageSelected) {
			selected += _updown;
			if (selected < 0) { selected = array_length(stageModes) - 1; }
			if (selected > array_length(stageModes) - 1) { selected = 0; }
		}
		else {
			if (input_check_pressed("right") or (mouse_click and point_in_triangle(MX, MY, triangleSR[0][0], triangleSR[0][1], triangleSR[1][0], triangleSR[1][1], triangleSR[2][0], triangleSR[2][1]))) { selectedStage++; }
	        if (input_check_pressed("left") or (mouse_click and point_in_triangle(MX, MY, triangleSL[0][0], triangleSL[0][1], triangleSL[1][0], triangleSL[1][1], triangleSL[2][0], triangleSL[2][1]))){ selectedStage--; }
			var _min = 0;
			var _max = array_length(stages) - 1;
			selectedStage = clamp(selectedStage, _min, _max);
			stageselectlerp[1] = selectedStage * -550;
		}
		break;}
    case "base":
        if (!characterSelected) {
			if (_updown != 0) {
				if (sidebarOpen) {
					selectedAgencyPos += _updown;
					if (selectedAgencyPos >= array_length(agencies)) {
						selectedAgencyPos = 0;
					}
					if (selectedAgencyPos < 0) {
						selectedAgencyPos = array_length(agencies) - 1;
					}
					selectAgency(selectedAgencyPos);
				}
				else {
					var _nextCharacter = selectedCharacter + (5 * _updown);
					if (_nextCharacter < 1 or _nextCharacter > Characters.Lenght - 1) {
						return;
					}
					//if (selectedCharacter + _updown * 4 < Characters.Lenght - 1 or selectedCharacter + _updown * 4 < 0) {
					//    return;
					//}
					selectedCharacter = _nextCharacter;
				}
			}
			if (_leftright != 0 and !sidebarOpen) {
				do {
					selectedCharacter += _leftright;
					if (selectedCharacter < 1) { selectedCharacter = Characters.Lenght - 1; }
					if (selectedCharacter > Characters.Lenght - 1) { selectedCharacter = 1; }
					NAME=CHARACTERS[selectedCharacter][?"name"];
					audio_play_sound(snd_char_select_woosh,0,0);
				} until (CHARACTERS[selectedCharacter][? "agency"] == selectedAgency or selectedAgency == "All");
			}
		}
		if (selectingOutfit) {
			selectedOutfit += _leftright;
			if (selectedOutfit > maxOutfits) { selectedOutfit = 0; }
			if (selectedOutfit < 0) { selectedOutfit = maxOutfits; }
		}
        break;
    case "showinfo":
		if (input_check_pressed("right") or (mouse_click and point_in_triangle(MX, MY, triangleR[0][0], triangleR[0][1], triangleR[1][0], triangleR[1][1], triangleR[2][0], triangleR[2][1]))) { infolevel++; }
        if (input_check_pressed("left") or (mouse_click and point_in_triangle(MX, MY, triangleL[0][0], triangleL[0][1], triangleL[1][0], triangleL[1][1], triangleL[2][0], triangleL[2][1]))){ infolevel--; }
		var _min = 1;
		var _max;
		switch (info) {
		    case "weapon":
		        _max = CHARACTERS[selectedCharacter][?"weapon"][1][$ "maxlevel"];
		        break;
		    case "skills":
		        _max = 3;
		        break;
		}
		infolevel = clamp(infolevel, _min, _max);
        break;
}
