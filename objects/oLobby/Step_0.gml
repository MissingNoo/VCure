if (room = rInicio) {
    instance_destroy();
}
wl[0] = lerp(wl[0], wl[1], 0.25);
subimg += 1;
if (subimg > 60) {
	subimg = 0;
}
fsm.step();