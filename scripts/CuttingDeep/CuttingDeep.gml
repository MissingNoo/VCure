function cutting_deep(level, event = WeaponEvent.Null, upg = global.null){
	var _chance = -1;
	switch (level) {
	    case 1:
	        _chance = 15;
	        break;
	    case 2:
	        _chance = 20;
	        break;
	    case 3:
			_chance = 25;
	        break;
	}
	if (event == WeaponEvent.PerkOnHit and upg[$ "shotType"] != undefined) {
		var _rnd = irandom_range(0, 100);
		if (_rnd <= _chance and upg[$ "shotType"] == ShotTypes.Melee) {
			resetcooldown = true;
		}
	}
}
