var _cooldown =  Buffs[BuffNames.Soda].baseCooldown;
for (var i = 0; i < array_length(PLAYER_PERKS); ++i) {
    if (PLAYER_PERKS[i].id == PerkIds.MoldySoul) {
	    if (PLAYER_PERKS[i].level >= 2) {
			_cooldown = _cooldown * 3;
		}
	}
}
Buffs[BuffNames.Soda].cooldown = _cooldown;
Buffs[BuffNames.Soda].enabled = true;
food_item(3);