#macro PLAYER_PERKS global.perks
#macro PERK_LIST global.perkList
global.perks=[0];
global.perkCooldown[0] = 0;
global.perkBonuses[0] = 0;
#region Null item
	global.nullperk={};
	variable_struct_set(global.nullperk, "name", "");
	global.perkList=[0];
#endregion

#region Item Functions
function create_perk(_data){
	for (var i = 0; i <= _data.maxlevel; ++i) {
		PERK_LIST[_data.id][i]={};
		var m = PERK_LIST[_data.id][i];
		variable_struct_set(m, "level" ,i);
		var keys = variable_struct_get_names(_data);
		for (var j = array_length(keys)-1; j >= 0; --j) {
		    var k = keys[j];
		    var v = _data[$ k];
			if (is_array(v)) {
			    if (array_length(v) > 1) {
				    variable_struct_set(m, k, v[i]);
				}
				else
				{
					variable_struct_set(m, k, v[0]);
				}   
			}else{
				variable_struct_set(m, k, v);
			}
		}
		variable_struct_set(m, "perk", 1);
		variable_struct_set(m, "style", ItemTypes.Perk);
		//show_message(_data.cooldown);
		global.perkCooldown[_data.id] = 0;
		//show_message(global.perkCooldown[_data.id]);
	}
}

	enum PerkIds
	{
		Null,
		DirtyMind,
		TrashBear,
		WeakBones,
		Lick,
		Viral, 
		EletricPulse,
		HeavyArtillery,
		MoldySoul,
		SodaFueled,
		Ankh,
		FpsMastery,
		DetectiveEye,
		Bubba,
		BellyDancing,
		Mukirose,
		Aromatherapy,
		CuttingDeep,
		LivingWeapon,
		Slumber,
		Lenght
	}
