if (global.gamePaused) { exit; }
if (upg[$ "step"] != undefined) {
	upg.step(self.id);
}
afterimage_step();
#region Delta alarms
for (var i = 0; i < array_length(dAlarm); ++i) {
	if (dAlarm[i][0] > 0) {
		dAlarm[i][0] -= 1 * Delta;
	}
	if (dAlarm[i][0] < 0 and dAlarm[i][0] != -1) {
		dAlarm[i][0] = -1;
		dAlarm[i][1]();
	}
}
#endregion

if (ceil(current_frame) == last_frame) {
	if (upg[$ "animation_end"] != undefined) {
		animate = false;
	    upg.animation_end(self.id);
	}
	else {
		current_frame = 0;
	}
}
else if (animate) {
	current_frame += sprite_speed / game_get_speed(sprite_speed_type) * Delta;
}