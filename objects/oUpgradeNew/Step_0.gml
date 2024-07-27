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
		if (array_length(dAlarm[i]) == 2){
			dAlarm[i][1]();
		}
		if (array_length(dAlarm[i]) == 3){
			switch(dAlarm[i][2]){
				default:
					dAlarm[i][1]();
					break;
				case "variable":
					variable_instance_set(self, dAlarm[i][1][0], dAlarm[i][1][1]);
					break;
				case "ex_func":
					dAlarm[i][1][0](dAlarm[i][1][1]);
					break;
			}
		}
	}
}
#endregion

if (ceil(current_frame) >= last_frame) {
	if (upg[$ "animation_end"] != undefined) {
		animate = false;
	    upg.animation_end(self.id);
	}
	else {
		current_frame = 0;
	}
}
if (animate) {
	current_frame += sprite_speed / game_get_speed(sprite_speed_type) * Delta;
}