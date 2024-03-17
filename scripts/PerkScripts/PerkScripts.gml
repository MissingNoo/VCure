function detective_eye(level){
	switch (level) {
	    case 1:
	        // code here
	        break;
	    case 2:
	        // code here
	        break;
	    case 3:
	        // code here
	        break;
		case WeaponEvent.PerkOnHit:
			var _chance = irandom_range(0, 100);
			if (_chance <= 2) {
				perkBonusDmg += 99999;
			}			
			break;
	}
}
function belly_dancing(level){
	if (level > 0 and level < 4) {
	    Buffs[BuffNames.BellyDance][$ "enabled"] = true;
	}
	switch (level) {
	    case 1:
			Buffs[BuffNames.BellyDance][$ "level"] = 0.20;
	        break;
	    case 2:
	        Buffs[BuffNames.BellyDance][$ "level"] = 0.30;
	        break;
	    case 3:
	        Buffs[BuffNames.BellyDance][$ "level"] = 0.40;
	        break;
	}
}