//var _offset = 0;
//for (var i = 0; i < array_length(dAlarm); ++i) {
//    draw_text(x, y - 10 - _offset, $"{i}: {dAlarm[i][0]}");
//	_offset += 10;
//}
//draw_text(x, y - 10 - _offset, $"{shoots}");
if (((variable_struct_exists(upg, "afterimage") and upg[$ "afterimage"]) or oPlayer.wallMart) and (image_alpha == 1 or image_alpha >= .9)) {
	var _alpha = .1;
	var _color = upg[$ "afterimageColor"] == undefined ? c_yellow : upg[$ "afterimageColor"];
	for (var i = 0; i < array_length(afterimage[0]); ++i) {
	    draw_sprite_ext(sprite_index, afterimage[2][i], afterimage[0][i], afterimage[1][i], image_xscale, image_yscale, afterimage[3][i], _color, _alpha);
		_alpha += .10
	}
}
if (upg[$ "draw"] != undefined) {
    upg.draw(self.id);
}
else {
	draw_sprite_ext(sprite_index, current_frame, x, y, image_xscale, image_yscale, image_angle, c_white, image_alpha);
}
if (upg[$ "post_draw"] != undefined) {
    upg.post_draw(self.id);
}
