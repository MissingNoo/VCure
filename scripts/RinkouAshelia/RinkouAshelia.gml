function RinkouAshelia(){
	
	new_create_upgrade({
		step : eletric_pulse_step,
		id : Weapons.ElectricPulse,
		name : "Electric Pulse",
		maxlevel : 7,
		sprite : sEletricPulse,
		attackdelay : 10,
		thumb : sBolt,
		mindmg : [7, 7*1.20, 7*1.20, 7*1.20, 7*1.20, 7*1.20*1.10, 7*1.20*1.10],
		maxdmg : [13, 13, 13*1.25, 13*1.25, 13*1.25, 13*1.20*1.40, 13*1.20*1.40],
		cooldown : [80, 80, 80*0.90, 80*0.90, 80*0.90, 80*0.90, 80*0.90],
		duration : 300, 
		hitCooldown : 50,
		canBeHasted : true,
		speed : 0,
		hits : 9999,
		type : "red",
		shoots : 1,
		knockbackSpeed : [0, 0, 0, 0, 0, 0, 0],
		knockbackDuration : [0, 0, 0, 0, 0, 0, 0],
		perk : true,
		size : 0.5,
		characterid : "NullChar",
	});
	
	new_create_upgrade({
		create : liabolt_create,
		step : liabolt_step,
		draw : liabolt_draw,
		id : Weapons.LiaBolt,
		name : "Lightning Bolt",
		maxlevel : 7,
		sprite : sBolt,
		attackdelay : 10,
		thumb : sLiaBolt,
		mindmg : [7, 7*1.20, 7*1.20, 7*1.20, 7*1.20, 7*1.20*1.10, 7*1.20*1.10],
		maxdmg : [13, 13*1.20, 13*1.20, 13*1.20, 13*1.20, 13*1.20*1.10, 13*1.20*1.10],
		cooldown : [80, 80, 80*0.85, 80*0.85, 80*0.85*0.90, 80*0.85*0.90, 80*0.85*0.90],
		duration : 50, 
		hitCooldown : 20,
		canBeHasted : true,
		speed : 0,
		hits : 1,
		type : "red",
		shoots : 1,
		bolts : [1, 2, 2, 3, 3, 3, 5],
		knockbackSpeed : 0,
		knockbackDuration : 0,
		perk : true,
		characterid : "Rinkou Ashelia",
		weight : 3
	});
		
	createCharacterNew({
		id : "Rinkou Ashelia",
		name : "Rinkou Ashelia",
		agency : "Phase-Connect",
		portrait : sLiaPortrait,
		bigArt : sLiaArt,
		sprite : sLiaIdle,
		runningsprite : sLiaRunningOld,
		hp : 70,
		atk : 1.25,
		speed : 1.30,
		crit : 0.75,
		weapon : Weapons.LiaBolt,
		ballsize : 1,
		flat : true,
		unlockedbydefault : true,
		finished : true
	});
		
	#region EletricPulse
	create_perk({
		on_cooldown : perk_eletric_pulse_on_cooldown,
		id : PerkIds.EletricPulse,
		name : "Power Strike",
		maxlevel : 3, 
		weight : 1,
		thumb : sEletricPulseThumb,
		cooldown : [0, 10, 8, 6],
		characterid : "Rinkou Ashelia",
		upgrade : true,
		upgradeid : Weapons.ElectricPulse,
	});
	#endregion
	#region Lick
	create_perk({
		on_cooldown : perk_lick_on_cooldown,
		draw : perk_lick_draw,
		id : PerkIds.Lick,
		name : "Lick",
		maxlevel : 3, 
		weight : 1,
		thumb : sLick,
		cooldown : [0, 5, 4, 3],
		characterid : "Rinkou Ashelia",
		lickArea : [0, 60, 90, 120]
	});
	#endregion
	#region Viral
	create_perk({
		on_hit : perk_viral_on_crit,
		id : PerkIds.Viral,
		name : "Viral",
		maxlevel : 3, 
		weight : 1,
		thumb : sViral,
		cooldown : 1,
		characterid : "Rinkou Ashelia",
		chance : [0, 20, 27, 33],
		maxInfected : [0, 5, 10, 15]
	});
	#endregion
}