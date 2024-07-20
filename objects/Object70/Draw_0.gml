DEBUG
    var pos = [];
	switch (lv) {
		case 1:
		    pos = [0];
		    break;
		case 2:
		case 3:
		case 4:
			pos = [32, -32];
		    break;
		case 5:
			pos = [60, 0, -60];
		    break;
		case 6:
		case 7:
			pos = [128, -128, 50, -50];
		    break;
	}
	keris_position(noone, pos, angle);
ENDDEBUG