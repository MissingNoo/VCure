function perk_aromateraphy_on_cooldown(data = {level : 0, upg : -1, enemy : noone}) {
	switch (data.level) {
	    case 1:
			oPlayer.aromateraphy[0] = true;
			oPlayer.aromateraphy[1] = 100;
			oPlayer.aromateraphy[2] = 100;
			oPlayer.aromateraphy[3] = 15;
			oPlayer.aromateraphy[4] = 1.10;
			break;
	    case 2:
			oPlayer.aromateraphy[1] = 125;
			oPlayer.aromateraphy[2] = 125;
			oPlayer.aromateraphy[3] = 25;
			oPlayer.aromateraphy[4] = 1.35;
			break;
	    case 3:
			oPlayer.aromateraphy[1] = 150;
			oPlayer.aromateraphy[2] = 150;
			oPlayer.aromateraphy[3] = 35;
			oPlayer.aromateraphy[4] = 1.65;
			break;
	}
	var _list = ds_list_create();
	var _num = collision_circle_list(oPlayer.x, oPlayer.y, oPlayer.aromateraphy[2], oEnemy, false, true, _list, false);
	if (_num > 0) {
		for (var i = 0; i < _num; ++i) {
			var _enemy = _list[| i];
			var _chance = irandom_range(0, 100);
			if (_chance <= oPlayer.aromateraphy[3]) {
				var _debuff = choose(BuffNames.AtkDown, BuffNames.SpdDown, BuffNames.DefDown);
				var _exist = false;
				var _pos = 0;
				for (var j = 0; j < array_length(_enemy.debuffs); ++j) {
					if (_enemy.debuffs[j].id == _debuff) {
						_exist = true;
						_pos = j;
					}
				}
				if (!_exist) {
					var _struc = { baseCooldown : 0 };
					_struc = copy_struct(Buffs[_debuff]);						
					_struc.cooldown = _struc.baseCooldown;
					_struc.count = 1;
					array_push(_enemy.debuffs, _struc);
				}
				else {
					if (_enemy.debuffs[_pos].count < _enemy.debuffs[_pos].maxCount) {
						_enemy.debuffs[_pos].count += 1;
					}
				}
				if (oPlayer.mukirose[0]) {
					var _mukiChance = irandom_range(0, 100);
					if (_mukiChance <= oPlayer.mukirose[1]) {
						var _amount = array_length(_enemy.debuffs);
						var _damage = irandom_range(UPGRADES[0][$ "mindmg"], UPGRADES[0][$ "maxdmg"]);
						var _multiplier = oPlayer.mukirose[2];
						var _totalDamage = (_damage * _multiplier) * _amount;
						damage_number_spawn(_enemy, _totalDamage, false);
						_enemy.hp -= _totalDamage;
					}
				}					
			}
		}
	}
}

function perk_aromatherapy_draw() {
	if (oPlayer.aromateraphy[0]) {
		if (!global.gamePaused) {
			oPlayer.aromateraphy[1] -= oPlayer.aromateraphy[4];
		}
		draw_circle(oPlayer.x, oPlayer.y, oPlayer.aromateraphy[2], true);
		draw_circle(oPlayer.x, oPlayer.y, oPlayer.aromateraphy[1], true);
	}
}
