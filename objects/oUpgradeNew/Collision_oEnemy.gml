var can_hit = true;
var sprites_cant_hit = [sBreathAsacoco];
if (global.gamePaused 
	or other.hittedcooldown[upg.id] > global.currentFrame 
	or array_get_index(sprites_cant_hit, sprite_index) != -1
	or other.image_alpha != 1
	or image_alpha != 1
	or ghost
	or other.infected) {
    exit;
}

var _hitCooldown = upg.hitCooldown;
if (WEAPONS_LIST[upg.id][1].enchantment == Enchantments.HitRate) {
	_hitCooldown = _hitCooldown * 0.8;
	if (_hitCooldown < 5) {
		_hitCooldown = 5;
	}
}
other.hittedcooldown[upg.id] = global.currentFrame + _hitCooldown;
other.damaged = true;

var _bonusDamage = 0;
if (upg[$ "bonusDamage"] != undefined) {
	//feather disable once GM1041
	for (var i = 0; i < array_length(upg[$ "bonusDamage"]); ++i) {
		_bonusDamage += upg.bonusDamage[i] / upg.shoots;
	}
	show_debug_message($"Base damage: {mindmg}/{maxdmg}, Bonus Damage: {_bonusDamage}");
}
var _mindmg = maxdmg + _bonusDamage;
var _maxdmg = mindmg + _bonusDamage;
var dmg = irandom_range(_mindmg, _maxdmg);
audio_play_sound(choose(snd_hit1, snd_hit2, snd_hit3), 0, 0, global.soundVolume);
for (var i = 0; i < array_length(PLAYER_PERKS); ++i) {
	if (variable_struct_exists(PLAYER_PERKS[i], "func")) {
		PLAYER_PERKS[i][$ "func"](PLAYER_PERKS[i][$ "level"], WeaponEvent.PerkOnHit, upg);
	}
}
if (perkBonusDmg == 99999 and other.boss) {
	perkBonusDmg = 0;
}
if (resetcooldown and !cooldownwasreset) {
	cooldownwasreset = true;
    other.hittedcooldown[upg.id] = global.currentFrame - 1;
}
dmg += perkBonusDmg;
for (var i = 0; i < array_length(playerItems); ++i) {
	switch (playerItems[i][$ "id"]) {
		case ItemIds.DevilHat:
			var _multiplier = playerItems[i][$ "damageMultiplier"];
		    if (point_distance(other.x, other.y, oPlayer.x, oPlayer.y) > 150) {
				dmg = dmg * _multiplier;
			}
			else{
				dmg = dmg * 0.90;
			}
		    break;
	}
}
	
var bdmg = 0;
for (var i = 0; i < array_length(Bonuses[BonusType.Damage]); ++i) {
	if (Bonuses[BonusType.Damage][i] != 0) {
		bdmg += (dmg * Bonuses[BonusType.Damage][i]) - dmg;
	}
}
	
for (var i = 0; i < array_length(PerkBonuses[BonusType.Damage]); ++i) {
	if (PerkBonuses[BonusType.Damage][i] != 0) {
		bdmg += (dmg * PerkBonuses[BonusType.Damage][i]) - dmg;
	}
}
	
