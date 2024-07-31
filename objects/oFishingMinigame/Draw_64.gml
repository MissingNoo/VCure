if (caught) {
	if (!surface_exists(rhythmsurf)) {
		rhythmsurf = surface_create(sprite_get_width(sRhythmBar), sprite_get_height(sRhythmBar));
	}
	else {
		surface_set_target(rhythmsurf);
		draw_clear_alpha(c_black, 0);
		draw_sprite(sRhythmBar, 0, 0, 0);
		draw_sprite_ext(sRhythmButton, key, xx, sprite_get_height(sRhythmBar) / 2, scale, scale, 0, c_white, alpha);
		alpha -= 0.05;
		scale += 0.10;
		for (var i = array_length(keys) - 1; i >= 0 ; --i) {
			//var _color = c_white
			//if (keys[i].pos < 195) {
			//    _color = c_green;
			//}
			//if (keys[i].pos < 160) { // 140
			//    _color = c_yellow;
			//}
			//if (keys[i].pos > 195) {
			//    _color = c_red;
			//}
		    draw_sprite_ext(sRhythmButton, keys[i].spr, keys[i].pos, sprite_get_height(sRhythmBar) / 2, 1, 1, 0, c_white, 1);
			//draw_set_color(c_white);
		}
		surface_reset_target();
	    draw_surface_ext(rhythmsurf, GW/2 - surface_get_width(rhythmsurf) / 2, GH/2 + 50, 2, 2, 0, c_white, 1);
	}
}