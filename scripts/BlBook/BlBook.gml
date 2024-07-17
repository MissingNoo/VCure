function blbook_step(obj){
	obj.x = obj.owner.x + lengthdir_x(obj.orbitLength, round(obj.orbitPlace));
	obj.y = obj.owner.y - 16 + lengthdir_y(obj.orbitLength, round(obj.orbitPlace));
	obj.orbitPlace -= obj.upg[$ "spinningSpeed"];
}
function blbook_create(obj){
	obj.orbitLength = obj.upg[$ "orbitLength"];
	obj.spinningSpeed = obj.upg[$ "spinningSpeed"];
	if (obj.shoots > 0) {
		switch (obj.upg[$ "level"]) {
			case 1:
				obj.orbitoffset = -120;
				break;
			case 2:
				obj.orbitoffset = -90;
				break;
			case 3:
				obj.orbitoffset = -90;
				break;
			case 4:
				obj.orbitoffset = -80;
				break;
			case 5:
				obj.orbitoffset = -80;
				break;
			case 6:
				obj.orbitoffset = -60;
				break;
			case 7:
				obj.orbitoffset = -60;
				break;
		}
	}
	obj.x = obj.owner.x + lengthdir_x(obj.orbitLength, round(obj.orbitPlace));
	obj.y = obj.owner.y - 16 + lengthdir_y(obj.orbitLength, round(obj.orbitPlace));
	obj.orbitPlace -= obj.upg[$ "spinningSpeed"];
}