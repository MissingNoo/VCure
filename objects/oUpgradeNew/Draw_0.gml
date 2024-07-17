if (upg[$ "draw"] != undefined) {
    upg.draw(self.id);
}
else {
	draw_sprite_ext(sprite_index, current_frame, x, y, image_xscale, image_yscale, image_angle, c_white, image_alpha);
}