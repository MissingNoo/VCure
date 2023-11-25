if (keyboard_check_pressed(vk_control)) {
    addEvent = true;
}

if (addEvent and keyboard_check_pressed(vk_enter)) {
	var _time = $"m{minutes}s{seconds}";
    stage[$ _time] = {};
	addEvent = false;
}