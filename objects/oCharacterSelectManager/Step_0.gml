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
	if (input_check_pressed("cancel")) {
		selectingOutfit = false;
		characterSelected = false;
	}
	if (input_check_pressed("accept")) {
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
	if (input_check_pressed("cancel")) {
		characterSelected = false;
		outfitSelected = false;
		selectedOutfit = 0;
		selected = 0;
		return;
	}
}
if (input_check_pressed("cancel")) {
	if (!characterSelected) {
		sidebarOpenByButton = !sidebarOpenByButton;
		return;
	}
}
if (input_check_pressed("accept")) {
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
