/// @description DeltaUpdate
global.updatenow = ds_stack_pop(global.updatepath);
if (instance_exists(global.updatenow)) {
    with (global.updatenow) {
		updated = true;
	}
}
if (!global.pauseGame) {
    global.currentFrame++;
}
actualDelta = delta_time / 1000000;
global.deltaTime =actualDelta/targetDelta;