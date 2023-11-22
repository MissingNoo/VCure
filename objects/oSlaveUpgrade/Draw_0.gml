if (extraInfo[$ "afterimageColor"] != undefined) {
    var _alpha = .1
	for (var i = 0; i < array_length(afterimage[0]); ++i) {
		draw_sprite_ext(sprite_index, afterimage[2][i], afterimage[0][i], afterimage[1][i], image_xscale, image_yscale, image_angle, extraInfo.afterimageColor, _alpha);
		_alpha += .10
	}
}
image_xscale = extraInfo[$ "xscale"] == undefined ? 1 : extraInfo.xscale;
image_yscale = extraInfo[$ "yscale"] == undefined ? 1 : extraInfo.yscale;
switch (extraInfo.upg) {
	case Weapons.EliteLavaBucket:{
		if (extraInfo[$ "lx"] != undefined and x == extraInfo.lx) {
		    draw_self();
		}
		break;}
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
	case Weapons.EliteCooking:
		draw_set_color(c_purple);
		draw_set_alpha(0.20);
		draw_circle(x,y, (sprite_get_height(sprite_index)/2) * image_yscale / poolSize,false);
		draw_set_alpha(1);
		draw_set_color(c_white);
        break;
	default:
		draw_self();
		break;
}