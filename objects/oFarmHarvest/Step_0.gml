offset = lerp(offset, GH/2, 2 / 10);
if (input_check_pressed("accept")) {
    oPlayerWorld.canMove = true;
    oFarmingPlot.opentimer = 60;
	instance_destroy();
}