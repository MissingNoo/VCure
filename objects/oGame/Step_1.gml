/// @description DeltaUpdate
if (!global.pauseGame) {
    global.currentFrame++;
}
actualDelta = delta_time / 1000000;
global.deltaTime =actualDelta/targetDelta;