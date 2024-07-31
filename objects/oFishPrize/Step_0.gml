offset = lerp(offset, GH/2, 2 / 10);
if (input_check_pressed("accept")) {
    oFishingMinigame.showprize = true;
    oFishingMinigame.alarm[1] = 100;
	oFishingMinigame.prizeoffset = 0;
	instance_destroy();
}