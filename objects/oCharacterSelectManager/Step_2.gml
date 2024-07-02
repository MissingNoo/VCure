var _updown = - input_check_pressed("up") + input_check_pressed("down");
var _leftright = - input_check_pressed("left") + input_check_pressed("right");
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
if (!stageSelected and characterSelected and outfitSelected) {
	selected += _updown;
	if (selected < 0) { selected = array_length(stageModes) - 1; }
	if (selected > array_length(stageModes) - 1) { selected = 0; }
}