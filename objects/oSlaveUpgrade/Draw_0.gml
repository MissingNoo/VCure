if (haveafterimage) {
    var _alpha = .1
	for (var i = 0; i < array_length(afterimage[0]); ++i) {
		draw_sprite_ext(sprite_index, afterimage[2][i], afterimage[0][i], afterimage[1][i], image_xscale, image_yscale, image_angle, extraInfo.afterimageColor, _alpha);
		_alpha += .10
	}
}
image_xscale = extraInfo.xscale;
image_yscale = extraInfo.yscale;
switch (extraInfo.upg) {
	case Weapons.LiaBolt:
		if (x == xstart and y == ystart) {
			break;
		}
		draw_lightning(xstart, ystart, x, y, false, extraInfo.lightningColor);
		//draw_lightning(extraInfo.startX, extraInfo.startY, x, y, false, extraInfo.lightningColor);
		break;
	case Weapons.SpiderCooking:
        draw_spider_cooking();
		break;
	default:
		draw_self();
		break;
}