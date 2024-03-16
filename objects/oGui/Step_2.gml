var _updown = - upKey + downKey;
var _leftright = - leftKey + rightKey;
if (isP != global.gamePaused) {
    //loadSettingValues();
}
#region Menu
if (room == rInicio) {
	if (!global.gamePaused) {
	    if (upKey) { if (selected == 0) { selected = array_length(menuOptions) - 1; } else selected -= 1; }
		if (downKey) { if (selected < array_length(menuOptions) - 1) { selected += 1; } else selected = 0; }
		//mouseOnButton(GW/1.25, GW/6, 55, sHudButton, 1.75, 1.5, menuOptions);
	}
}
#endregion
#region Achievements screen
if (room == rAchievements) {
	if (input_check_pressed("cancel")) {
	    room_goto(rInicio);
	}
}
#endregion
#region Character selection screen
if (room == rCharacterSelect) {
	if (!characterSelected) {
		if (_leftright != 0) {
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
}
#endregion
#region Level Up
if (instance_exists(oPlayer) and global.upgrade==1) {
	var istherererolls = 1;
	if (global.rerolls > 0) { istherererolls = 0; }
	selected += _updown;
    if (selected < 0) { selected = array_length(global.upgradeOptions) - istherererolls; }
    if (selected > array_length(global.upgradeOptions) - istherererolls) { selected = 0; }
}
#endregion
#region Anvil
if (instance_exists(oPlayer) and ANVIL) {
	if (anvilconfirm) { return; }
	anvilSelected += _leftright;
	if (anvilSelected < 0) { anvilSelected = 5; }
	if (anvilSelected > 5) { anvilSelected = 0; }
	anvilSelectedCategory += _updown;
	if (anvilSelectedCategory < 0) { anvilSelectedCategory = 0; }
	if (anvilSelectedCategory > 1) { anvilSelectedCategory = 1; }	
}
#endregion
#region PausedMenu
if (global.gamePaused and !global.upgrade and !ANVIL and !editOption) {
	selectedOption += _updown;
	if (selectedOption < 0) { selectedOption = totalOptions; }
	if (selectedOption > totalOptions) { selectedOption = 0; }
	if (selectedOption > maxOptions) { startOption += 1; }
	if (selectedOption < startOption) { startOption -= 1; }
}
#endregion
#region Initial configuration
if (!global.initialConfigDone and room != rInitialConfig) {
    room_goto(rInitialConfig);
}
#endregion
if (hpUiLastValue != global.showhpui) {
    upgradesSurface();
}