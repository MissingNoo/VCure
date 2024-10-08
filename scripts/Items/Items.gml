// Feather disable GM2017
#macro playerItems global.items
#macro ItemList global.itemList
global.upgrade=false;
global.items=[0];
global.itemCooldown[0] = 0;
#region Null item
	global.nullitem={};
	var item = global.nullitem;
		variable_struct_set(item, "id", -1);
		variable_struct_set(item, "name", "");
		variable_struct_set(item, "level", 1);
		variable_struct_set(item, "maxlevel", 1);
		variable_struct_set(item, "weight", 1);
		variable_struct_set(item, "thumb", sBlank);
		variable_struct_set(item, "cooldown", 1);
		variable_struct_set(item, "desc", "null");
		variable_struct_set(item, "unlocked", true);
		variable_struct_set(item, "type", "white");
		variable_struct_set(item, "perk", 0);
		variable_struct_set(item, "style", ItemTypes.Item);
	global.itemList=[0];
#endregion

#region Item Functions
function new_create_item(_data){
	ItemList[_data.id][0] = global.nullitem;	
	for (var i = 1; i <= _data.maxlevel; ++i) {
		ItemList[_data.id][i] = {};
		var m = ItemList[_data.id][i];		
		variable_struct_set(m, "level", i);
		//variable_struct_set(m, "desc", lexicon_text("Items." + _data.name + "." + string(i)));
		variable_struct_set(m, "style", ItemTypes.Item);
		variable_struct_set(m, "type", "yellow");
		var keys = variable_struct_get_names(_data);
		for (var j = array_length(keys)-1; j >= 0; --j) {
		    var k = keys[j];
			if (k == "bonusType") { 
				variable_struct_set(m, "bonusType", _data.bonusType);
			}
			else if (k == "bonusValue"){
				variable_struct_set(m, "bonusValue", _data.bonusValue);
			}
			else{
			    var v = _data[$ k];
				if (is_array(v)) {
				    if (array_length(v) > 1) {
					    variable_struct_set(m, k, v[i-1]);
					}
					else
					{
						variable_struct_set(m, k, v[0]);
					}
				}else{
					variable_struct_set(m, k, v);
				}
			}
		}
		if (variable_struct_exists(_data, "bonusType") and variable_struct_exists(_data, "bonusValue")) {
		    
		}		
		global.itemCooldown[_data.id] = 0;
	}
}
	function createItem(_id, _name, _level, _maxLevel, _weight, _sprite, _cooldown, _desc, _unlocked = true, _type = "yellow", _perk = 0)
	{
		ItemList[_id][0]=global.nullitem;
		ItemList[_id][_level]={};
		var item = ItemList[_id][_level];
		variable_struct_set(item, "id", _id);
		variable_struct_set(item, "name", _name);
		variable_struct_set(item, "level", _level);
		variable_struct_set(item, "maxlevel", _maxLevel);
		variable_struct_set(item, "weight", _weight);
		variable_struct_set(item, "thumb", _sprite);
		variable_struct_set(item, "cooldown", _cooldown);
		variable_struct_set(item, "desc", _desc);
		variable_struct_set(item, "unlocked", _unlocked);
		variable_struct_set(item, "type", _type);
		variable_struct_set(item, "perk", _perk);
		variable_struct_set(item, "style", ItemTypes.Item);
		global.itemCooldown[_id] = _cooldown;
	}

	enum ItemIds{
		BlacksmithsGear, //TODO: enhancement
		Body_Pillow,
		Breastplate,
		Chicken_Feather,
		CreditCard,
		DevilHat,
		Energy_Drink,
		Face_Mask,
		FullMeal,
		GorillaPaw, 
		GWS_Pill, 
		Halu,//TODO: add all effects
		Headphones,
		Hope_Soda,
		Idol_Costume,
		Injection_Type_Asacoco,
		Just_Bandage, //TODO: add regen effect
		Knightly_Milk,
		Limiter,
		Membership,
		NurseHorn,
		Piki_Piki_Piman,
		Plushie, //TODO: add all effects
		Sake,
		Stolen_Piggy_Bank,
		StudyGlasses, 
		Super_Chatto_Time,
		UberSheep,
		Holocoin,
		Hamburguer,
		Length,
		MoldySoulBonus,
		Soda,
		MaxLength
	}
	global.bonuses[0] = 0;
	for (var i = 0; i < ItemIds.MaxLength; ++i) {
		for (var j = 0; j < BonusType.Lenght; ++j) {
		    Bonuses[i][j] = 0;
		}
	}
	Bonuses[BonusType.Critical][ItemIds.MoldySoulBonus] = 1;
	Bonuses[BonusType.Critical][ItemIds.Sake] = [0,0];
	
	enum BonusType{
		Damage,
		Critical, //TODO
		CriticalDamage, //TODO
		TakeDamage,
		Defense,
		Haste,
		Speed,
		ChickenFeather,
		EnergyDrinkHpMinus,
		Healing,
		WeaponSize,
		WeakBones,
		UberSheep,
		PickupRange,
		XPBonus,
		AnvilDrop,
		EnhancingCost,
		SuperChattoTime,
		Lenght
	}
