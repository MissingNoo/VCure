function living_weapon_on_cooldown(data = {level : 0}) {
	add_buff_to_player(BuffNames.Sharpen);
	var pos = player_get_buff_pos(BuffNames.Sharpen);
	if (PlayerBuffs[pos][$ "count"] < 10) {
	    instance_destroy(oSharpenAura);
	}
	else if (!instance_exists(oSharpenAura)) {
		instance_create_depth(oPlayer.x, oPlayer.y, oPlayer.depth - 1, oSharpenAura);
	}
	if (instance_exists(oSharpenAura)) {
	    oSharpenAura.level = data.level;
	}
	var bonus = 0;
	for (var i = 1; i <= PlayerBuffs[pos][$ "count"] ; ++i) {
	    if (i % 10 == 0) {
			switch (data.level) {
			    case 1:
			        bonus += 4;
			        break;
			    case 2:
			        bonus += 5;
			        break;
			    case 3:
			        bonus += 8;
			        break;
			}
		}
	}
	PerkBonuses[BonusType.Damage][PerkIds.LivingWeapon] = bonus;
}

function perk_living_weapon_on_kill() {
	var _chance = 50;
	if (irandom(100) <= _chance) {
	    player_buff_add_count(BuffNames.Sharpen, 1, 50);
	}
}

function perk_living_weapon_on_player_hit(data = {level : 0, enemy : noone}) {
	if (oPlayer.bladeForm) { exit; }
	player_buff_add_count(BuffNames.Sharpen, -5, 50);
}

function perk_living_weapon_draw() {
}