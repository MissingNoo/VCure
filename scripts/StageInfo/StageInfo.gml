global.stage = {
	"Stage1" : {
		"m00s05" : {
			"event" : [
				{
					"id" : Enemies.Urufugang,
					"pattern" : Patterns.Cluster,
					"amount" : 15
				}]
		},
		"m00s30" : {
			"addEnemy" : [Enemies.DeadBeat],
		},
		"m01s05" : {
			"event" : [
				{
					"id" : Enemies.KFPEmployee,
					"pattern" : Patterns.Horde,
					"amount" : 30,
					"hp" : 25,
					"spd" : 3
				}]
		},
		"m01s30" : {
			"event" : [
				{
					"id" : Enemies.DeadBeatLV3,
					"pattern" : Patterns.WallLeftRight,
					"amount" : 140,
					"hp" : 120,
					"xp" : 4,
					"lifetime" : 8.3
				}]
		},
		"m02s00" : {
			"addEnemy" : [Enemies.MegaShrimp]
		},
		"m02s35" : {
			"event" : [
				{
					"id" : Enemies.DeadBeat,
					"pattern" : Patterns.Ring,
					"amount" : 50,
				}]
		},
		"m02s45" : {
			"event" : [
				{
					"id" : Enemies.DeadBeatLV3,
					"pattern" : Patterns.StampedeRight,
					"amount" : 10,
					"hp" : 500,
					"spd" : 2,
					"xp" : 8,
					"lifetime" : 20
				}]
		},
		"m03s00" : {
			"addEnemy" : [Enemies.Takodachi],
			"delEnemy" : [Enemies.Urufugang]
		},
		"m03s15" : {
			"event" : [
				{
					"id" : Enemies.TakoViking,
					"pattern" : Patterns.WallTopBottom,
					"amount" : 140,
					"hp" : 200,
					"xp" : 5,
					"spd" : 0.55,
					"lifetime" : 8.3,
					"followPlayer" : true,
					"r" : 0
				}]
		},
		"m03s18" : {
			"event" : [
				{
					"id" : Enemies.KFPEmployee,
					"pattern" : Patterns.Horde,
					"amount" : 30,
					"hp" : 25,
					"spd" : 3,
				}]
		},
		"m03s40" : {
			"event" : [
				{
					"id" : Enemies.TakoViking,
					"pattern" : Patterns.StampedeTop,
					"amount" : 20,
					"hp" : 500,
					"xp" : 8,
					"atk" : 1,
					"spd" : 1.6,
					"lifetime" : 20,
					"r" : 0, 
					"distanceDie" : 0,
					"followPlayer" : false,
					"offset" : 1
				},
				{
					"id" : Enemies.TakoViking,
					"pattern" : Patterns.StampedeDown,
					"amount" : 20,
					"hp" : 500,
					"xp" : 8,
					"atk" : 1,
					"spd" : 1.6,
					"lifetime" : 20,
					"r" : 0, 
					"distanceDie" : 0,
					"followPlayer" : false,
					"offset" : 2
				}]
		},
		"m04s00" : {
			"addEnemy" : [Enemies.KFPEmployee, Enemies.TakoGrande]
		},
		"m04s15" : {
			//	spawn_event(Enemies.TakoViking, Patterns.Ring, 200, 1, 0.55, 5, 26, 50);
		},		
		"m05s00" : {
			"addEnemy" : [Enemies.DarkShrimp, Enemies.Bloom, Enemies.Gloom],
			"delEnemy" : [Enemies.DeadBeat, Enemies.Takodachi]
			//	spawn_event(Enemies.KFPEmployee,Patterns.Horde, 25, "-", 3, "-", "-", 100);
		},
		"m05s05" : {
			//	spawn_event(Enemies.KFPEmployee,Patterns.Horde, 25, "-", 3, "-", "-", 100);
		},
		"m05s10" : {
			//	spawn_event(Enemies.KFPEmployee,Patterns.Horde, 25, "-", 3, "-", "-", 100);
		},
		"m05s30" : {
			//	repeatSource = time_source_create(time_source_game, 0.5, time_source_units_seconds, function(){ spawn_event(Enemies.TakoViking, Patterns.StampedeRight, 800, 1, 2, 8, 20, 10);}, [], 5);
			//	time_source_start(repeatSource);
		},
		"m06s00" : {
			"addEnemy" : [Enemies.DeadBatter, Enemies.MegaDarkShrimp],
			"delEnemy" : [Enemies.KFPEmployee]
		},
		"m06s30" : {
			"addEnemy" : [Enemies.InvestiGator]
		},
		"m07s00" : {
			//	spawn_event(Enemies.Urufugang, Patterns.Ring, 500, 5, 0.05, 10, 25, 76, 400, "-", true, 16);
		},
		"m07s35" : {
			"addEnemy" : [Enemies.HungryTakodachi]
		},
		"m08s00" : {
			"addEnemy" : [Enemies.GiantDeadBatter]
		},
		"m08s30" : {
			"delEnemy" : [Enemies.DarkShrimp, Enemies.DeadBatter]
			//	repeatSource = time_source_create(time_source_game, 2, time_source_units_seconds, function(){ spawn_event(Enemies.DeadBeatLV3,Patterns.Ring, "-", "-", 0.35, "-", 11, 27, 400)}, [], 10);
			//	time_source_start(repeatSource);
		},
		"m08s55" : {
			//	repeatSource = time_source_create(time_source_game, 5, time_source_units_seconds, function(){ spawn_event(Enemies.DisgruntledEmployee, Patterns.Horde, "-", "-", 3, "-", "-", 60);}, [], 6);
			//	time_source_start(repeatSource);
		},
		"m09s30" : {
			"addEnemy" : [Enemies.DisgruntledEmployee]
		},
		"m10s00" : {
			"addEnemy" : [Enemies.FubuZilla]
		},
		"m10s15" : {
		//	spawn_event(Enemies.InvestiGator, Patterns.StampedeLeft, 1000, "-", 1.6, 10, 20, 40, 0, 0, false, 1);
		//	spawn_event(Enemies.InvestiGator, Patterns.StampedeRight, 1000, "-", 1.6, 10, 20, 40, 0, 0, false, 1);
		//	spawn_event(Enemies.InvestiGator, Patterns.StampedeTop, 1000, "-", 1.6, 10, 20, 40, 0, 0, false, 1);
		//	spawn_event(Enemies.InvestiGator, Patterns.StampedeDown, 1000, "-", 1.6, 10, 20, 40, 0, 0, false, 1);
		},
		"m11s00" : {
			"delEnemy" : [Enemies.Bloom, Enemies.Gloom, Enemies.HungryTakodachi, Enemies.InvestiGator, Enemies.DisgruntledEmployee],
			"addEnemy" : [Enemies.BaeRat]
		},
		"m11s30" : {
		//	spawn_event(Enemies.BaeRat, Patterns.Ring, "-", "-", "-", "-", "-", 120, 500, 0, true, 16);
		},
		"m12s00" : {
			"addEnemy" : [Enemies.KronieA, Enemies.KronieB]
		},
		"m12s20" : {
		//	spawn_event(Enemies.KronieA, Patterns.StampedeLeft, 2000, 7, 2, 10, 20, 10, 0, 0, false, 2);
		//	spawn_event(Enemies.KronieB, Patterns.StampedeRight, 2000, 7, 2, 10, 20, 10, 0, 0, false, 1);
		},
		"m12s25" : {
		//	spawn_event(Enemies.KronieA, Patterns.StampedeTop, 2000, 7, 3, 10, 20, 10, 0, 0, false, 1);
		//	spawn_event(Enemies.KronieA, Patterns.StampedeDown, 2000, 7, 3, 10, 20, 10, 0, 0, false, 2);
		},
		"m12s45" : {
		//	repeatSource = time_source_create(time_source_game, 1, time_source_units_seconds, function(){
		//		spawn_event(Enemies.KronieA, Patterns.StampedeLeft, 2000, 7, 3, 10, 20, 20, 0, 0, false, 1);
		//		spawn_event(Enemies.KronieA, Patterns.StampedeDown, 2000, 7, 3, 10, 20, 20, 0, 0, false, 2);
		//		}, [], 5);
		//	time_source_start(repeatSource);		
		},
		"m13s00" : {
			"addEnemy" : [Enemies.KingKronie]
		},
		"m14s00" : {
			"delEnemy" : [Enemies.BaeRat, Enemies.KronieA, Enemies.KronieB],
			"addEnemy" : [Enemies.QDeadBeat, Enemies.QShrimp]
		},
		"m15s00" : {
			"addEnemy" : [Enemies.GiantQDeadbeat, Enemies.MegaQShrimp]
		},
		"m15s45" : {
			"addEnemy" : [Enemies.SaplingA, Enemies.SaplingB, Enemies.SaplingC, Enemies.HoomanA, Enemies.HoomanB]
		},
		"m16s00" : {
			"delEnemy" : [Enemies.QDeadBeat, Enemies.QShrimp]
		},
		"m16s15" : {
		//	spawn_event(Enemies.KronieA, Patterns.WallLeftRight, 1500, "-", 0.26, 10, 15, 100, 0, 0, false, 100);
		//	spawn_event(Enemies.KronieA, Patterns.WallTopBottom, 1500, "-", 0.26, 10, 15, 100, 0, 0, false, 150);
		},
		"m17s30" : {
			"addEnemy" : [Enemies.OvergrownSapling]
		},
		"m18s00" : {
			"addEnemy" : [Enemies.Sanallite]
		},
		"m19s00" : {
			"addEnemy" : [Enemies.SwarmingKingKronie, Enemies.SwarmingOvergrownSapling],
			"delEnemy" : [Enemies.SaplingA, Enemies.SaplingB, Enemies.SaplingC, Enemies.HoomanA, Enemies.HoomanB, Enemies.Sanallite]
		},
		"m20s00" : {
			"addEnemy" : [Enemies.ThiccBubba, Enemies.SmolAme],
			"delEnemy" : [Enemies.SwarmingKingKronie, Enemies.SwarmingOvergrownSapling]
		},
		"m23s00" : {
		//	reset_pool();
			"delEnemy" : [Enemies.Urufugang],
		//	for (var i = Enemies.EndlessShrimp; i <= Enemies.EndlessSanallite; ++i) {
		//	    add_enemy_to_pool(i);
		//	}
		}
	}
}	
	
	
	
	
