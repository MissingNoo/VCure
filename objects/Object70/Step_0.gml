lv += - input_check_pressed("up") + input_check_pressed("down");
cooldown -= 1;
var arrowdir = point_direction(x,y, mouse_x, mouse_y);
if (cooldown < 0) {
    cooldown = 60;
	switch (lv) {
	    case 1:
	        instance_create_depth(x, y, oGui.depth-1, Object71, {image_angle : arrowdir});
	        break;
	    case 2:
			arrowdir = point_direction(x,y, mouse_x, mouse_y);
			angle = arrowdir;
			var _xx = x + lengthdir_x(64, arrowdir + 90);
			var _yy = y + lengthdir_y(64, arrowdir + 90);
			var _x2 = x + lengthdir_x(256, arrowdir - 0);
			var _y2 = y + lengthdir_y(256, arrowdir + 0);
			var lastdir = point_direction(_xx, _yy, _x2, _y2);
	        instance_create_depth(_xx, _yy, oGui.depth-1, Object71,{image_angle : lastdir, image_xscale : 2, image_yscale : 2});
			_xx = x + lengthdir_x(64, arrowdir - 90);
			_yy = y + lengthdir_y(64, arrowdir - 90);
			_x2 = x + lengthdir_x(256, arrowdir - 0);
			_y2 = y + lengthdir_y(256, arrowdir + 0);
			lastdir = point_direction(_xx, _yy, _x2, _y2);
	        instance_create_depth(_xx, _yy, oGui.depth-1, Object71,{image_angle : lastdir, image_xscale : 2, image_yscale : 2});
	        break;
	    default:
	        // code here
	        break;
	}
}