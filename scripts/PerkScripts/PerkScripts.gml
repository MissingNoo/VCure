function perk_ankh(o, event = WeaponEvent.Null){
	switch (o) {
	    case 1:
	    case 2:
	    case 3:
			if (!instance_exists(oMascot) and o > 0) {
			    instance_create_depth(oPlayer.x - 20, oPlayer.y - 20, oPlayer.depth, oMascot);
			}
			break;
	}
}
function trash_bear(level, event = WeaponEvent.Null, enemy = noone, xx = 0, yy = 0){
	var _spaghettiChance = irandom_range(0, 100);
	var dropChance = -1;
	switch (level) {
	    case 1:
	        dropChance = 3;
	        break;
	    case 2:
	        dropChance = 5;
	        break;
	    case 3:
	        dropChance = 7;
	        break;
	}
	if (_spaghettiChance <= dropChance) {
		if (enemy != noone) {
		    instance_create_depth(xx, yy, depth, oSpaghetti);
		}
	}
}
