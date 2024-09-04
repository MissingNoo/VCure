function AnyaMelfissa(){
	
	function anya_vars(){
		
	}
	
	createCharacterNew({
		startvars : anya_vars,
		id : "Anya Melfissa",
		name : "Anya Melfissa",
		agency : "Hololive",
		portrait : sAnyaPortrait,
		bigArt : sPlaceholderArt,
		sprite : sAnyaIdle,
		runningsprite : sAnyaRun,
		hp : 60,
		atk : 1.50,
		speed : 1.20,
		crit : 5,
		weapon : Weapons.Keris,
		ballsize : 2,
		flat : true,
		unlockedbydefault : true,
		finished : true
	});
	
	#region Cutting Deep
		create_perk({
			on_hit : perk_cutting_deep_on_hit,
			id : PerkIds.CuttingDeep,
			name : "Cutting Deep",
			maxlevel : 3,
			weight : 3,
			thumb : sAnyaPerk1,
			cooldown : [1, 1, 1, 1],
			characterid : "Anya Melfissa",
			bonus : true,
			bonusType : BonusType.PickupRange,
			bonusValue : [0, 20, 40, 60],
		});
		#endregion
		
		#region Living Weapon
		create_perk({
			draw : perk_living_weapon_draw,
			on_cooldown : living_weapon_on_cooldown,
			on_kill : perk_living_weapon_on_kill,
			on_player_hit : perk_living_weapon_on_player_hit,
			id : PerkIds.LivingWeapon, 
			name : "Living Weapon", 
			maxlevel : 3,
			weight : 3, 
			thumb : sAnyaPerk2, 
			cooldown : [1, 1, 1, 1], 
			characterid : "Anya Melfissa"
		});
		#endregion
		
		#region Slumber
		create_perk({ 
			draw : perk_slumber_draw,
			on_cooldown : perk_slumber_on_cooldown,
			on_move : perk_slumber_on_move,
			on_player_hit : perk_slumber_on_player_hit,
			on_hit : perk_slumber_on_hit,
			id : PerkIds.Slumber, 
			name : "Slumber",
			maxlevel : 3, 
			weight : 3, 
			thumb : sAnyaPerk3, 
			cooldown : [2, 2, 2, 2], 
			characterid : "Anya Melfissa"
		});
		#endregion
		
		sp = new Special(SpecialIds.BladeForm, "Anya Melfissa", "Blade Form", sAnyaSpecial, 60)
		.set_function(function(){
			oPlayer.bladeForm = true;
			oPlayer.bladeFormTimer = 8;
		});
		SPECIAL_LIST[SpecialIds.BladeForm] = sp;
}