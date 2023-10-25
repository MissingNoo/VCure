//switch (upg[?"name"]) {
//default:
if (variable_struct_exists(upg, "afterimage") and upg[$ "afterimage"] and image_alpha == 1) {
	
//draw_sprite_ext(sprite_index, image_index-2, xpreviousprevious, ypreviousprevious, image_xscale, image_yscale, image_angle, upg[$ "afterimageColor"], .5);
//draw_sprite_ext(sprite_index, image_index-1, xprevious, yprevious, image_xscale, image_yscale, image_angle, upg[$ "afterimageColor"], .75);
	var _alpha = .1
	for (var i = 0; i < array_length(afterimage[0]); ++i) {
	    draw_sprite_ext(sprite_index, afterimage[2][i], afterimage[0][i], afterimage[1][i], image_xscale, image_yscale, image_angle, upg[$ "afterimageColor"], _alpha);
		_alpha += .10
	}
}


switch (upg[$ "id"]) {
	case Weapons.LiaBolt:{
		if (lightningTarget != noone and instance_exists(lightningTarget)) {
			var _newowner = variable_instance_exists(self, "newowner");
		    draw_lightning(!_newowner ? owner.x : startX, (!_newowner ? owner.y : startY) - (sprite_get_height(owner.sprite_index) / 2), lightningTarget.x, lightningTarget.y - (sprite_get_height(lightningTarget.sprite_index) / 2), false, lightningColor);
		}
		break;}
    case Weapons.SpiderCooking:
        draw_set_color(c_purple);
		draw_set_alpha(.35);
		draw_circle(x,y, (sprite_get_height(sprite_index)/2) * image_yscale,false);
		draw_set_alpha(1);
		draw_circle(x,y, (sprite_get_height(sprite_index)/2) * image_yscale,true);
		draw_set_color(c_white);
        break;
	case Weapons.EliteCooking:
		draw_set_color(c_purple);
		draw_set_alpha(0.20);
		draw_circle(x,y, (sprite_get_height(sprite_index)/2) * image_yscale / poolSize,false);
		draw_set_alpha(1);
		draw_set_color(c_white);
        break;
	case Weapons.ImDieExplosion:{
		var _alpha = 0.5;
		draw_sprite_ext(sprite_index, subImg, x, y, image_xscale, image_yscale, image_angle, c_white, _alpha);
		break;}
    default:
        draw_sprite_ext(sprite_index, subImg, x, y, image_xscale, image_yscale, image_angle, c_white, image_alpha);
        break;
}
if (upg[$ "id"] != Weapons.SpiderCooking) {
	
}
else{
	//image_xscale = image_yscale;
	//draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, c_white, .5);
	
}

if (global.debug) {
	if (upg[$ "id"] == Weapons.AbsoluteWall and variable_instance_exists(self, "wallNumber")) {
		draw_text(x + 20, y - 20, wallNumber);
	}
	if (upg[$ "id"] == Weapons.ENsCurse) {
		draw_circle(x,y, upg[$ "range"],true)
	}
	//draw_text(x, y - 20, upgID);
	//draw_text(x,y-30, string(alarm_get(1)));
	//draw_text(x,y-60, string(upg[?"duration"]));
	draw_text(x,y-30, string(direction));
	//draw_text(x,y-50, string(image_xscale));
	//draw_text(x,y-70, string(image_yscale));
	//draw_text(x,y-90, string(shoots));
	//draw_text(x,y-110, string($ "{subImg}/{maxImg}"));
}		
//		break
//}

