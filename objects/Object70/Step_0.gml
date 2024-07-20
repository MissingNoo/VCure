angle = point_direction(x,y, mouse_x, mouse_y);
lv += - keyboard_check_pressed(vk_pageup) + keyboard_check_pressed(vk_pagedown);
if (instance_exists(oPlayer)) {
    x = oPlayer.x;
	y = oPlayer.y - 8;
	angle = global.arrowDir;
	lv = UPGRADES[0].level;
}

//cooldown -= 1;
//if (cooldown < 0) {
//    cooldown = 60;
//	switch (lv) {
//	    case 1:
//	        instance_create_depth(x, y, oGui.depth-1, Object71, {image_angle : arrowdir});
//	        break;
//	    case 2:
//			arrowdir = point_direction(x,y, mouse_x, mouse_y);
//			angle = arrowdir;
//			var _xx = x + lengthdir_x(64, arrowdir + 90);
//			var _yy = y + lengthdir_y(64, arrowdir + 90);
//			var _x2 = x + lengthdir_x(256, arrowdir - 0);
//			var _y2 = y + lengthdir_y(256, arrowdir + 0);
//			var lastdir = point_direction(_xx, _yy, _x2, _y2);
//	        instance_create_depth(_xx, _yy, oGui.depth-1, Object71,{image_angle : lastdir, image_xscale : 2, image_yscale : 2});
//			_xx = x + lengthdir_x(64, arrowdir - 90);
//			_yy = y + lengthdir_y(64, arrowdir - 90);
//			_x2 = x + lengthdir_x(256, arrowdir - 0);
//			_y2 = y + lengthdir_y(256, arrowdir + 0);
//			lastdir = point_direction(_xx, _yy, _x2, _y2);
//	        instance_create_depth(_xx, _yy, oGui.depth-1, Object71,{image_angle : lastdir, image_xscale : 2, image_yscale : 2});
//	        break;
//	    default:
//	        // code here
//	        break;
//	}
//}