function living_weapon_on_cooldown(data = {level : 0}) {
	add_buff_to_player(BuffNames.Sharpen);
	var pos = player_get_buff_pos(BuffNames.Sharpen);
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
	var pos = player_get_buff_pos(BuffNames.Sharpen);
	var _dmg = irandom_range(UPGRADES[0][$ "mindmg"], UPGRADES[0][$ "maxdmg"]);
	var percent = 1;
	switch (data.level) {
	    case 1:
	        percent = 40;
	        break;
	    case 2:
	        percent = 50;
	        break;
	    case 3:
	        percent = 60;
	        break;
	}
	var final_dmg = 0;
	for (var i = 1; i <= PlayerBuffs[pos][$ "count"] ; ++i) {
	    if (i % 10 == 0) {
			final_dmg += (_dmg * percent) / 100;
		}
	}
	data.enemy.damaged = true;
	data.enemy.hp -= final_dmg;
	data.enemy.damagedAlarm = 15;
	damage_number_spawn(data.enemy, final_dmg, false);
	player_buff_add_count(BuffNames.Sharpen, -5, 50);
}

function perk_living_weapon_draw() {
	var pos = player_get_buff_pos(BuffNames.Sharpen);
	if (PlayerBuffs[pos][$ "count"] >= 10) {
	    draw_sprite_ext(sAnyaSharpAura, -1, oPlayer.x, oPlayer.y - 12, 1.20, 1.20, 0, c_white, 0.35);
	}
}