#endregion

function populate_items(){
	#region Item Creation
		#region Items
			new_create_item({//Blacksmith's Gear
				id : ItemIds.BlacksmithsGear,
				name : "Blacksmith's Gear",
				maxlevel : 3,
				weight : 1,
				thumb : sBlacksmithGear,
				cooldown : 1,
				perk : false,
			});
			#region BodyPillow
			new_create_item({
				id : ItemIds.Body_Pillow,
				name : "Body Pillow",
				maxlevel : 5,
				weight : 3,
				thumb : sBodyPillow,
				cooldown : 15,
				perk : false,
				bonusType : BonusType.Defense,
				bonusValue : [10, 10, 10, 10, 10],
				shield : [15, 20, 25, 30, 35],
			});
			#endregion
			new_create_item({//Breasplate
				id : ItemIds.Breastplate,
				name : "Breastplate",
				maxlevel : 3,
				weight : 2,
				thumb : sBreastplate,
				cooldown : 1,
				bonusType : [BonusType.Defense, BonusType.Speed],
				bonusValue : [[25, 25, 25],[-10, -10, -10]],
				reflectChance : [50, 60, 70],
				reflectDamage : [2, 2.5, 3],
				perk : false});			
			new_create_item({//Devil Hat
				id : ItemIds.DevilHat,
				name : "Devil Hat",
				maxlevel : 3,
				weight : 2,
				thumb : sDevilHat,
				cooldown : 1,
				damageMultiplier : [1.2, 1.4, 1.6],
				perk : false});
			#region Holocoin
			
			new_create_item({
				id : ItemIds.Holocoin,
				name : "Holocoin",
				maxlevel : 1,
				weight : 0,
				thumb : sPhaseCoin,
				cooldown : 15,
				desc : [
				"Gain 50 Holocoins.",
				],
				perk : true,
				characterid : 99,
			});
			#endregion
			
			#region Hamburger
			new_create_item({
				id : ItemIds.Hamburguer,
				name : "Hamburguer",
				maxlevel : 1,
				weight : 0,
				thumb : sHamburger,
				cooldown : 15,
				desc : [
				"Recover 10 Health.",
				],
				perk : true,
				characterid : 99,
			});
			#endregion
		
			#region Chicken's Feather
			new_create_item({
				id : ItemIds.Chicken_Feather,
				name : "Chicken's Feather",
				maxlevel : 3,
				weight : 2,
				thumb : sChickenFeather,
				cooldown : 1,
				perk : false});				
				Bonuses[BonusType.ChickenFeather] = 0;
			#endregion
			
			#region Credit Card
			new_create_item(
			{
				id : ItemIds.CreditCard,
				name : "Credit Card",
				maxlevel : 5,
				weight : 4,
				thumb : sCreditCard,
				cooldown : 1,
				perk : false,
				bonusType : [BonusType.AnvilDrop, BonusType.EnhancingCost],
				bonusValue : [[.18, .28, .38, .45, .5], [20, 25, 30, 35, 40]],
			}
			);
			//Bonuses[BonusType.AnvilDrop][ItemIds.CreditCard] = 0;
			//Bonuses[BonusType.EnhancingCost][ItemIds.CreditCard] = 0;
			#endregion
		
			#region GWS Pill 
			new_create_item({
				id : ItemIds.GWS_Pill,
				name : "GWS Pill",
				maxlevel : 3,
				weight : 2,
				thumb : sGWSPill,
				cooldown : 1,
				crit : [15, 20, 25],
				perk : false});
			#endregion
			
			#region Just Bandage 
			new_create_item({
				id : ItemIds.Just_Bandage,
				name : "Just Bandage",
				maxlevel : 3,
				weight : 4,
				thumb : sJustBandage,
				cooldown : 1,
				perk : false});
			#endregion
			
			#region Limiter
			new_create_item({
				id : ItemIds.Limiter,
				name : "Limiter",
				maxlevel : 3,
				weight : 4,
				thumb : sLimiter,
				cooldown : 1,
				bonusType : BonusType.PickupRange,
				bonusValue : [100, 200, 300],
				perk : false});
				//Bonuses[BonusType.PickupRange][ItemIds.Limiter] = 0;
			#endregion
			
			#region Super Chatto Time
			new_create_item({
				id : ItemIds.Super_Chatto_Time,
				name : "Super Chatto Time",
				maxlevel : 5,
				weight : 2,
				thumb : sSuperChattoTime,
				cooldown : 1,
				perk : false,
				bonusType : BonusType.SuperChattoTime,
				bonusValue : [20, 40, 60, 80, 100]
			});
			Bonuses[BonusType.SuperChattoTime][0] = 0;
			#endregion
			
			#region Stolen Piggy Bank
			new_create_item({
				id : ItemIds.Stolen_Piggy_Bank,
				name : "Stolen Piggy Bank",
				maxlevel : 1,
				weight : 2,
				thumb : sStolenPiggyBank,
				cooldown : 1,
				perk : false});
			#endregion
		
			#region Sake
			new_create_item({
				func : sake_tick,
				id : ItemIds.Sake,
				name : "Sake",
				maxlevel : 3,
				weight : 4,
				thumb : sSake,
				cooldown : 1,
				bonus : [10, 15, 20],
				perk : false});
			#endregion
			
			#region Plushie
			new_create_item({
				id : ItemIds.Plushie,
				name : "Plushie",
				maxlevel : 3,
				weight : 3,
				thumb : sPlushie,
				cooldown : 1,
				perk : false});
			#endregion
			
			#region Piki Piki Piman
			new_create_item({
				id : ItemIds.Piki_Piki_Piman,
				name : "Piki Piki Piman",
				maxlevel : 3,
				weight : 4,
				thumb : sPikiPikiPiman,
				cooldown : 0.2,
				bonus : [15, 20, 25],
				bonusPercentage: [2, 3, 4],
				perk : false});
			#endregion
			
			#region Membership
			new_create_item({
				id : ItemIds.Membership,
				name : "Membership",
				maxlevel : 3,
				weight : 3,
				thumb : sMembership,
				cooldown : 1,
				bonusATK : [30, 40, 50],
				bonusLessDamage : [10, 18, 25],
				perk : false});
			#endregion
			
			#region Halu 
			new_create_item({
				id : ItemIds.Halu,
				name : "Halu",
				maxlevel : 5,
				weight : 3,
				thumb : sHalu,
				cooldown : 1,
				perk : false});
				/*
				Each upgrade adds 2 to the enemy spawn rate, resulting in an increase in the effective spawn rate of new enemies by between 15% to 70% of the base spawn rate at most times, depending on how long the player is into the game. Each upgrade also buffs the HP, ATK, and SPD of each enemy by 10%/15%/20%/25%/30% (incorrect tooltip), depending on the upgrade level. When Halu is selected or upgraded, the buff is immediately applied to future spawns and all enemies on screen that have not been damaged.
				HoloCoin bonus only affects enemies that were defeated after Halu was first selected; however, the number of coins gained is applied retroactively to this total using the coin per kill rate of the item's upgrade level when the stage ends. Although not listed in the item description, level 4 grants the player 1 HoloCoin for every 2 targets defeated since taking the item, and level 5 gains 1 HoloCoin for every target defeated since taking the item. The amount of coins gained from Halu is only affected by the stage coin multiplier. 
				*/
			#endregion
		
			new_create_item({
				id : ItemIds.Hope_Soda,
				name : "Hope Soda",
				maxlevel : 5,
				weight : 2,
				thumb : sHopeSoda,
				cooldown : 1,
				bonusType : BonusType.CriticalDamage,
				bonusValue : [1.10, 1.20, 1.30, 1.40, 1.50],
				perk : false,
				SpecialCooldown: [1.25, 1.25, 1.25, 1.25, 1.25],
				}
			);
			//Bonuses[BonusType.CriticalDamage][ItemIds.Hope_Soda] = 0;
		
			#region Idol Costume
				new_create_item({
					id : ItemIds.Idol_Costume,
					name : "Idol Costume",
					maxlevel : 5,
					weight : 1,
					thumb : sIdolCostume,
					cooldown : 1,
					perk : false,
					SpecialCooldown: [0.80, 0.75, 0.70, 0.65, 0.60],
				}
				);
			#endregion
		
			#region Energy Drink
			new_create_item({
				id : ItemIds.Energy_Drink,
				name : "Energy Drink",
				maxlevel : 3,
				weight : 3,
				thumb : sEnergyDrink,
				cooldown : 1,
				bonusType : [BonusType.Haste, BonusType.Speed],
				bonusValue : [[10, 15, 20], [30, 40, 50]],
				perk : false});
				Bonuses[BonusType.EnergyDrinkHpMinus] = 0;
			#endregion
		
			#region Face Mask
			new_create_item({
				id : ItemIds.Face_Mask,
				name : "Face Mask",
				maxlevel : 1,
				weight : 1,
				thumb : sFaceMask,
				cooldown : 1,
				bonusType : [BonusType.Damage, BonusType.Haste, BonusType.TakeDamage],
				bonusValue : [[30],[10],[30]],
				perk : false});
			#endregion
		
			#region Full Meal
			new_create_item({
				id : ItemIds.FullMeal,
				name : "Full Meal",
				maxlevel : 1,
				weight : 1,
				thumb : sFullMeal,
				cooldown : 1,
				perk : false});
				Bonuses[BonusType.Healing][ItemIds.FullMeal] = 1;
			#endregion
		
			#region Gorilla's Paw
			new_create_item({
				id : ItemIds.GorillaPaw,
				name : "GorillasPaw",
				maxlevel : 3,
				weight : 3,
				thumb : sGorillaPaw,
				cooldown : 1,				
				perk : false,
				bonusType : [BonusType.Damage, BonusType.Critical],
				bonusValue : [[20, 30, 40], [-2, -2, -2]],
				unlocked : false,
			});
			#endregion
			
			#region Headphones
			new_create_item({
				id : ItemIds.Headphones,
				name : "Headphones",
				maxlevel : 5,
				weight : 4,
				thumb : sHeadPhones,
				cooldown : 1,
				perk : false,
				dodgeChance: [15, 20, 25, 30, 35]
			});
			#endregion
		
			#region Injection Type Asacoco
			new_create_item({
				id : ItemIds.Injection_Type_Asacoco,
				name : "InjectionAsacoco",
				maxlevel : 3,
				weight : 2,
				thumb : sInjectionAsacoco,
				cooldown : 1,
				perk : false,
				bonusType : BonusType.Damage,
				bonusValue : [40, 60, 80],
			});
			#endregion
		
			#region Knightly Milk
			new_create_item({
				id : ItemIds.Knightly_Milk,
				name : "Holy Milk",
				maxlevel : 3,
				weight : 1,
				thumb : sKnightlyMilk,
				cooldown : 1,
				perk : false,
				bonusType : [BonusType.WeaponSize, BonusType.PickupRange],
				bonusValue : [[10, 15, 20], [30, 40, 50]],
			});				
				//Bonuses[BonusType.WeaponSize][ItemIds.Knightly_Milk] = 1;
				//Bonuses[BonusType.PickupRange][ItemIds.Knightly_Milk] = 0;
			#endregion
		
			#region Nurse's Horn
			new_create_item({
				id : ItemIds.NurseHorn,
				name : "SuccubusHorn",
				maxlevel : 3,
				weight : 3,
				thumb : sNurseHorn,
				cooldown : 1,
				perk : false});
			#endregion		
			
			#region Study Glasses
			new_create_item(
			{
				id : ItemIds.StudyGlasses,
				name : "Study Glasses",
				maxlevel : 5,
				weight : 3,
				thumb : sStudyGlasses,
				cooldown : 1,
				perk : false,
				bonusType : BonusType.XPBonus,
				bonusValue : [1.10, 1.15, 1.20, 1.25, 1.30],
				unlocked : false
			}
			);
			//Bonuses[BonusType.XPBonus][ItemIds.Study_Glasses] = 0;
			#endregion
		
			#region UberSheep
			new_create_item({
				id : ItemIds.UberSheep,
				name : "Uber Sheep",
				maxlevel : 5,
				weight : 4,
				thumb : sUberSheep,
				cooldown : [10, 9, 8, 7, 6],
				perk : false,
				bonusType : BonusType.UberSheep,
				bonusValue : [1.10, 1.12, 1.15, 1.18, 1.20],
			});
				Bonuses[BonusType.UberSheep][ItemIds.UberSheep] = 1;
			#endregion
		
			#endregion
	#endregion
}

