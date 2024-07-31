var p = oPlayerWorld;
if (oPlayerWorld.fishing) {
    draw_sprite_ext(sFishingRod, rod, p.x, p.y, p.image_xscale, 1, 0, c_white, 1);
	draw_sprite_ext(sFishingBop, sprite[0][0], pos[0], pos[1], 1, 1, 0, c_white, 1);
}
else {
	if (place_meeting(x, y, oPlayerWorld) and !showprize) {
		draw_sprite(sFishIcon, sprite[1][0], p.x, p.y - 60);
	}
}
if (splash) {
    draw_sprite(sprite[2][1], sprite[2][0], pos[0], pos[1]);
}
if (showprize) {
	draw_sprite_ext(prize.sprite, 0, p.x, p.y - prizeoffset, 1, 1, 0, c_white, 1);
}
//draw_text(p.x, p.y - 10, $"caught:{caught}\nmostrecent:{input_check_press_most_recent()}\nsplash:{splash}\nsplashed:{splashed}");