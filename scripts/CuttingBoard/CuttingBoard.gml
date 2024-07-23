function cutting_board_create(obj){
	if (global.player[? "flat"]) {
		obj.image_xscale = obj.image_xscale * 1.30;
		obj.image_yscale = obj.image_yscale * 1.30;
		obj.mindmg = obj.mindmg * 1.30;
		obj.maxdmg = obj.maxdmg * 1.30;
	}
	obj.speed = obj.upg[$ "speed"];
	obj.diroffset = 0;
	if (obj.shoots == -1) {
	    switch (obj.remaining_shoots) {
		    case 2:
		        obj.diroffset = -90;
		        break;
		    case 1:
		        obj.diroffset = 90;
		        break;
		}
	}
	obj.direction = obj.arrowDir + 180 + obj.diroffset;
	obj.image_angle = obj.arrowDir + obj.diroffset;
}
function cutting_board_step(obj){
	if (distance_to_point(obj.xstart, obj.ystart) > 5) {
		obj.speed -= .30 * Delta;
		if (obj.speed < 0) {
			obj.speed = 0;
		}
	}
}