function tick_items(){
	var _player = instance_find(oPlayer, 0);
	for (var i = 0; i < array_length(playerItems); ++i) {
		if (playerItems[i] != global.nullitem and global.itemCooldown[playerItems[i][$ "id"]] <= 0) {
			defaultItemBehaviour(playerItems[i][$ "id"], playerItems[i][$ "cooldown"]);
			if (variable_struct_exists(playerItems[i], "bonusType")) {
				if (is_array(playerItems[i][$ "bonusType"])) {
					for (var j = 0; j < array_length(playerItems[i][$ "bonusType"]); ++j) {
					    Bonuses[playerItems[i][$ "bonusType"][j]][playerItems[i][$ "id"]] = playerItems[i][$ "bonusValue"][j][playerItems[i][$ "level"] -1];
					}				    
				}
				else{
					Bonuses[playerItems[i][$ "bonusType"]][playerItems[i][$ "id"]] = playerItems[i][$ "bonusValue"][playerItems[i][$ "level"] -1];
				}			    
			}
			if (playerItems[i][$ "func"] != undefined) {
				playerItems[i][$ "func"]();
			}
		    switch (playerItems[i][$ "id"]) { //TODO: separate in scripts
				case ItemIds.Body_Pillow:
					Shield = playerItems[i][$ "shield"];
					MaxShield = playerItems[i][$ "shield"];
					break;
				case ItemIds.Chicken_Feather:
					if (playerItems[i][$ "level"] != Bonuses[BonusType.ChickenFeather]) {
						Bonuses[BonusType.ChickenFeather] = playerItems[i][$ "level"];
						oPlayer.revives +=1 ;
					}
					break;
				case ItemIds.Energy_Drink:
					switch (playerItems[i][$ "level"]) {
					    case 1:
							if (Bonuses[BonusType.EnergyDrinkHpMinus] == 0) {
							    Bonuses[BonusType.EnergyDrinkHpMinus] = 1;
								MAXHP = MAXHP * 0.80;
							}
					        break;
					    case 2:
							if (Bonuses[BonusType.EnergyDrinkHpMinus] == 1) {
							    Bonuses[BonusType.EnergyDrinkHpMinus] = 2;
								MAXHP = MAXHP * 0.80;
							}
					        break;
						case 3:
							if (Bonuses[BonusType.EnergyDrinkHpMinus] == 2) {
							    Bonuses[BonusType.EnergyDrinkHpMinus] = 3;
								MAXHP = MAXHP * 0.80;
							}
							break;
					}
					break;
				case ItemIds.Injection_Type_Asacoco:
					HP = HP - (HP * 0.05);
					break;
				case ItemIds.UberSheep:
					do{
						a = irandom_range(-1,1);
						b = irandom_range(-1,1);
					} until (a != b)
					instance_create_layer(
					oPlayer.x+ (irandom_range(64,128) *a),
					oPlayer.y+(irandom_range(64,128)*b),
					"Instances",
					oBurguer
					);
					break;
				case ItemIds.Idol_Costume:
					if (_player.idolCostumeLevel != playerItems[i][$ "level"]) {
					    _player.idolCostumeLevel = playerItems[i][$ "level"];
						_player.specialcooldown = _player.specialcooldown * playerItems[i][$ "SpecialCooldown"];
					}
					break;
				case ItemIds.Hope_Soda:
					if (!variable_instance_exists(_player, "hopeSodaLevel")) {
					    _player.hopeSodaLevel = 0;
					}
					if (_player.hopeSodaLevel != playerItems[i][$ "level"]) {
					    _player.hopeSodaLevel = playerItems[i][$ "level"];
						_player.specialcooldown = _player.specialcooldown * playerItems[i][$ "SpecialCooldown"];
					}
					break;
				case ItemIds.Stolen_Piggy_Bank:
					if(variable_global_exists("pig") and time_source_exists(global.pig)) {break;}
					global.pigfunction = function()
					{
					    global.newcoins += 1;
					}
					global.pig = time_source_create(time_source_game, 1, time_source_units_seconds,global.pigfunction, [], -1, time_source_expire_after);
					time_source_start(global.pig);
					break;
				case ItemIds.Piki_Piki_Piman:
					if (oPlayer.pimanLevel != playerItems[i][$ "level"]) {
					    oPlayer.pimanLevel = playerItems[i][$ "level"];
					    oPlayer.pimanBonus = playerItems[i][$ "bonusPercentage"];
						MAXHP += playerItems[i][$ "bonus"];
					}
					pimanUsable = true;
					break;
				case ItemIds.Just_Bandage:
					//if (!variable_instance_exists(_player, "bandageLevel")) { _player.bandageLevel = 0; }
					if (_player.bandageLevel != playerItems[i][$ "level"]) {
						_player.haveBandage = true;
					    _player.bandageLevel= playerItems[i][$ "level"];
						MAXHP = MAXHP + 10;
						HP += 10;
					}
					break;
				case ItemIds.Membership:
					if (global.newcoins > 0) {
					    global.newcoins -= 3;
						Bonuses[BonusType.Damage][ItemIds.Membership] = playerItems[i][$ "bonusATK"];
						Bonuses[BonusType.TakeDamage][ItemIds.Membership] = playerItems[i][$ "bonusLessDamage"];
					}
					if (global.newcoins <= 0) {
					    global.newcoins = 0;
						Bonuses[BonusType.Damage][ItemIds.Membership] = 1;
						Bonuses[BonusType.TakeDamage][ItemIds.Membership] = 1;
					}		
					break;
				case ItemIds.GWS_Pill:
					if (oPlayer.skilltimer < oPlayer.specialcooldown) {
					    Bonuses[BonusType.Critical][ItemIds.GWS_Pill] = playerItems[i][$ "crit"];
					}
					else {
						Bonuses[BonusType.Critical][ItemIds.GWS_Pill] = 0;
					}
					break;
				case ItemIds.BlacksmithsGear:
					oPlayer.blacksmithLevel = playerItems[i][$ "level"];
					break;
			}
		}
	}
}


function defaultItemBehaviour(_id, _cooldown){
	global.itemCooldown[_id] = _cooldown;
}