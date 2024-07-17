function blbook_step(){
	x = owner.x + lengthdir_x(orbitLength, round(orbitPlace));
	y = owner.y - 16 + lengthdir_y(orbitLength, round(orbitPlace));
	orbitPlace-=spinningSpeed;
}
function blbook_begin_step(){
	orbitLength = upg[$ "orbitLength"];
	spinningSpeed = upg[$ "spinningSpeed"];
	if (shoots > 0) {	
		switch (upg[$ "level"]) {
			case 1:
				orbitoffset = -120;
				break;
			case 2:
				orbitoffset = -90;
				break;
			case 3:
				orbitoffset = -90;
				break;
			case 4:
				orbitoffset = -80;
				break;
			case 5:
				orbitoffset = -80;
				break;
			case 6:
				orbitoffset = -60;
				break;
			case 7:
				orbitoffset = -60;
				break;
		}
	}
	
}