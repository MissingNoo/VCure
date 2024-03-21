var canhit = true;
if (upg.mindmg == -1) {
    canhit = false;
}
switch (sprite_index) {
    case sBreathAsacoco:
        canhit = false;
        break;
}
var cooldownOver = false;
if (other.hittedcooldown[upg.id] < global.currentFrame) {
    cooldownOver = true;
}
if (cooldownOver and !global.gamePaused and other.image_alpha == 1 and image_alpha == 1 and ghost == false and canhit and !other.infected) {
	if (upg[$ "id"] == Weapons.BounceBall or upg[$ "id"] == Weapons.RingOfFitness) {
		var _push = 5;
		var _dir = point_direction(other.x, other.y, x, y);
		var _rnd = 0;
		do {
		    _rnd = irandom_range(-1,1);
		} until (_rnd != 0);
		var _hspd = lengthdir_x(_push, _dir)  * _rnd;
		var _vspd = lengthdir_y(_push, _dir); 
		 //x+=_hspd;
		 //y+=_vspd;
		 vspeed=_vspd;
		 hspeed = _hspd;
		 if (upg[$ "id"] == Weapons.RingOfFitness) { direction = point_direction(x, y, x + _hspd, y + _vspd); }		 
		 //if (alarm_get(11) == -1) {
		 //    alarm[11] = 20;
		 //}		 
	}
	var _hitCooldown = upg[$ "hitCooldown"];
	if (WEAPONS_LIST[upg.id][1].enchantment == Enchantments.HitRate) {
		_hitCooldown = _hitCooldown * 0.8;
		if (_hitCooldown < 5) {
		    _hitCooldown = 5;
		}
	}
	other.hittedcooldown[upg.id] = global.currentFrame + _hitCooldown;
	other.damaged = true;
	//random_set_seed(current_time);
	if (!variable_instance_exists(self, "mindmg")) { mindmg = 0; }	
	if (!variable_instance_exists(self, "maxdmg")) { maxdmg = 0; }
	var _bonusDamage = 0;
	if (upg[$ "bonusDamage"] != undefined) {
		//feather disable once GM1041
	    for (var i = 0; i < array_length(upg[$ "bonusDamage"]); ++i) {
		    _bonusDamage += upg[$ "bonusDamage"][i] / upg[$ "shoots"];
		}
		show_debug_message($"Base damage: {mindmg}/{maxdmg}, Bonus Damage: {_bonusDamage}");
	}
	var _mindmg = maxdmg + _bonusDamage;
	var _maxdmg = mindmg + _bonusDamage;
	var dmg = irandom_range(_mindmg, _maxdmg);
	audio_play_sound(choose(snd_hit1, snd_hit2, snd_hit3), 0, 0, .5);
	#region debuffs	
	for (var i = 0; i < array_length(PLAYER_PERKS); ++i) {
		if (variable_struct_exists(PLAYER_PERKS[i], "func")) {
			PLAYER_PERKS[i][$ "func"](99);
		}
		//#region Shark Bite
		//var found = false;
		//if (PLAYER_PERKS[i][$ "id"] == PerkIds.SharkBite and PLAYER_PERKS[i][$ "level"] > 0 and irandom_range(1,100) <= Buffs[BuffNames.SharkBite].chance[PLAYER_PERKS[i][$ "level"]]) {
		//	instance_create_layer(other.x, other.y, "Instances", oDebuffAnimation, {sprite_index : sSharkBiteAnimation});
		//	for (var j = 0; j < array_length(other.debuffs); ++j) {
		//		//if (other.debuffs[j].id == BuffNames.SharkBite) {
		//		//	found = true;
		//		//	if (other.debuffs[j].marks < other.debuffs[j].maxMarks) {
		//		//		other.debuffs[j].marks += 1;
		//		//	}
		//		//}
		//	}
		//	if (!found) {
		//		var _lv=0;
		//		for (var k = 0; k < array_length(PLAYER_PERKS); ++k) {
		//			if (PLAYER_PERKS[k][$ "id"] == PerkIds.SharkBite) {
		//				_lv = PLAYER_PERKS[k][$ "level"];
		//			}
		//		}
		//		Buffs[BuffNames.SharkBite].level = _lv;
		//		array_push(other.debuffs, copy_struct(Buffs[BuffNames.SharkBite]));
		//	}
		//}
		//#endregion
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
		    default:
		        // code here
		        break;
		}
	}
	#endregion
	
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
	
	for (var i = 0; i < array_length(other.debuffs); ++i) {
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
	if (global.player == CHARACTERS[Characters.Uruka]) {
	    for (var i = 0; i < array_length(PLAYER_PERKS); ++i) {
		    if (PLAYER_PERKS[i][$ "id"] == PerkIds.TrashBear and PLAYER_PERKS[i][$ "level"] == 3) {
				randomize();
				if (irandom_range(0, 100) <= 2) {
				    dmg = dmg * 999;
				}			    
			}
		}
	}
	//show_message(string(originalDamage) + "/" + string(dmg));
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
		if (global.player[?"id"] == Characters.Lia) {
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
		
		if (global.player[?"id"] == Characters.Pippa) {
			for (var i = 0; i < array_length(PLAYER_PERKS); ++i) {
			    if (PLAYER_PERKS[i].id == PerkIds.MoldySoul and PLAYER_PERKS[i].level >= 2) {
				    _rnd = irandom_range(1, 100);
					var _chance = PLAYER_PERKS[i].chance;
					if (_rnd <= _chance) {
					    instance_create_layer(x,y-8,"Upgrades",oUpgrade,{upg : global.upgradesAvaliable[PLAYER_PERKS[i][$ "upgradeid"]][1]});
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
			dmg = (dmg * 2) + (sizeGained / 10);
			break;}
	    default:
	        // code here
	        break;
	}
	#endregion
	if (variable_instance_exists(self, "applyDebuff")) {
		if (irandom_range(1, 100) <= applyDebuff[2]) {
			var _enemy = other;
			var _exist = false;
			var _pos = 0;
			for (var j = 0; j < array_length(_enemy.debuffs); ++j) {
				if (_enemy.debuffs[j].id == applyDebuff[0]) {
					_exist = true;
					_pos = j;
					break;
				}
			}
			if (_exist) {
			    _enemy.debuffs[_pos].cooldown = _enemy.debuffs[_pos].baseCooldown;
			}
			else {
			    var _struc = copy_struct(Buffs[applyDebuff[0]]);
				_struc.cooldown = _struc.baseCooldown;
				_struc.count = applyDebuff[1];
				array_push(_enemy.debuffs, _struc);
			}
		}
	}
	
	other.hp -= dmg;
	damage_number_spawn(other, dmg, _wasCrit, _virusInfected);
	//other.alarm[1]=15;
	other.damagedAlarm=15;
	if (variable_struct_exists(upg, "func")) {
	    upg[$ "func"](WeaponEvent.OnHit);
	}
	switch (upg[$ "id"]) {
	    case Weapons.UrukaNote:{
	        if (hits == 1 and upg.level == 7) {
				noteExplosion();
			}
	        break;}
		case Weapons.RestNote:{
				array_push(other.debuffs, copy_struct(Buffs[BuffNames.Paralyzed]));
				var _time = 0;
				for (var i = 0; i < array_length(PLAYER_PERKS); ++i) {
					if (PLAYER_PERKS[i].id == PerkIds.WeakBones) {
						_time = 2 + PLAYER_PERKS[i].level;
					}
				}
				for (var i = 0; i < array_length(other.debuffs); ++i) {
				    if (other.debuffs[i].id == BuffNames.Paralyzed) {
					    other.debuffs[i].enabled = true;
						//other.debuffs[i].cooldown = other.debuffs[i].baseCooldown;
						other.debuffs[i].cooldown = _time;
					}
				}
			break;}
		case Weapons.LiaBolt:{
			if (hits == 1) {
				hits = 999;
				speed = 0;
				mindmg = mindmg * 1.20;
				maxdmg = maxdmg * 1.20;
				sprite_index = sLiaBoltShock;
			}
			break;}
		case Weapons.ENsCurse:
			var chance = irandom_range(0, 100);
			if (chance < upg[$ "chance"]) {
				var near = collision_circle(x, y, upg[$ "range"], oEnemy, false, true);
			    if (distance_to_object(near) < upg[$ "range"]) {
				    hits = 2;
					image_angle = point_direction(x,y, near.x, near.y - 8);
					direction = point_direction(x,y, near.x, near.y - 8);
				}
				else{
					instance_destroy();
				}
			}			
			break;
		case Weapons.HoloBomb:
			image_xscale = originalSize[0];
			image_yscale = originalSize[1];
			sprite_index = sBombExplosion;
			level = upg[$ "level"];
				for (var i = 0; i < array_length(Bonuses[BonusType.WeaponSize]); ++i) {
					if (Bonuses[BonusType.WeaponSize][i] != 0) {
					    image_xscale = image_xscale * Bonuses[BonusType.WeaponSize][i];
						image_yscale = image_yscale * Bonuses[BonusType.WeaponSize][i];
					}			    
				}
				if (level >= 2 and level < 6) {
				    image_xscale = image_xscale * 1.15;
					image_yscale = image_yscale * 1.15;
				}
				if (level >= 6) {
				    image_xscale = image_xscale * 1.35;
					image_yscale = image_yscale * 1.35;
				}
			break;
		case Weapons.EldritchHorror:
			if (irandom_range(0, 100) <= 30) {
			    var _percent = irandom_range(0, 5);
				var _hp = round((other.baseHP * _percent) / 100);
				heal_player(_hp);
			}
			break;
		case Weapons.ImDie:{
			other.carryingBomb = true;
			break;}
	    default:
	        break;
	}
	hits-=1;
}