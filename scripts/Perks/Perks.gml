
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
		//Amelia
		FpsMastery,
		TrashBear,//TODO: critical
		Bubba,//TODO: Everything
		HeavyArtillery,
		MoldySoul,
		SodaFueled,
		Lenght
	}
#endregion
function populate_perks(){
	#region Item Creation
		#region Character Perks
			#region Amelia Perks
				#region FPS Mastery
					create_perk({
						id : PerkIds.FpsMastery,
						name : "FPS Mastery",
						maxlevel : 3, 
						weight : 1,
						thumb : sFpsMastery,
						cooldown : 1,
						characterid : Characters.Uruka,
						bonus : true,
						bonustype : BonusType.Damage,
						bonusvalue : [1, 1.20, 1.40, 1.60]
					});
					//create_perk(PerkIds.FpsMastery, "FPS Mastery", 0, 3, 1, sFpsMastery, 1, "Do nothing.", Characters.Uruka);
					//create_perk(PerkIds.FpsMastery, "FPS Mastery", 1, 3, 1, sFpsMastery, 1, "Weapons deal [20%] more damage.", Characters.Uruka);
					//create_perk(PerkIds.FpsMastery, "FPS Mastery", 2, 3, 1, sFpsMastery, 1, "Weapons deal [40%] more damage.", Characters.Uruka);
					//create_perk(PerkIds.FpsMastery, "FPS Mastery", 3, 3, 1, sFpsMastery, 1, "Weapons deal [60%] more damage and fire [10%] faster.", Characters.Uruka);
				#endregion
				
				#region Detective Eye
				create_perk({
						id : PerkIds.TrashBear,
						name : "Trash Bear",
						maxlevel : 3, 
						weight : 1,
						thumb : sTrashBear,
						cooldown : 1,
						characterid : Characters.Uruka,
						bonus : true,
						bonustype : BonusType.Critical,
						bonusvalue : [0, 1.10, 1.20, 1.30]
					});
					//create_perk(PerkIds.TrashBear, "Detective Eye", 0, 3, 1, sTrashBear, 1, "Do nothing.", Characters.Uruka);
					//create_perk(PerkIds.TrashBear, "Detective Eye", 1, 3, 1, sTrashBear, 1, "Increases critical hit chance by [10%].", Characters.Uruka);
					//create_perk(PerkIds.TrashBear, "Detective Eye", 2, 3, 1, sTrashBear, 1, "Increases critical hit chance by [20%].", Characters.Uruka);
					//create_perk(PerkIds.TrashBear, "Detective Eye", 3, 3, 1, sTrashBear, 1, "Increases critical hit chance by [30%] with a [2%] chance to defeat a target in [1] hit.", Characters.Uruka);
				#endregion
				
				#region Bubba
				create_perk({
						id : PerkIds.Bubba,
						name : "Bubba",
						maxlevel : 3, 
						weight : 1,
						thumb : sBubba,
						cooldown : 1,
						characterid : Characters.Uruka,						
					});
					//create_perk(PerkIds.Bubba, "Bubba", 0, 3, 1, sBubba, 1, "Do nothing.", Characters.Uruka);
					//create_perk(PerkIds.Bubba, "Bubba", 1, 3, 1, sBubba, 1, "Gain a dog companion that attacks random targets, dealing [100%] of your base damage per hit.", Characters.Uruka);
					//create_perk(PerkIds.Bubba, "Bubba", 2, 3, 1, sBubba, 1, "Bubba deals [150%] of your base damage per hit.", Characters.Uruka);
					//create_perk(PerkIds.Bubba, "Bubba", 3, 3, 1, sBubba, 1, "Bubba deals [200%] of your base damage per hit and stuns targets for [2] seconds on hit.", Characters.Uruka);
				#endregion
				global.characterPerks[Characters.Uruka] = [PERK_LIST[PerkIds.FpsMastery][0], PERK_LIST[PerkIds.TrashBear][0], PERK_LIST[PerkIds.Bubba][0]];
			#endregion
	
			
			
			create_perk({
						id : PerkIds.HeavyArtillery,
						name : "Heavy Artillery",
						maxlevel : 3, 
						weight : 1,
						thumb : sHeavyArtillery,
						cooldown : [180, 180, 174, 174],
						characterid : Characters.Pippa,
						upgrade: true,
						upgradeid : Weapons.HeavyArtillery
					});
			//create_perk(PerkIds.HeavyArtillery, "Heavy Artillery", 0, 3, 1, spr_Pipmod_Pippa_Icon_Perk_HeavyArtillery, 180, "Do nothing.", Characters.Pippa);
			//create_perk(PerkIds.HeavyArtillery, "Heavy Artillery", 1, 3, 1, spr_Pipmod_Pippa_Icon_Perk_HeavyArtillery, 174, "Do nothing.", Characters.Pippa);
			//create_perk(PerkIds.HeavyArtillery, "Heavy Artillery", 2, 3, 1, spr_Pipmod_Pippa_Icon_Perk_HeavyArtillery, 174, "Do nothing.", Characters.Pippa);
			//create_perk(PerkIds.HeavyArtillery, "Heavy Artillery", 3, 3, 1, spr_Pipmod_Pippa_Icon_Perk_HeavyArtillery, 174, "Do nothing.", Characters.Pippa);
			create_perk({
						id : PerkIds.MoldySoul,
						name : "Moldy Soul",
						maxlevel : 3, 
						weight : 1,
						thumb : sMoldySoul,
						cooldown : 1,
						characterid : Characters.Pippa
					});
			//create_perk(PerkIds.MoldySoul, "Moldy Soul", 0, 1, 1, spr_Pipmod_Pippa_Icon_Perk_MoldySoul, 1, "Do nothing.", Characters.Pippa);
			//create_perk(PerkIds.MoldySoul, "Moldy Soul", 1, 1, 1, spr_Pipmod_Pippa_Icon_Perk_MoldySoul, 1, "Do nothing.", Characters.Pippa);
			create_perk({
						id : PerkIds.SodaFueled,
						name : "Soda Fueled",
						maxlevel : 3, 
						weight : 1,
						thumb : sSodaFueled,
						cooldown : 1,
						characterid : Characters.Pippa
					});
			//create_perk(PerkIds.SodaFueled, "Soda Fueled", 0, 1, 1, spr_Pipmod_Pippa_Icon_Perk_SodaFueled, 1, "Do nothing.", Characters.Pippa);
			//create_perk(PerkIds.SodaFueled, "Soda Fueled", 1, 1, 1, spr_Pipmod_Pippa_Icon_Perk_SodaFueled, 1, "Do nothing.", Characters.Pippa);
			global.characterPerks[Characters.Pippa] = [PERK_LIST[PerkIds.HeavyArtillery][0], PERK_LIST[PerkIds.MoldySoul][0], PERK_LIST[PerkIds.SodaFueled][0]];
			
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
				PerkBonuses[PLAYER_PERKS[i][$ "bonustype"]][PLAYER_PERKS[i][$ "id"]] = PLAYER_PERKS[i][$ "bonusvalue"];
			}
			if (variable_struct_exists(PLAYER_PERKS[i], "upgrade")) {
				instance_create_layer(x,y-8,"Upgrades",oUpgrade,{upg : global.upgradesAvaliable[PLAYER_PERKS[i][$ "upgradeid"]][PLAYER_PERKS[i][$ "level"]]});
			}
			//switch (PLAYER_PERKS[i][$ "id"]) {
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







