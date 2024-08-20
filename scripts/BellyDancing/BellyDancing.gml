function belly_dancing(level, event = WeaponEvent.Null){
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
