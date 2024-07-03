var _updown = - input_check_pressed("up") + input_check_pressed("down");
var _leftright = - input_check_pressed("left") + input_check_pressed("right");
#region Menu
if (room == rInicio) {
	if (!global.gamePaused and !isBusy) {
	    selected += _updown;
		selected = clamp(selected, 0, array_length(menuOptions) - 1);
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
#region Level Up
if (instance_exists(oPlayer) and global.upgrade) {
	var istherererolls = 1;
	if (global.rerolls > 0) { istherererolls = 0; }
	selected += _updown;
    if (selected < 0) { selected = array_length(global.upgradeOptions) - istherererolls; }
    if (selected > array_length(global.upgradeOptions) - istherererolls) { selected = 0; }
}
#endregion
#region PausedMenu
if (global.gamePaused and !isBusy and !editOption) {
	selectedOption += _updown;
	if (selectedOption < 0) { selectedOption = totalOptions; }
	if (selectedOption > totalOptions) { selectedOption = 0; }
	if (selectedOption > maxOptions) { startOption += 1; }
	if (selectedOption < startOption) { startOption -= 1; }
}
#endregion
#region Initial configuration
if (!global.initialConfigDone and room != rInitialConfig) {
	global.initialConfigDone = false;
    room_goto(rInitialConfig);
}
#endregion
if (hpUiLastValue != global.showhpui) {
    upgradesSurface();
}