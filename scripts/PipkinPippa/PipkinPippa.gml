function PipkinPippa(){
    createCharacterNew({
		id : "Pipkin Pippa",
		name : "Pipkin Pippa",
		agency : "Phase-Connect",
		portrait : sPippaPortrait,
		bigArt : sPippaArt,
		sprite : sPippaIdle,
		runningsprite : sPippaRun,
		hp : 60,
		atk : 0.95,
		speed : 1.50,
		crit : 1.10,
		weapon : Weapons.PipiPilstol,
		ballsize : 1,
		flat : true,
		unlockedbydefault : true,
		finished : true
	});

    #region Heavy Artillery
    create_perk({
        on_cooldown : perk_heavy_artillery_on_cooldown,
        id : PerkIds.HeavyArtillery,
        name : "Heavy Artillery",
        maxlevel : 3, 
        weight : 1,
        thumb : sHeavyArtillery,
        cooldown : [3, 3, 2.01, 2.01],
        characterid : "Pipkin Pippa",
    });
    #endregion
    #region Moldy Soul
    create_perk({
        on_cooldown : moldy_soul,
        on_crit : moldy_soul_on_crit,
        id : PerkIds.MoldySoul,
        name : "Moldy Soul",
        maxlevel : 3, 
        weight : 1,
        thumb : sMoldySoul,
        cooldown : 1,
        characterid : "Pipkin Pippa",
        upgradeid : Weapons.Mold,
        chance : 33
    });
    #endregion
    #region Soda Fueled
    create_perk({
        id : PerkIds.SodaFueled,
        name : "Soda Fueled",
        maxlevel : 3, 
        weight : 1,
        thumb : sSodaFueled,
        cooldown : 1,
        characterid : "Pipkin Pippa"
    });
    #endregion
}