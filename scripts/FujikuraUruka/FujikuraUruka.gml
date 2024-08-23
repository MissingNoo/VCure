function FujikuraUruka(){
createCharacterNew({
		id : "Fujikura Uruka",
		name : "Fujikura Uruka",
		agency : "Phase-Connect",
		portrait : sUrukaPortrait,
		bigArt : sUrukaArt,
		sprite : sUrukaIdle,
		runningsprite : sUrukaRunning,
		hp : 75,
		atk : 1.30,
		speed : 1.35,
		crit : 1.10,
		weapon : Weapons.UrukaNote,
		ballsize : 3,
		flat : false,
		unlockedbydefault : true,
		finished : true
	});
	
	#region Dirty Mind
		create_perk({
			id : PerkIds.DirtyMind,
			name : "Dirty Mind",
			maxlevel : 3, 
			weight : 1,
			thumb : sDirtyMind,
			cooldown : 1,
			characterid : "Fujikura Uruka",
			dodgeChance: [0, 15, 20, 25]
		});
		#endregion
		
		#region Trash Bear
		create_perk({
			func : trash_bear,
			id : PerkIds.TrashBear,
			name : "Trash Bear",
			maxlevel : 3, 
			weight : 1,
			thumb : sTrashBear,
			cooldown : 1,
			characterid : "Fujikura Uruka",
			//dropChance : [0, 10, 11, 12],
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
			characterid : "Fujikura Uruka",						
		});
		#endregion
}