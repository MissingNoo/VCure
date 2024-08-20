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
		finished : 3
	});
	
	#region Belly Dancing
	create_perk({
		id : PerkIds.BellyDancing,
		func : belly_dancing,
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
		func : perk_mukirose,
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
		func : perk_aromateraphy,
		id : PerkIds.Aromatherapy,
		name : "Aromatherapy",
		maxlevel : 3, 
		weight : 1,
		thumb : sAkiPerk1,
		cooldown : 1.5,
		characterid : "Aki Rosenthal",
		draw : true
	});
	#endregion
	
	sp = new Special(SpecialIds.Shallys, "Aki Rosenthal", "Shallys", sAkiSpecial, 60);
	SPECIAL_LIST[SpecialIds.Shallys] = sp;
}