for (var i = 0; i < array_length(other.debuffs); ++i) { //TODO: Debuffs
	//if (other.debuffs[i].id == BuffNames.SharkBite) {
	//	for (var j = 0; j < other.debuffs[i].marks; ++j) {
	//		bdmg += (dmg * other.debuffs[i].damage[other.debuffs[i].level]) - dmg;
	//	}
	//}
}
#region Shop atk bonus
for (var i = 0; i < global.shopUpgrades[$ "Atk"][$ "level"]; ++i) {
	bdmg = bdmg + ((bdmg * 6) / 100);
}
#endregion
dmg = dmg + bdmg;
var _rnd = irandom_range(0, 100);
var _critChance = oPlayer.critChance;
var _critMultiplier = 1;
var _wasCrit = false;
var _virusInfected = false;
if (_rnd <= _critChance) {
	_critMultiplier = 1.5;
	var _critCalc = 0;
	for (var i = 0; i < array_length(Bonuses[BonusType.CriticalDamage]); ++i) {
		if (Bonuses[BonusType.CriticalDamage][i] != 0) {
			_critCalc += real("0." + string(real(string_replace(string(Bonuses[BonusType.CriticalDamage][i]), "1.", ""))));
		}
	}
	if (WEAPONS_LIST[upg.id][1].enchantment == Enchantments.CritDamage) {
		_critCalc += .1;
	}
	_critMultiplier += _critCalc;
	_wasCrit = true;
	if (global.player[? "name"] == "Rinkou Ashelia") {
		for (var i = 0; i < array_length(PLAYER_PERKS); ++i) {
			if (PLAYER_PERKS[i].id == PerkIds.Viral) {
				var _infectChance = PLAYER_PERKS[i].chance;
				_rnd = irandom_range(1, 100);
				if (_rnd <= _infectChance and oPlayer.liaLikers < PLAYER_PERKS[i].maxInfected and !other.boss and !other.customSpawn) {
					other.infected = true;
					_virusInfected = true;
					//other.speed = other.speed * global.player[?"speed"];
					other.baseSPD = other.baseSPD* global.player[?"speed"];
					other.hp = other.baseHP;
					oPlayer.liaLikers += 1;
					dmg = 0;
				}				    
			}
		}
	}
		
	if (global.player[? "name"] == "Pipkin Pippa") {
		for (var i = 0; i < array_length(PLAYER_PERKS); ++i) {
			if (PLAYER_PERKS[i].id == PerkIds.MoldySoul and PLAYER_PERKS[i].level >= 2) {
				_rnd = irandom_range(1, 100);
				var _chance = PLAYER_PERKS[i].chance;
				if (_rnd <= _chance) {
					instance_create_layer(x,y-8,"Upgrades",oUpgradeNew,{upg : global.upgradesAvaliable[PLAYER_PERKS[i][$ "upgradeid"]][1]});
				}
			}
		}			
	}
}
dmg = dmg * global.player[?"atk"] * _critMultiplier;
if (oPlayer.spaghettiEaten) {
	dmg = dmg * 1.25;
}
dmg = dmg * other.damageMultFromDefDown;
#region Uruka Note Multiplier
//the whole note hits 3 targets, half hits 5, quarter hits 7, and 1/8th has unlimited pierce (explosion for the first three would just happen when they reach their pierce limit or hit the edge of screen)
switch (sprite_index) {
	case sFullNote:
	    break;
	case sHalfNote:
		dmg = dmg / 2;
	    break;
	case sQuarterNote:
		dmg = dmg / 4;
	    break;
	case sEightNote:
		dmg = dmg / 8;
	    break;
	case sBombExplosion:{
		dmg = (dmg * 2);// + (sizeGained / 10);
		break;}
}
#endregion
other.hp -= dmg;
damage_number_spawn(other, dmg, _wasCrit, _virusInfected);
other.damagedAlarm=15;
hits-=1;
if (hits <= 0) {
    image_alpha = 0;
}
if (upg[$ "on_hit"] != undefined) {
	upg.on_hit(self.id);
}
//switch (upg[$ "id"]) {
//    case Weapons.UrukaNote:{
//        if (hits == 1 and upg.level == 7) {
//			noteExplosion();
//		}
//        break;}
//	case Weapons.RestNote:{
//			array_push(other.debuffs, copy_struct(Buffs[BuffNames.Paralyzed]));
//			var _time = 0;
//			for (var i = 0; i < array_length(PLAYER_PERKS); ++i) {
//				if (PLAYER_PERKS[i].id == PerkIds.WeakBones) {
//					_time = 2 + PLAYER_PERKS[i].level;
//				}
//			}
//			for (var i = 0; i < array_length(other.debuffs); ++i) {
//			    if (other.debuffs[i].id == BuffNames.Paralyzed) {
//				    other.debuffs[i].enabled = true;
//					//other.debuffs[i].cooldown = other.debuffs[i].baseCooldown;
//					other.debuffs[i].cooldown = _time;
//				}
//			}
//		break;}
//	case Weapons.LiaBolt:{
//		if (hits == 1) {
//			hits = 999;
//			speed = 0;
//			mindmg = mindmg * 1.20;
//			maxdmg = maxdmg * 1.20;
//			sprite_index = sLiaBoltShock;
//		}
//		break;}
//	case Weapons.ENsCurse:
//		var chance = irandom_range(0, 100);
//		if (chance < upg[$ "chance"]) {
//			//feather disable once GM1041
//			var near = collision_circle(x, y, upg[$ "range"], oEnemy, false, true);
//		    if (distance_to_object(near) < upg[$ "range"]) {
//			    hits = 2;
//				image_angle = point_direction(x,y, near.x, near.y - 8);
//				direction = point_direction(x,y, near.x, near.y - 8);
//			}
//			else{
//				instance_destroy();
//			}
//		}			
//		break;
//	case Weapons.HoloBomb:
//		image_xscale = originalSize[0];
//		image_yscale = originalSize[1];
//		sprite_index = sBombExplosion;
//		level = upg[$ "level"];
//			for (var i = 0; i < array_length(Bonuses[BonusType.WeaponSize]); ++i) {
//				if (Bonuses[BonusType.WeaponSize][i] != 0) {
//				    image_xscale = image_xscale * Bonuses[BonusType.WeaponSize][i];
//					image_yscale = image_yscale * Bonuses[BonusType.WeaponSize][i];
//				}			    
//			}
//			if (level >= 2 and level < 6) {
//			    image_xscale = image_xscale * 1.15;
//				image_yscale = image_yscale * 1.15;
//			}
//			if (level >= 6) {
//			    image_xscale = image_xscale * 1.35;
//				image_yscale = image_yscale * 1.35;
//			}
//		break;
//	case Weapons.EldritchHorror:
//		if (irandom_range(0, 100) <= 30) {
//		    var _percent = irandom_range(0, 5);
//			var _hp = round((other.baseHP * _percent) / 100);
//			heal_player(_hp);
//		}
//		break;
//	case Weapons.ImDie:{
//		other.carryingBomb = true;
//		break;}
//    default:
//        break;
//}