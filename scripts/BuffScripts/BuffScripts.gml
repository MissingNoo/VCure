enum BuffNames{
	//ShortHeight,
	//SharkBite,
	//Slowness,
	Sake,
	SakeFood,
	Spaghetti,
	Paralyzed,
	RestNote,
	Soda,
	testbuff,
	WallmartDefense,
	AtkDown,
	SpdDown,
	DefDown,
	BellyDance,
	Sharpen,
	RestNoteCooldown,
    MoldySoul,
	Slumber
}
	//Buffs[BuffNames.ShortHeight] = {
	//	id : BuffNames.ShortHeight,
	//	name : "Short Height",
	//	icon : sShortHeight,
	//	enabled : false,
	//	baseCooldown : 2,
	//	cooldown : 0,
	//	chance : [0,15,25,35],
	//	bonus : [0,1.3,1.4,1.5]
	//}
function populate_buffs() {
	Buffs[BuffNames.testbuff] = {
		id : BuffNames.testbuff,
		name : "Test Buff",
		icon : sBreastplate,
		enabled : false,
		baseCooldown : 10,
		cooldown : 0,
		count : 0,
		chance : [0,15,25,35],
		bonus : [0,1.3,1.4,1.5]
	}
	Buffs[BuffNames.Sake] = {
		func : sake_buff_tick,
		id : BuffNames.Sake,
		name : "Sake",
		icon : sSake,
		enabled : false,
		permanent : true,
		baseCooldown : 1,
		cooldown : 0,
		count : 0,
		maxCount : 10
	}
	Buffs[BuffNames.SakeFood] = {
		enter : sakefood_buff_enter,
		leave : sakefood_buff_end,
		id : BuffNames.SakeFood,
		name : "SakeFood",
		icon : sSakeFood,
		enabled : false,
		baseCooldown : 10,
		cooldown : 0,
	}
	Buffs[BuffNames.Paralyzed] = {
		id : BuffNames.Paralyzed,
		name : "Paralyzed",
		icon : sBlank,
		enabled : false,
		baseCooldown : 3,
		cooldown : 0,
	}
	Buffs[BuffNames.RestNote] = {
		id : BuffNames.RestNote,
		name : "Resting",
		icon : sBlank,
		enabled : false,
		baseCooldown : 3,
		cooldown : 0,
		draw : rest_buff_draw
	}
	Buffs[BuffNames.Soda] = {
        enter : buff_soda_enter,
        leave : buff_soda_leave,
		id : BuffNames.Soda,
		name : "Soda",
		icon : sSodaFueled,
		enabled : false,
		baseCooldown : 3,
		cooldown : 0,
	}
	Buffs[BuffNames.WallmartDefense] = {
		enter : buff_wallmart_enter,
		leave : buff_wallmart_leave,
		id : BuffNames.WallmartDefense,
		name : "Wallmart",
		icon : sWalmart,
		enabled : false,
		baseCooldown : 10,
		cooldown : 10,
	}
	Buffs[BuffNames.BellyDance] = {
		func : buff_belly_dance_cooldown,
		id : BuffNames.BellyDance,
		name : "Belly Dance",
		icon : sAkiPerk2,
		enabled : false,
		permanent : true,
		count : 0,
		maxCount : 999,
		cooldown : 0,
		baseCooldown : 1,
		level : 0
	}
	Buffs[BuffNames.AtkDown] = {
		id : BuffNames.AtkDown,
		name : "atkdown",
		icon : sHudAtkIcon,
		enabled : false,
		permanent : false,
		count : 0,
		maxCount : 3,
		cooldown : 10,
		baseCooldown : 10,
		stat : "atkMult",
		statAmount : [1, 0.9, 0.8, 0.7]
	}
	Buffs[BuffNames.SpdDown] = {
		id : BuffNames.SpdDown,
		name : "spddown",
		icon : sHudSpdIcon,
		enabled : false,
		permanent : false,
		count : 0,
		maxCount : 3,
		cooldown : 10,
		baseCooldown : 10,
		stat : "spdMult",
		statAmount : [1, 0.9, 0.8, 0.7, 0.6, 0.5, 0.4, 0.3, 0.2, 0.1]
	}
	Buffs[BuffNames.DefDown] = {
		id : BuffNames.DefDown,
		name : "defdown",
		icon : sHudDefenseIcon,
		enabled : false,
		permanent : false,
		count : 0,
		maxCount : 3,
		cooldown : 10,
		baseCooldown : 10,
		stat : "damageMultFromDefDown",
		statAmount : [1, 1,1, 1.2, 1.3]
	}
	Buffs[BuffNames.Sharpen] = {
		id : BuffNames.Sharpen,
		name : "sharpen",
		icon : sAnyaPerk2,
		enabled : false,
		permanent : true,
		count : 0,
		maxCount : 50
	}
	Buffs[BuffNames.RestNoteCooldown] = {
		id : BuffNames.RestNoteCooldown,
		name : "Rest Note Cooldown",
		icon : sRestNote,
		cooldown : 3,
		baseCooldown : 3
	}
    Buffs[BuffNames.Spaghetti] = {
		id : BuffNames.Spaghetti,
		name : "Spaghetti",
		icon : sSpaghetti,
		permanent : false,
		cooldown : 3,
		baseCooldown : 3
	}
    Buffs[BuffNames.MoldySoul] = {
		id : BuffNames.MoldySoul,
		name : "MoldySoul",
		icon : sMoldySoul,
		permanent : true,
        count : 0
	}
    Buffs[BuffNames.Slumber] = {
		id : BuffNames.Slumber,
		name : "Slumber",
		icon : sAnyaPerk3,
		permanent : true,
		cooldown : 2,
		baseCooldown : 2,
        count : 0
	}
    
		
	//Buffs[BuffNames.SharkBite] = {
	//	id : BuffNames.SharkBite,
	//	name : "Shark Bite",
	//	icon : sSharkBite,
	//	maxMarks : 5,
	//	marks : 1,
	//	level : 1,
	//	damage : [1,1.6,1.9,1.12],
	//	chance : [0,10,15,20]
	//}
	//createCharacter(Characters.Ina,"Ninomae Ina'nis",sInaPortrait,sInaIdle,sInaRunning,75,1.50,0.90,u[Weapons.InaTentacle]);
	//createCharacter(Characters.Kiara,"Takanashi Kiara",sAmePortrait,sAmeIdle,sAmeRunning,30,1.35,10,u[Weapons.UrukaNote]);
	//createCharacter(Characters.Calli,"Mori Calliope",sAmePortrait,sAmeIdle,sAmeRunning,30,1.35,10,u[Weapons.UrukaNote]);
	
}

function player_buff_remove(bid) {
	if (player_have_buff(bid)) {
		var pos = player_get_buff_pos(bid);
		array_delete(PlayerBuffs, pos, 1);
	}
}

function buff_wallmart_enter() {
	instance_create_depth(oPlayer.x, oPlayer.y, oPlayer.depth, oSpecialEffect);
	oPlayer.wallMart = true;
}

function buff_wallmart_leave() {
	instance_destroy(oSpecialEffect);
	oPlayer.wallMart = false;
}