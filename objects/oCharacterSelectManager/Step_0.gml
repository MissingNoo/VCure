//feather disable GM2017
for (var i = array_length(fandom_current_frame) - 1; i > 0; i -= 1) {
	if (ceil(fandom_current_frame[i][0]) >= fandom_current_frame[i][1]) {
			current_frame = 0;
	}
	fandom_current_frame[i][0] += fandom_frame_speed / game_get_speed(fandom_frame_speed_type) * Delta;
}
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
#region Lerps
if (sidebarlerp[0] != sidebarlerp[1]) {
	sidebarlerp[0] = lerp(sidebarlerp[0], sidebarlerp[1], 0.30);
	if (int64(round(sidebarlerp[0] - sidebarlerp[1])) == 0) {
		sidebarlerp[0] = sidebarlerp[1];
		nextVar();
	}
	exit;
}
if (characterlerp[0] != characterlerp[1]) {
	characterlerp[0] = lerp(characterlerp[0], characterlerp[1], 0.30);
	if (int64(round(characterlerp[0] - characterlerp[1])) == 0) {
		characterlerp[0] = characterlerp[1];
		nextVar();
	}
	exit;
}
if (stagelerp[0] != stagelerp[1]) {
	stagelerp[0] = lerp(stagelerp[0], stagelerp[1], 0.30);
	if (int64(round(stagelerp[0] - stagelerp[1])) == 0) {
		stagelerp[0] = stagelerp[1];
		nextVar();
		stagelerp[1] = 0;
	}
	exit;
}
if (stageselectlerp[0] != stageselectlerp[1]) {
	stageselectlerp[0] = lerp(stageselectlerp[0], stageselectlerp[1], 0.30);
}
#endregion
switch (state) {
	case "stage":
		if (input_check_pressed("accept")) {
			switch (stageSelected) {
			    case true:
					global.currentStage = selectedStage;
					global.stageHard = stages[selectedStage].hard;
			        room_goto(stages[selectedStage].roomname);
			        break;
			    case false:
			        //stageSelected = true;
					nextvar = [false, "stageSelected", true];
					stagelerp[1] = stagelerp[2];
					if (selected == 0) { global.stageType = StageTypes.Stage; }
					if (selected == 1) { global.stageType = StageTypes.Endless; }
			        break;
			}
		}
		if (input_check_pressed("cancel")) {
			switch (stageSelected) {
			    case true:
			        //stageSelected = false;
					nextvar = [false, "stageSelected", false];
					stagelerp[1] = stagelerp[2];
			        break;
			    case false:
			        characterSelected = false;
					outfitSelected = false;
					selectedOutfit = 0;
					selected = 0;
					nextvar = [false, "state", "base"];
					stagelerp[1] = stagelerp[2];
					//state = "base";
			        break;
			}
			return;
		}
		break;
    case "base":
		sidebarlerp[1] = 0;
		characterlerp[1] = 0;
		if (characterSelected and outfitSelected) {
		    state = "stage";
			sidebarlerp[1] = -64;
			characterlerp[1] = characterlerp[2];
			stagelerp[1] = 0;
			stagelerp[0] = stagelerp[2];
			return;
		}
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
		if (input_check_pressed("cancel")) {
			if (!characterSelected) {
				sidebarOpenByButton = !sidebarOpenByButton;
				return;
			}
		}
		if (input_check_pressed("accept")) {
			if (!characterSelected) {
				if (sidebarOpenByButton) { sidebarOpenByButton = false; return; }
				if (!CharacterData[char_pos(CHARACTERS[selectedCharacter][? "name"], CharacterData)].unlocked) { return; }
				global.player=CHARACTERS[selectedCharacter];
				audio_stop_sound(global.musicPlaying);
				audio_play_sound(snd_char_selected,0,0, global.soundVolume);
				//global.mode = "stage";
				nextvar = [false, "characterSelected", true];
				characterlerp[1] = characterlerp[2];
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
				return;
			}
		}
        break;
    case "showinfo":
        if (input_check_pressed("cancel") or mouse_click_right) {
		    state = "base";
		}
        break;
}
