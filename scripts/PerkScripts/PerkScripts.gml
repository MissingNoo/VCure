function perk_bubba(level, event = WeaponEvent.Null){
	switch (level) {
	    case 1:
			if (!instance_exists(oBubba)) {
			    instance_create_depth(oPlayer.x, oPlayer.y, oPlayer.depth, oBubba);
			}
	        oBubba.basespeed = 1;
	        break;
	    case 2:
	        oBubba.basespeed = 1.15;
	        break;
	    case 3:
	        oBubba.basespeed = 1.30;
	        break;
	}
}
function detective_eye(level, event = WeaponEvent.Null){
	switch (level) {
	    case 1:
	        // code here
	        break;
	    case 2:
	        // code here
	        break;
	    case 3:
	        if (event == WeaponEvent.PerkOnHit) {
			    var _chance = irandom_range(0, 100);
				show_debug_message($"Detective Eye rolled: {_chance}");
				if (_chance <= 2) {
					perkBonusDmg += 99999;
				}
			}
	        break;
			//TODO: A red "KO" appears on the screen when the Skill triggers.
	}
}
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
function perk_aromateraphy(o, event = WeaponEvent.Null){
	switch (o) {
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
		case WeaponEvent.PerkDraw:
			if (oPlayer.aromateraphy[0]) {
				if (!global.gamePaused) {
					oPlayer.aromateraphy[1] -= oPlayer.aromateraphy[4];
				}
			    draw_circle(oPlayer.x, oPlayer.y, oPlayer.aromateraphy[2], true);
			    draw_circle(oPlayer.x, oPlayer.y, oPlayer.aromateraphy[1], true);
			}
			break;
	}
	if (o > 0 and o < 100) {
		var _list = ds_list_create();
		var _num = collision_circle_list(oPlayer.x, oPlayer.y, oPlayer.aromateraphy[2], oEnemy, false, true, _list, false);
		if (_num > 0) {
		    for (var i = 0; i < _num; ++i;)
		    {
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
					    var _struc = copy_struct(Buffs[_debuff]);
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
}
function perk_mukirose(o, event = WeaponEvent.Null){
	switch (o) {
	    case 1:
			oPlayer.mukirose[0] = true;
			oPlayer.mukirose[1] = 50;
			oPlayer.mukirose[2] = .5;
			break;
	    case 2:
			oPlayer.mukirose[1] = 66;
			oPlayer.mukirose[2] = .75;
			break;
	    case 3:
			oPlayer.mukirose[1] = 75;
			oPlayer.mukirose[2] = 1;
			break;
	}
}
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
		if (_rnd <= _chance and upg.shotType == ShotTypes.Melee) {
			resetcooldown = true;
		}
	}
}
function living_weapon(level, event = WeaponEvent.Null){
	switch (event) {
	    case WeaponEvent.PerkOnKill:
			if (level > 0) {
			    add_buff_to_player(BuffNames.Sharpen);
			}
	        break;
	}
}
function trash_bear(level, event = WeaponEvent.Null, enemy = noone, xx = 0, yy = 0){
	var _spaghettiChance = irandom_range(0, 100);
	var dropChance = -1;
	switch (level) {
	    case 1:
	        dropChance = 10;
	        break;
	    case 2:
	        dropChance = 11;
	        break;
	    case 3:
	        dropChance = 12;
	        break;
	}
	if (_spaghettiChance <= dropChance) {
		if (enemy != noone) {
		    instance_create_depth(xx, yy, depth, oSpaghetti);
		}
	}
}
function heavy_artillery(level, event = WeaponEvent.Null, enemy = noone, xx = 0, yy = 0){
	if (event == WeaponEvent.PerkCooldown) {
	    instance_create_layer(oPlayer.x, oPlayer.y-8, "Upgrades", oUpgradeNew, {upg : global.upgradesAvaliable[Weapons.HeavyArtillery][level], shoots : 0});
	}
}