#endregion
function populate_perks(){
	#region PerkCreation
		create_perk({
			id : PerkIds.Null,
			name : "",
			maxlevel : 1, 
			weight : 0,
			thumb : sCharacterLockedIcon,
			cooldown : 1,
			characterid : Characters.Null,
		});
		global.characterPerks[Characters.Tenma] = [PERK_LIST[PerkIds.Null][0], PERK_LIST[PerkIds.Null][0], PERK_LIST[PerkIds.Null][0]];
		#region Character Perks
		#region Uruka Perks
		#region Dirty Mind
		create_perk({
			id : PerkIds.DirtyMind,
			name : "Dirty Mind",
			maxlevel : 3, 
			weight : 1,
			thumb : sDirtyMind,
			cooldown : 1,
			characterid : Characters.Uruka,
			dodgeChance: [0, 15, 20, 25]
		});
		#endregion
		#region Trash Bear
		create_perk({
			id : PerkIds.TrashBear,
			name : "Trash Bear",
			maxlevel : 3, 
			weight : 1,
			thumb : sTrashBear,
			cooldown : 1,
			characterid : Characters.Uruka,
			dropChance : [0, 10, 11, 12],
			spdDebuff : [0, 0.85, 0.80, 0.75]
		});
		#endregion
		#region WeakBones
		create_perk({
			id : PerkIds.WeakBones,
			name : "Brittle Bones",
			maxlevel : 3, 
			weight : 1,
			thumb : sWeakBones,
			cooldown : 1,
			characterid : Characters.Uruka,						
		});
		#endregion
		global.characterPerks[Characters.Uruka] = [PERK_LIST[PerkIds.DirtyMind][0], PERK_LIST[PerkIds.TrashBear][0], PERK_LIST[PerkIds.WeakBones][0]];
		#endregion
		#region Lia
		#region EletricPulse
		create_perk({
			id : PerkIds.EletricPulse,
			name : "Power Strike",
			maxlevel : 3, 
			weight : 1,
			thumb : sEletricPulseThumb,
			cooldown : [0, 10, 8, 6],
			characterid : Characters.Lia,
			upgrade : true,
			upgradeid : Weapons.ElectricPulse,
		});
		#endregion
		#region Lick
		create_perk({
			id : PerkIds.Lick,
			name : "Lick",
			maxlevel : 3, 
			weight : 1,
			thumb : sLick,
			cooldown : [0, 5, 4, 3],
			characterid : Characters.Lia,
			lickArea : [0, 60, 90, 120]
		});
		#endregion
		#region EletricPulse
		create_perk({
			id : PerkIds.Viral,
			name : "Viral",
			maxlevel : 3, 
			weight : 1,
			thumb : sViral,
			cooldown : 1,
			characterid : Characters.Lia,
			chance : [0, 20, 27, 33],
			maxInfected : [0, 5, 10, 15]
		});
		#endregion
		global.characterPerks[Characters.Lia] = [PERK_LIST[PerkIds.EletricPulse][0], PERK_LIST[PerkIds.Viral][0], PERK_LIST[PerkIds.Lick][0]];
		#endregion
		#region Pippa
		create_perk({
			id : PerkIds.HeavyArtillery,
			name : "Heavy Artillery",
			maxlevel : 3, 
			weight : 1,
			thumb : sHeavyArtillery,
			cooldown : [3, 3, 2.01, 2.01],
			characterid : Characters.Pippa,
			upgrade: true,
			upgradeid : Weapons.HeavyArtillery
		});
		create_perk({
			id : PerkIds.MoldySoul,
			name : "Moldy Soul",
			maxlevel : 3, 
			weight : 1,
			thumb : sMoldySoul,
			cooldown : 1,
			characterid : Characters.Pippa,
			upgradeid : Weapons.Mold,
			chance : 33
		});
		create_perk({
			id : PerkIds.SodaFueled,
			name : "Soda Fueled",
			maxlevel : 3, 
			weight : 1,
			thumb : sSodaFueled,
			cooldown : 1,
			characterid : Characters.Pippa
		});
		global.characterPerks[Characters.Pippa] = [PERK_LIST[PerkIds.HeavyArtillery][0], PERK_LIST[PerkIds.MoldySoul][0], PERK_LIST[PerkIds.SodaFueled][0]];
		#endregion
		#region Hololive
		#region Amelia
		create_perk({
			id : PerkIds.FpsMastery,
			name : "FPS Mastery",
			maxlevel : 3, 
			weight : 1,
			thumb : sAmeliaFpsMastery,
			cooldown : [3, 3, 2.01, 2.01],
			bonus : true,
			//bonusType : [BonusType.Damage, BonusType.Haste],
			bonusType : BonusType.Damage,
			//bonusValue : [[0, 1.20, 1.40, 1.60], [0, 0, 0, 1.10]],
			bonusValue : [0, 1.20, 1.40, 1.60],
			//TODO: attack 10% faster
			characterid : Characters.Amelia
		});
		create_perk({
			id : PerkIds.DetectiveEye,
			func : detective_eye,
			name : "Detective Eye",
			maxlevel : 3, 
			weight : 1,
			thumb : sAmeliaDetectiveEye,
			cooldown : [3, 3, 2.01, 2.01],
			characterid : Characters.Amelia,
			bonus : true,
			bonusType : BonusType.Critical,
			bonusValue : [0, 1.10, 1.20, 1.30]
		});
		create_perk({
			id : PerkIds.Bubba,
			func : perk_bubba,
			name : "Bubba",
			maxlevel : 3, 
			weight : 1,
			thumb : sAmeliaBubba,
			cooldown : [3, 3, 2.01, 2.01],
			characterid : Characters.Amelia
		});
		global.characterPerks[Characters.Amelia] = [PERK_LIST[PerkIds.FpsMastery][0], PERK_LIST[PerkIds.DetectiveEye][0], PERK_LIST[PerkIds.Bubba][0]];
		#endregion
		#region Aki
		create_perk({
			id : PerkIds.BellyDancing,
			func : belly_dancing,
			name : "Belly Dancing",
			maxlevel : 3, 
			weight : 1,
			thumb : sAkiPerk2,
			cooldown : 1,
			characterid : Characters.Aki
		});
		create_perk({
			func : perk_mukirose,
			id : PerkIds.Mukirose,
			name : "Mukirose",
			maxlevel : 3, 
			weight : 1,
			thumb : sAkiPerk3,
			cooldown : [3, 3, 2.01, 2.01],
			characterid : Characters.Aki
		});
		create_perk({
			func : perk_aromateraphy,
			id : PerkIds.Aromatherapy,
			name : "Aromatherapy",
			maxlevel : 3, 
			weight : 1,
			thumb : sAkiPerk1,
			cooldown : 1.5,
			characterid : Characters.Aki,
			draw : true
		});
		global.characterPerks[Characters.Aki] = [PERK_LIST[PerkIds.BellyDancing][0], PERK_LIST[PerkIds.Mukirose][0], PERK_LIST[PerkIds.Aromatherapy][0]];
		#endregion
		#region Anya
		create_perk({
			func : cutting_deep,
			id : PerkIds.CuttingDeep,
			name : "Cutting Deep",
			maxlevel : 3,
			weight : 3,
			thumb : sAnyaPerk1,
			cooldown : [1, 1, 1, 1],
			characterid : Characters.Anya,
			bonus : true,
			bonusType : BonusType.PickupRange,
			bonusValue : [0, 1.20, 1.40, 1.60],
		});
		create_perk({ id : PerkIds.LivingWeapon, name : "Living Weapon", maxlevel : 3, weight : 3, thumb : sAnyaPerk2, cooldown : [1, 1, 1, 1], characterid : Characters.Anya});
		create_perk({ id : PerkIds.Slumber, name : "Slumber", maxlevel : 3, weight : 3, thumb : sAnyaPerk3, cooldown : [1, 1, 1, 1], characterid : Characters.Anya});
		global.characterPerks[Characters.Anya] = [PERK_LIST[PerkIds.CuttingDeep][0], PERK_LIST[PerkIds.LivingWeapon][0], PERK_LIST[PerkIds.Slumber][0]];
		#endregion
		#endregion
		#region Indies
		#region Trickywi
		create_perk({
			id : PerkIds.Ankh,
			func : perk_ankh,
			name : "Ankh",
			maxlevel : 3, 
			weight : 1,
			thumb : sTrickyAnkh,
			cooldown : 1,
			characterid : Characters.Trickywi
		});
		global.characterPerks[Characters.Trickywi] = [PERK_LIST[PerkIds.Ankh][0], PERK_LIST[PerkIds.Null][0], PERK_LIST[PerkIds.Null][0]];
		#endregion
		#endregion
		#endregion
	#endregion
}

