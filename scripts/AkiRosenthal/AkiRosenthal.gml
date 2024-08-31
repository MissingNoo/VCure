function aki_rosenthal_initialize() {
	createCharacterNew({ //TODO: Special, belly dance fade when close to screen border, 
		id : "Aki Rosenthal",
		name : "Aki Rosenthal",
		agency : "Hololive",
		portrait : sAkiPortrait,
		bigArt : sPlaceholderArt,
		sprite : sAkiIdle,
		runningsprite : sAkiRun,
		hp : 80,
		atk : 1.1,
		speed : 1.5,
		crit : 1,
		weapon : Weapons.Aik,
		ballsize : 3,
		flat : false,
		unlockedbydefault : true,
		finished : true
	});
	
	#region Belly Dancing
	create_perk({
		id : PerkIds.BellyDancing,
		on_cooldown : belly_dancing_on_cooldown,
		name : "Belly Dancing",
		maxlevel : 3, 
		weight : 1,
		thumb : sAkiPerk2,
		cooldown : 1,
		characterid : "Aki Rosenthal"
	});
	#endregion
	
	#region Mukirose
	create_perk({
		on_cooldown : perk_mukirose_on_cooldown,
		id : PerkIds.Mukirose,
		name : "Mukirose",
		maxlevel : 3, 
		weight : 1,
		thumb : sAkiPerk3,
		cooldown : [3, 3, 2.01, 2.01],
		characterid : "Aki Rosenthal"
	});
	#endregion
	
	#region Aromatherapy
	create_perk({
		on_cooldown : perk_aromateraphy_on_cooldown,
		draw : perk_aromatherapy_draw,
		id : PerkIds.Aromatherapy,
		name : "Aromatherapy",
		maxlevel : 3, 
		weight : 1,
		thumb : sAkiPerk1,
		cooldown : 1.5,
		characterid : "Aki Rosenthal",
	});
	#endregion
	
	var sp = new Special(SpecialIds.Shallys, "Aki Rosenthal", "Shallys", sAkiSpecial, 60);
	SPECIAL_LIST[SpecialIds.Shallys] = sp;
}