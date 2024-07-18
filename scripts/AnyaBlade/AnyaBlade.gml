function keris_create(obj){
	if (obj.shoots == -1) { exit; }
	switch (obj.upg.level) {
	    case 1:
	        obj.image_angle =  global.arrowDir;
	        break;
	    case 2:
	        var arrowdir = global.arrowDir;
			var _xx = obj.x + lengthdir_x(32, arrowdir + 90);
			var _yy = obj.y + lengthdir_y(32, arrowdir + 90);
			var _x2 = obj.x + lengthdir_x(obj.upg.range * 1.5, arrowdir - 0);
			var _y2 = obj.y + lengthdir_y(obj.upg.range * 1.5, arrowdir + 0);
			obj.image_angle =  point_direction(_xx, _yy, _x2, _y2);
			if (arrowdir > 90 and arrowdir > 270) {
			    obj.image_yscale = obj.image_yscale * -1;
			}
			var _xxx = obj.x;
			var _yyy = obj.y;
			obj.x = _xx;
			obj.y = _yy;
			
			_xx = _xxx + lengthdir_x(32, arrowdir - 90);
			_yy = _yyy + lengthdir_y(32, arrowdir - 90);
			_x2 = _xxx + lengthdir_x(obj.upg.range * 1.5, arrowdir - 0);
			_y2 = _yyy + lengthdir_y(obj.upg.range * 1.5, arrowdir + 0);
			var lastdir = point_direction(_xx, _yy, _x2, _y2);
			var yscale = obj.image_yscale * -1;
			//if (arrowdir > 90 and arrowdir > 270) {
			//    yscale = obj.image_yscale * -1;
			//}
			instance_create_layer(_xx, _yy-8, "Upgrades", oUpgradeNew, {upg : obj.upg, shoots : -1, image_angle : lastdir, image_yscale : yscale});
	        break;
	}
	
}
function keris_animation_end(obj) {
	
	//obj.animate = false;
}