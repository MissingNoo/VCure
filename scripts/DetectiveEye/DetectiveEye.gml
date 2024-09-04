function detective_eye_on_hit(data = {level : 0, upg : -1, enemy : noone}) {
	switch (data.level) {
	    case 1:
	        // code here
	        break;
	    case 2:
	        // code here
	        break;
	    case 3:
			var _chance = irandom_range(0, 100);
			show_debug_message($"Detective Eye rolled: {_chance}");
			if (_chance <= 2) {
				return 99999;
			}
	        break;
	}
}