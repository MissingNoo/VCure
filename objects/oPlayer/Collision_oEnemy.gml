/// @instancevar {Any}  pimanBonus
#region Specials
#region Anya
var cooldownOver = false;
if (other.hittedcooldown[Weapons.AnyaBlade] < global.currentFrame) {
    cooldownOver = true;
}
if (NAME = "Anya Melfissa" and cooldownOver and !global.gamePaused and other.image_alpha == 1 and image_alpha == 1 and !other.infected and bladeForm) {
	other.hittedcooldown[Weapons.AnyaBlade] = global.currentFrame + BLADE_FORM_HIT_COOLDOWN;
	other.damaged = true;
	var _dmg = irandom_range(8, 12);
	other.hp -= _dmg;
	other.damagedAlarm = 15;
	damage_number_spawn(other, _dmg, false);
}
#endregion
#endregion
if (immortal or bladeForm) { exit; }
if (invencibilityFrames == 0 and other.canattack and other.image_alpha == 1 and image_alpha == 1 and !global.gamePaused and !other.infected) {
	invencibilityFrames = 3;
	other.canattack=false;
	//other.alarm[0]=25;
	other.canattackAlarm = 25;
	var damage = damage_calculation(other.atk);
	#region Perks
	#endregion
	
	if (pimanUsable) {
	    pimanUsable = false;
		var calc = (specialcooldown * pimanBonus) / 100;
		skilltimer += calc;
	}
	//damaged=true;
	audio_play_sound(snd_hurt,0,0, global.soundVolume);
	#region Uruka
	var bonusdmg = 0;
	var _dirtyDodge = irandom_range(1, 100);
	var _dirtyChance = 0;
	var hitby = other;
	for (var i = 0; i < array_length(PLAYER_PERKS); ++i) { 
		if (PLAYER_PERKS[i][$ "level"] > 0 and PLAYER_PERKS[i][$ "on_player_hit"] != undefined) {
		    var lastbonus = PLAYER_PERKS[i][$ "on_player_hit"]({
				level : PLAYER_PERKS[i][$ "level"],
				damage : damage,
				enemy : hitby
			});
			bonusdmg += lastbonus ?? 0;
		}
		switch (PLAYER_PERKS[i].id) {//TODO: change to "on_player_hit"
			case (PerkIds.WeakBones):
				switch (PLAYER_PERKS[i].level) {
					case 0:
						bonusdmg = 0;
						break;
					case 1:
						bonusdmg = 2;
						break;
					case 2:
						bonusdmg = 3;
						break;
					case 3:
						bonusdmg = 4;
						break;
					}
					if (PLAYER_PERKS[i][$ "level"] > 0 and !player_have_buff(BuffNames.RestNoteCooldown)) {
						add_buff_to_player(BuffNames.RestNoteCooldown);
					    var _angles = [0, 45, 315, 135, 180, 225];
						var _w = WEAPONS_LIST[Weapons.RestNote][1];
						for (var j = 0; j < array_length(_angles); ++j) {
							instance_create_layer(self.x, self.y-8,"Upgrades",oUpgradeNew,{
								upg : _w,
								owner : self,
								direction : _angles[j]
							});
						}
					}
					break;
			case (PerkIds.DirtyMind):
				_dirtyChance = PLAYER_PERKS[i][$ "dodgeChance"];
				break;
			}
		}
		//show_debug_message(string($"d:{damage} + {bonusdmg} = {damage+bonusdmg}"));
		damage += bonusdmg;
		if (_dirtyDodge <= _dirtyChance and global.player[? "name"] == "Fujikura Uruka") {
			heal_player(damage/2);
		    damage = 0;
		}
		#endregion
	if (Shield > 0) {
	    Shield -= damage;
	}
	else {
	    HP -= damage;
		if (haveBandage) {
			switch (bandageLevel) {
			    case 1:
			        justBandageHealing += damage * 0.8;
			        break;
			    case 2:
			        justBandageHealing += damage * 0.9;
			        break;
			    case 3:
			        justBandageHealing += damage;
			        break;
			}		    
		}
		if (player_have_buff(BuffNames.Sake)) {
			var buffpos = player_get_buff_pos(BuffNames.Sake);
			PlayerBuffs[buffpos][$ "count"] = round(PlayerBuffs[buffpos][$ "count"] / 2);
		}
	}
	//alarm[1]=60;
	var inst = instance_create_layer(x,y - sprite_get_height(sprite_index)/2,"DamageLayer",oDamageText);
	with (inst)	{
		/// @localvar {Any} dmg 
	    dmg = round(damage);
		depth = oPlayer.depth-1;
	}
	
	#region breastplate
	for (var i = 0; i < array_length(playerItems); ++i) {
		switch (playerItems[i][$ "id"]) {
			case ItemIds.Breastplate:
				var _chance = playerItems[i][$ "reflectChance"];
				var _random = irandom_range(1, 100);
				var _returnPercent = playerItems[i][$ "reflectDamage"];
				var _returnDamage = damage * _returnPercent;
				if (_random <= _chance) {
					other.hp -= _returnDamage;
					inst = instance_create_layer(other.x,other.y - sprite_get_height(other.sprite_index)/2,"DamageLayer",oDamageText);
					with (inst)
					{
						dmg=round(_returnDamage);
						depth = other.depth-1;
					}
				}
		        break;
			case ItemIds.NurseHorn:
				var _rnd = irandom_range(0, 100);
				var _hppercent = (HP/MAXHP) * 100;
				if (_hppercent <= 15 and _rnd <= 4) {
					var _percenttoheal = (MAXHP * 30) / 100;
				    heal_player(_percenttoheal);
				}
				break;
		    default:
		        // code here
		        break;
		}
	}
	#endregion
}