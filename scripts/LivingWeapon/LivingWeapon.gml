function living_weapon(level, event = WeaponEvent.Null){
	switch (event) {
	    case WeaponEvent.PerkOnKill:
			if (level > 0) {
			    add_buff_to_player(BuffNames.Sharpen);
			}
	        break;
	}
}
