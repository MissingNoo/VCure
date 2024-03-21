if (keyboard_check_pressed(vk_numpad0) or distance_to_object(oPlayer) > 300) {
    instance_destroy();
}
//if (goingInside and distance_to_object(oPlayer) > 5) {
	
//}
if (goingInside) {
	scale = lerp(scale, 0, 0.1);
}
else {
	scale = lerp(scale, originalScale, 0.1);
}
image_xscale = scale * scaleMult;
image_yscale = scale;
