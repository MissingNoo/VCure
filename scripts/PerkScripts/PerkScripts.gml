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