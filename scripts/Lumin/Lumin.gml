function TsukiboshiLumin() {
	createCharacterNew({ //TODO: Special, belly dance fade when close to screen border, 
		id : "Tsukiboshi Lumin",
		name : "Tsukiboshi Lumin",
		agency : "Hololive",
		portrait : sLockIcon,
		bigArt : sPlaceholderArt,
		sprite : sLuminIdle,
		runningsprite : sLuminRun,
		hp : 80,
		atk : 1.1,
		speed : 1.5,
		crit : 1,
		weapon : Weapons.BounceBall,
		ballsize : 3,
		flat : false,
		unlockedbydefault : true,
		finished : true
	});
	
	#region Belly Dancing
	create_perk({
		id : PerkIds.LuminPerk1,
		name : "Belly Dancing",
		maxlevel : 3, 
		weight : 1,
		thumb : sLockIcon,
		cooldown : 1,
		characterid : "Tsukiboshi Lumin"
	});
	#endregion
	
	#region Mukirose
	create_perk({
		id : PerkIds.LuminPerk2,
		name : "Mukirose",
		maxlevel : 3, 
		weight : 1,
		thumb : sLockIcon,
		cooldown : [3, 3, 2.01, 2.01],
		characterid : "Tsukiboshi Lumin"
	});
	#endregion
	
	#region Aromatherapy
	create_perk({
		id : PerkIds.LuminPerk3,
		name : "Aromatherapy",
		maxlevel : 3, 
		weight : 1,
		thumb : sLockIcon,
		cooldown : 1.5,
		characterid : "Tsukiboshi Lumin",
	});
	#endregion
	
	var sp = new Special(SpecialIds.LuminSpecial, "Tsukiboshi Lumin", "Shallys", sLockIcon, 60);
	SPECIAL_LIST[SpecialIds.LuminSpecial] = sp;
}