function tick_perks()
{
	//feather disable once GM2041
	for (var i = 0; i < array_length(PLAYER_PERKS); ++i) {
		if (PLAYER_PERKS[i][$ "level"] != 0 and global.perkCooldown[PLAYER_PERKS[i][$ "id"]] <= 0) {
			default_perk_behaviour(PLAYER_PERKS[i][$ "id"], PLAYER_PERKS[i][$ "cooldown"]);
			if (variable_struct_exists(PLAYER_PERKS[i], "bonus")) {
				PerkBonuses[PLAYER_PERKS[i][$ "bonusType"]][PLAYER_PERKS[i][$ "id"]] = PLAYER_PERKS[i][$ "bonusValue"];
			}
			if (variable_struct_exists(PLAYER_PERKS[i], "upgrade")) {
				instance_create_layer(x,y-8,"Upgrades",oUpgrade,{upg : global.upgradesAvaliable[PLAYER_PERKS[i][$ "upgradeid"]][PLAYER_PERKS[i][$ "level"]]});
			}
			if (variable_struct_exists(PLAYER_PERKS[i], "func")) {
			    PLAYER_PERKS[i][$ "func"](PLAYER_PERKS[i][$ "level"]);
			}
			switch (PLAYER_PERKS[i][$ "id"]) {
				case PerkIds.Lick:{
					var _list = ds_list_create();
					var _y = oPlayer.y - (sprite_get_height(global.player[?"sprite"]) / 3);
					var _num = collision_circle_list(oPlayer.x, _y, PLAYER_PERKS[i].lickArea, oEnemy, false, true, _list, false);
					for (var j = 0; j < _num; ++j) {
						var _heal = ceil(MAXHP/100);
					    heal_player(_heal);
						show_debug_message("healed:" + string(_heal));
					}
					ds_list_destroy(_list);
					break;}
			}
			//	case PerkIds.FpsMastery:{
			//			switch (PLAYER_PERKS[i][$ "level"]) {
			//			    case 1:
			//			        PerkBonuses[BonusType.Damage][PerkIds.FpsMastery] = 1.20;
			//			        break;
			//			    case 2:
			//			        PerkBonuses[BonusType.Damage][PerkIds.FpsMastery] = 1.40;
			//			        break;
			//				case 3:
			//			        PerkBonuses[BonusType.Damage][PerkIds.FpsMastery] = 1.60;
			//			        break;
			//			}						
			//		break;}
			//	case PerkIds.TrashBear:{
			//			switch (PLAYER_PERKS[i][$ "level"]) {
			//			    case 1:
			//			        PerkBonuses[BonusType.Critical][PerkIds.TrashBear] = 1.10;
			//			        break;
			//			    case 2:
			//			        PerkBonuses[BonusType.Critical][PerkIds.TrashBear] = 1.20;
			//			        break;
			//				case 3:
			//			        PerkBonuses[BonusType.Critical][PerkIds.TrashBear] = 1.30;
			//			        break;
			//			}						
			//		break;}
			//	case PerkIds.Bubba:{
			//			switch (PLAYER_PERKS[i][$ "level"]) {
			//			    case 1:
			//			        PerkBonuses[BonusType.Bubba] = global.player[?"atk"];
			//			        break;
			//			    case 2:
			//			        PerkBonuses[BonusType.Bubba] = global.player[?"atk"]*1.50;
			//			        break;
			//				case 3:
			//			        PerkBonuses[BonusType.Bubba] = global.player[?"atk"]*2;
			//			        break;
			//			}						
			//		break;}
			//	case PerkIds.PowerofAtlantis:{
			//			switch (PLAYER_PERKS[i][$ "level"]) {
			//			    case 1:{
			//					inst = (instance_create_layer(x,y-8,"Upgrades",oUpgrade));
			//					inst.upg=global.upgradesAvaliable[Weapons.PowerofAtlantis][1];
			//					//show_message(string(global.upgradesAvaliable[Weapons.PowerofAtlantis][1][?"duration"]))
			//					inst.speed=0;
			//					inst.mindmg = UPGRADES[0][$ "mindmg"] * 0.3;
			//					inst.maxdmg = UPGRADES[0][$ "maxdmg"] * 0.3;
			//					inst.hits=999;
			//					inst.shoots = 1;
			//					inst.sprite_index=global.upgradesAvaliable[Weapons.PowerofAtlantis][1][$ "sprite"];
			//			        break;}
			//			    case 2:{
			//					inst = (instance_create_layer(x,y-8,"Upgrades",oUpgrade));
			//					inst.upg=global.upgradesAvaliable[Weapons.PowerofAtlantis][1];
			//					inst.speed=0;
			//					inst.mindmg = UPGRADES[0][$ "mindmg"] * 0.4;
			//					inst.maxdmg = UPGRADES[0][$ "maxdmg"] * 0.4;
			//					inst.hits=999;
			//					inst.shoots = 2;
			//					inst.sprite_index=global.upgradesAvaliable[Weapons.PowerofAtlantis][1][$ "sprite"];
			//			        break;}
			//				case 3:{
			//					inst = (instance_create_layer(x,y-8,"Upgrades",oUpgrade));
			//					inst.upg=global.upgradesAvaliable[Weapons.PowerofAtlantis][1];
			//					inst.speed=0;
			//					inst.mindmg = UPGRADES[0][$ "mindmg"] * 0.5;
			//					inst.maxdmg = UPGRADES[0][$ "maxdmg"] * 0.5;
			//					inst.hits=999;
			//					inst.shoots = 3;
			//					inst.sprite_index=global.upgradesAvaliable[Weapons.PowerofAtlantis][1][$ "sprite"];
			//			        break;}
			//			}						
			//		break;}
			//		case PerkIds.HeavyArtillery:{
			//			instance_create_layer(x,y-8,"Upgrades",oUpgrade,{upg : global.upgradesAvaliable[Weapons.HeavyArtillery][PLAYER_PERKS[i][$ "level"]]});
			//			//switch (PLAYER_PERKS[i][$ "level"]) {
			//			//    case 1:{
			//			//		inst = (instance_create_layer(x,y-8,"Upgrades",oUpgrade));
			//			//		inst.upg=global.upgradesAvaliable[Weapons.HeavyArtillery][1];
			//			//		//show_message(string(global.upgradesAvaliable[Weapons.HeavyArtillery][1][?"duration"]))
			//			//		inst.speed=0;
			//			//		inst.mindmg = (UPGRADES[0][$ "mindmg"] * 333)/100;
			//			//		inst.maxdmg = (UPGRADES[0][$ "maxdmg"] * 333)/100;
			//			//		inst.hits=999;
			//			//		inst.shoots = 1;
			//			//		inst.sprite_index=global.upgradesAvaliable[Weapons.HeavyArtillery][1][$ "sprite"];
			//			//        break;}
			//			//    case 2:{
			//			//		inst = (instance_create_layer(x,y-8,"Upgrades",oUpgrade));
			//			//		inst.upg=global.upgradesAvaliable[Weapons.HeavyArtillery][2];
			//			//		inst.speed=0;
			//			//		inst.mindmg = (UPGRADES[0][$ "mindmg"] * 333)/100;
			//			//		inst.maxdmg = (UPGRADES[0][$ "maxdmg"] * 333)/100;
			//			//		inst.hits=999;
			//			//		inst.shoots = 1;
			//			//		inst.sprite_index=global.upgradesAvaliable[Weapons.HeavyArtillery][1][$ "sprite"];
			//			//        break;}
			//			//	case 3:{
			//			//		inst = (instance_create_layer(x,y-8,"Upgrades",oUpgrade));
			//			//		inst.upg=global.upgradesAvaliable[Weapons.HeavyArtillery][3];
			//			//		inst.speed=0;
			//			//		inst.mindmg = (UPGRADES[0][$ "mindmg"] * 333)/100;
			//			//		inst.maxdmg = (UPGRADES[0][$ "maxdmg"] * 333)/100;
			//			//		inst.hits=999;
			//			//		inst.shoots = 2;
			//			//		inst.sprite_index=global.upgradesAvaliable[Weapons.HeavyArtillery][1][$ "sprite"];
			//			//        break;}
			//			//}						
			//		break;}
			//}
		}
	}
}

function default_perk_behaviour(_id, _cooldown){
	global.perkCooldown[_id] = _cooldown;
}