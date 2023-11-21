if (!instance_exists(oPlayer)) { exit; }
for (var i = 0; i < array_length(clouds); ++i) {
    draw_sprite_ext(sCloud, clouds[i][3], clouds[i][0], clouds[i][1], 1, 1, 0, c_black, 0.25);
    //draw_text(clouds[i][0], clouds[i][1], clouds[i][2]);
	//draw_line(oPlayer.x, oPlayer.y, clouds[i][0], clouds[i][1]);
}