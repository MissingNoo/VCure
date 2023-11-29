if (keyboard_check_pressed(vk_control)) {
    addEvent = true;
}

if (addEvent and keyboard_check_pressed(vk_enter)) {
	var _seconds = string(round(seconds));
	if (real(_seconds) < 10) { _seconds = $"0{_seconds}"; }
	var _minutes = string(round(minutes));
	if (real(_minutes) < 10) { _minutes= $"0{_minutes}"; }
	var _time = $"m{_minutes}s{_seconds}";
    stage[$ _time] = {};
	addEvent = false;
}

if (!addEvent and !addEventEvent and !selectingEnemy and !addToList) {
	var _mult = 10;
	if (keyboard_check(vk_shift)) {
	    _mult = 30;
	}
    scrollOffset -= -mouse_wheel_up() * _mult+ mouse_wheel_down() * _mult;
}


if (selectingEnemy) {
	var _updown = -mouse_wheel_up() + mouse_wheel_down();
    enemyStart += _updown;
	enemyEnd += _updown;
}

//var _enemy = EnemyList[selectedEnemy][? "sprite"];
//enemySubimg[2] = sprite_get_speed(_enemy);
//enemySubimg[1] = sprite_get_number(_enemy);
for (var i = 0; i < Enemies.Lenght; ++i) {
	if (enemySubImgs[i] == "error") {
	    continue;
	}
    if (enemySubImgs[i][0] < enemySubImgs[i][1]) {
	    enemySubImgs[i][0] += (1/60 * enemySubImgs[i][2]) * Delta;
	}
	if (enemySubImgs[i][0] >= enemySubImgs[i][1]) {
	    enemySubImgs[i][0] = 0;
	}
}
//if (enemySubImgs[0] < enemySubimg[1]) {
//    enemySubimg[0] += (1/60 * enemySubimg[2]) * Delta;
//}
//if (enemySubimg[0] >= enemySubimg[1]) {
//    enemySubimg[0] = 0;
//}
