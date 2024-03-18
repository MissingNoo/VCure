#region model
//new_create_upgrade({ 
//				id : Weapons.,
//				weight : 0,
//				name : "",
//				maxlevel : 7,
//				sprite : s,
//				thumb : s,
//				mindmg : 0,
//				maxdmg : 0,
//				cooldown : 0,
//				minimumcooldown : 1,
//				shoots : 1,
//				attackdelay : 0,
//				hits : 0,
//				hitCooldown : 0, 
//				duration : 0,
//				speed : 0,
//				knockbackDuration : 0,
//				knockbackSpeed : 0,
//				size : 1,
//				canBeHasted : true,
//				type : "white",
//				shotType : ShotTypes.Multishot,
//				perk : false,
//			});
#endregion
#macro UPGRADES global.upgrades
global.upgrade = false;
global.upgradeCooldown[0] = 0;
#region Null Upgrade
	global.null={};
	var m = global.null;
	variable_struct_set(m, "id", 0);
	variable_struct_set(m, "name", "null");
	variable_struct_set(m, "level", 0);
	variable_struct_set(m, "maxlevel", 0);
	variable_struct_set(m, "sprite", sBlank);
	variable_struct_set(m, "thumb", sBlank);
	variable_struct_set(m, "mindmg", 0);
	variable_struct_set(m, "maxdmg", 1);
	variable_struct_set(m, "cooldown", 1);
	variable_struct_set(m, "duration", 0);
	variable_struct_set(m, "hitCooldown", 0);
	variable_struct_set(m, "canBeHasted", false);
	variable_struct_set(m, "speed", 0);
	variable_struct_set(m, "hits", 0);	
	variable_struct_set(m, "type", "white");	
	variable_struct_set(m, "shoots", 0);	
	variable_struct_set(m, "desc", "");
	variable_struct_set(m, "style", ItemTypes.Weapon);
	global.upgradesAvaliable=[0];
	for (i=0; i<4; i++) {
	    global.upgradeOptions[i]=global.null;
}
#endregion
enum ItemTypes {
	Weapon,
	Item,
	Perk,
	Collab
}
enum ShotTypes {
	Multishot,
	Ranged,
	Melee
}
enum Enchantments {
	None,
	Damage,
	Size,
	Cooldown,
	HitRate,
	CritDamage,
	Knockback,
	Projectile
}
global.enchantmentWeights = [0, 5, 5, 3, 3, 2, 1, 1];
#region Upgrades
/**
 * Function Description
 * @param {struct} _data Description
 * @param {Array<Asset.GMSound>} [_sounds]=[] Description
 */
 //feather disable once GM1045
function new_create_upgrade(_data, _sounds = ""){
	global.upgradesAvaliable[_data.id][0] = global.null;
	_data.z = "z";
	//show_message(_data);
	for (var i = 1; i <= _data.maxlevel; ++i) {
		global.upgradesAvaliable[_data.id][i] = {};
		global.upgradesAvaliable[_data.id][i].sound = _sounds;
		var m = global.upgradesAvaliable[_data.id][i];
		variable_struct_set(m, "level" ,i);
		variable_struct_set(m, "enchantment" , Enchantments.None);
		if (variable_struct_exists(_data, "incompatibleEnchantments")) {
		    variable_struct_set(m, "incompatibleEnchantments", _data.incompatibleEnchantments);
		}
		//variable_struct_set(m, "desc", lexicon_text("Weapons." + _data.name + "." + string(i)));
		variable_struct_set(m, "style", ItemTypes.Weapon);
		//variable_struct_set(m, "collabWith", _data[$ "collabWith"]);
		var keys = variable_struct_get_names(_data);
		//show_message(keys);
		for (var j = array_length(keys)-1; j >= 0; --j) {
		    var k = keys[j];
			if (k == "incompatibleEnchantments") { continue; }
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
		//show_message(global.upgradesAvaliable[_data.id]);
		global.upgradeCooldown[_data.id] = 0;
	}
}

function create_upgrade(_id, _name, _level, _sprite, _thumb, _mindmg, _maxdmg, _cooldown, _duration, _hitCooldown, _canBeHasted, _speed, _hits, _type, _shoots, _desc = "")
{
	global.upgradesAvaliable[_id][0]=global.null;
	global.upgradesAvaliable[_id][_level]={};
	var m = global.upgradesAvaliable[_id][_level];
	variable_struct_set(m, "id", _id);
	variable_struct_set(m, "name", _name);
	variable_struct_set(m, "level", _level);
	variable_struct_set(m, "sprite", _sprite);
	variable_struct_set(m, "thumb", _thumb);
	variable_struct_set(m, "mindmg", _mindmg);
	variable_struct_set(m, "maxdmg", _maxdmg);
	variable_struct_set(m, "cooldown", _cooldown);
	variable_struct_set(m, "duration", _duration);
	variable_struct_set(m, "hitCooldown", _hitCooldown);
	variable_struct_set(m, "canBeHasted", _canBeHasted);
	variable_struct_set(m, "speed", _speed);
	variable_struct_set(m, "hits", _hits);	
	variable_struct_set(m, "type", _type);	
	variable_struct_set(m, "shoots", _shoots);	
	variable_struct_set(m, "desc", _desc);
	variable_struct_set(m, "style", ItemTypes.Weapon);	
	global.upgradeCooldown[_id] = 0;
}
function create_upgrade_p2(_id, _level, _maxlevel, _knockbackSpeed, _knockbackDuration, _perk = 0, _character = -1)
{
	var m = global.upgradesAvaliable[_id][_level];
	variable_struct_set(m, "knockbackSpeed", _knockbackSpeed);
	variable_struct_set(m, "knockbackDuration", _knockbackDuration);
	variable_struct_set(m, "perk", _perk);
	variable_struct_set(m, "characterid", _character);
	variable_struct_set(m, "maxlevel", _maxlevel);
}

enum Weapons{
	UrukaNote,
	RestNote,
	LiaBolt,
	ElectricPulse,
	Mold,
	BlBook, //TODO: area, knockback
	BounceBall,
	CEOTears,
	CuttingBoard,
	EliteLavaBucket,
	ENsCurse,
	FanBeam, //TODO: knockback
	Glowstick,
	HoloBomb, //TODO: correct scale
	IdolSong,
	PlugAsaCoco, //TODO: afterimage, knockback lv 6
	PsychoAxe,
	SpiderCooking,
	WamyWater,
	XPotato,
	XPotatoExplosion,
	MiComet,
	MiCometMeteor,
	MiCometPool,
	EldritchHorror,
	AbsoluteWall,
	BLFujoshi,
	BLFujoshiBook,
	BLFujoshiAxe,
	BoneBros,
	BoneBrosSlash,
	BoneBrosBullet,
	BreatheInTypeAsacoco,
	EliteCooking,
	RingOfFitness,
	StreamOfTears,
	ImDie,
	ImDieExplosion,
	Shockwave,
	PipiPilstol,
	HeavyArtillery,
	Brick,
	AmePistol,
	Aik,
	Keris,
	Length,
	AnyaBlade
}

function populate_upgrades(){
	#region Character Perks
		#region Uruka Perks
			#region UrukaNote 
			new_create_upgrade({
				func : urukanote_step,
				id : Weapons.UrukaNote,
				name : "Music Note",
				maxlevel : 7,
				sprite : sEightNote,
				attackdelay : 20,
				thumb : sUrukaNote,
				mindmg : [7, 7*1.20, 7*1.20, 7*1.20, 7*1.20, 7*1.20*1.10, 7*1.20*1.10],
				maxdmg : [13, 13*1.20, 13*1.20, 13*1.20, 13*1.20, 13*1.20*1.10, 13*1.20*1.10],
				cooldown : [80, 80, 80*0.90, 80*0.90, 80*0.90, 80*0.90, 80*0.90],
				duration : 200, 
				hitCooldown : [10, 10, 10, 10, 10, 10, 10], 
				canBeHasted : true,
				speed : [3, 3, 3, 3, 3*1.10, 3*1.10, 3*1.10],
				hits : 99,
				type : "red",
				shoots : 1,
				knockbackSpeed : [0, 0, 0, 0, 0, 0, 0],
				knockbackDuration : [0, 0, 0, 0, 0, 0, 0],
				perk : true,
				characterid : Characters.Uruka,
				travelWidth : 32,
				weight : 3
			},[snd_bullet, snd_bullet2, snd_bullet3]);
			#endregion
			#region UrukaNote 
			new_create_upgrade({
				id : Weapons.RestNote,
				name : "Rest Note",
				maxlevel : 1,
				sprite : sRestNote,
				attackdelay : 10,
				thumb : sRestNote,
				mindmg : 1,
				maxdmg : 2,
				cooldown : 1,
				duration : 120, 
				hitCooldown : [10, 10, 10, 10, 10, 10, 10], 
				canBeHasted : true,
				speed : 3,
				hits : 1,
				type : "red",
				shoots : 1,
				knockbackSpeed : [0, 0, 0, 0, 0, 0, 0],
				knockbackDuration : [0, 0, 0, 0, 0, 0, 0],
				perk : true,
				characterid : Characters.Null,
			});
			#endregion
		#endregion	
		#region Lia
		new_create_upgrade({
			func : liabolt_step,
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
			characterid : Characters.Lia,
			weight : 3
		});
		new_create_upgrade({
			func : eletricpulse_step,
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
				characterid : Characters.Null,
			});
		#endregion
		#region Tenma
		#region Brick
		new_create_upgrade({
			func : brick_step,
			id : Weapons.Brick,
			name : "Brick",
			maxlevel : 7,
			sprite : sBrickProjectile,
			attackdelay : 20,
			thumb : sBrick,
			mindmg : [7, 7*1.20, 7*1.20, 7*1.20, 7*1.20, 7*1.20*1.10, 7*1.20*1.10],
			maxdmg : [13, 13*1.20, 13*1.20, 13*1.20, 13*1.20, 13*1.20*1.10, 13*1.20*1.10],
			cooldown : [80, 80, 80*0.90, 80*0.90, 80*0.90, 80*0.90, 80*0.90],
			duration : 200, 
			hitCooldown : [20, 20, 20, 20, 20, 20, 20], 
			canBeHasted : true,
			speed : [3, 3, 3, 3, 3*1.10, 3*1.10, 3*1.10],
			hits : [1, 1, 1, 2, 2, 2, 3],
			type : "red",
			shoots : [1, 1, 1, 2, 2, 2, 3],
			knockbackSpeed : [0, 0, 0, 0, 0, 0, 0],
			knockbackDuration : [0, 0, 0, 0, 0, 0, 0],
			perk : true,
			characterid : Characters.Tenma,
			weight : 3
		},[snd_bullet, snd_bullet2, snd_bullet3]);
		#endregion
		#endregion
		#region Hololive
		#region Amelia
		new_create_upgrade({
			func : amepistol_step,
			id : Weapons.AmePistol,
			name : "Pistol Shot",
			maxlevel : 7,
			sprite : sAmeliaWeaponProjectile,
			thumb : sAmeliaWeapon,
			mindmg : [8, 8, 10, 10, 10, 12, 12],
			maxdmg : [12, 12, 14, 14, 14, 16, 16],
			cooldown : [80, 80, 80, 80, 60, 60, 60],
			duration : 120,
			hitCooldown : 20,
			canBeHasted : true,
			attackdelay : 6,
			speed : 5,
			hits : [1, 2, 2, 2, 3, 3, 3],
			type : "red",
			shoots : [3, 5, 5, 5, 5, 5, 5],
			perk : true,
			characterid : Characters.Amelia,
			weight : 3
		},[snd_bullet, snd_bullet2, snd_bullet3]);
		#endregion
		#region Aki
		new_create_upgrade({
			func : aik_step,
			id : Weapons.Aik,
			name : "Aik",
			maxlevel : 7,
			sprite : sAkiProjectile,
			thumb : sAkiWeapon,
			mindmg : [14, 26, 26, 26, 26, 26, 22],
			maxdmg : [18, 32, 32, 32, 32, 32, 27],
			cooldown : [90, 90, 90, 90, 90, 76, 76],
			duration : 50,
			hitCooldown : 60,
			canBeHasted : true,
			attackdelay : 8,
			speed : 6,
			area : [.8, .8, .96, .96, .96, .96, 1.20],
			hits : [1, 2, 2, 2, 3, 3, 3],
			type : "red",
			shoots : [2, 2, 2, 3, 3, 4, 4],
			perk : true,
			characterid : Characters.Aki,
			weight : 3,
			range : 250,
			chance : [0, 0, 0, 0, 0, 0, 30],
			afterimage : true,
			afterimageColor : c_aqua,
		},[snd_bullet, snd_bullet2, snd_bullet3]);
		#endregion
		#region Anya
		new_create_upgrade({ id : Weapons.Keris, name : "Keris", maxlevel : 7, sprite : sAnyaProjectile, thumb : sAnyaWeapon, mindmg : [0, 0, 0, 0, 0, 0, 0], maxdmg : [0, 0, 0, 0, 0, 0, 0,], cooldown : [90, 90, 90, 90, 90, 76, 76], duration : 50, hitCooldown : 60, canBeHasted : true, attackdelay : 8, speed : 8, area : [.8, .8, .96, .96, .96, .96, 1.20], hits : [1, 2, 2, 2, 3, 3, 3], type : "red", shoots : [2, 2, 2, 3, 3, 4, 4], perk : true, characterid : Characters.Anya, weight : 3, range : 250, chance : [0, 0, 0, 0, 0, 0, 30] },[snd_bullet, snd_bullet2, snd_bullet3]);
		#endregion
		#endregion
	#region Shockwave
	new_create_upgrade({ //Shockwave
				id : Weapons.Shockwave,
				weight : 0,
				name : "Shockwave",
				maxlevel : 1,
				sprite : sShockwave,
				thumb : sBlank,
				mindmg : 0,
				maxdmg : 0,
				cooldown : 60,
				minimumcooldown : 1,
				shoots : 1,
				attackdelay : 5,
				hits : 100,
				hitCooldown : 30, 
				duration : 180,
				speed : 0,
				knockbackDuration : 1,
				knockbackSpeed : 20,
				size : 1,
				canBeHasted : true,
				type : "white",
				shotType : ShotTypes.Melee,
				perk : true,
				characterid : Characters.Lenght
			});
	#endregion
	#region BLBook
		new_create_upgrade({
				func : blbook_step,
				id : Weapons.BlBook,
				weight : 3,
				name : "BL Book",
				maxlevel : 7,
				sprite : sBLBook,
				thumb : sBLBookThumb,
				mindmg : [12, 12, 16, 16, 16, 16, 23],
				maxdmg : [16, 16, 20, 20, 20, 20, 28],
				orbitLength : [50, 50, 50, 50, 62.5, 62.5, 62.5],
				spinningSpeed : [3, 3, 3, 3, 3.75, 3.75, 3.75],
				cooldown : 360,
				minimumcooldown : 300,
				shoots : [3, 4, 4, 5, 5, 6, 6],
				hits : 7,
				hitCooldown : 20, 
				duration : [120, 120, 300, 300, 300, 300, 300],
				speed : 0,
				knockbackDuration : 5,
				knockbackSpeed : 2,
				canBeHasted : true,
				type : "white",
				afterimage : true,
				afterimageColor : c_red,
				shotType : ShotTypes.Multishot,
				perk : false,
				//collabWith : Weapons.PsychoAxe,
			});
	#endregion
	#region Bounce Ball //TODO: knockback depends on character
		new_create_upgrade({ 
			func : bounceball_step,
				id : Weapons.BounceBall,
				weight : 4,
				name : "Bounce Ball",
				maxlevel : 7,
				sprite : sBounceBall,
				thumb : sBounceBallThumb,
				mindmg : [10, 12, 12, 12, 12, 12, 17],
				maxdmg : [14, 16, 16, 16, 16, 16, 21],
				cooldown : [120, 120, 120, 120, 120, 102, 102],
				minimumcooldown : 102,
				shoots : [1, 1, 2, 2, 3, 3, 4],
				attackdelay : 5,
				hits : 10,
				hitCooldown : 30, 
				duration : 180,
				speed : 6,
				knockbackDuration : [0, 0, 5, 5, 5, 5, 5],
				knockbackSpeed : [0, 0, 3, 3, 3, 3, 3],
				size : 0.6,
				canBeHasted : true,
				type : "white",
				shotType : ShotTypes.Multishot,
				perk : false,
				unlocked : false,
				incompatibleEnchantments : [0, Enchantments.Size]
			});
	#endregion
	#region Cutting Board
	new_create_upgrade({
		func : cuttingboard_step,
				id : Weapons.CuttingBoard,
				name : "Cutting Board",
				maxlevel : 7,
				sprite : sCuttingBoard,
				thumb : sCuttingBoardThumb,
				mindmg : [11, 11, 14, 14, 23, 23, 23],
				maxdmg : [15, 15, 18, 18, 28, 28, 28],
				cooldown : [180, 180, 180, 180, 180, 150, 150],
				duration : 120, 
				hitCooldown : 20, 
				canBeHasted : true,
				speed : [7, 7, 7, 10, 10, 10, 10],
				hits : 9999,
				type : "white",
				shoots : [1, 1, 1, 1, 1, 1, 3],
				area : [1, 1.30, 1.30, 1.30, 1.30, 1.30, 1.30],
				size : [1, 1.30, 1.30, 1.30, 1.30, 1.30, 1.30],
				knockbackSpeed : 7,
				knockbackDuration : 20,				
				shotType : ShotTypes.Multishot,
				perk : false,
				weight : 2
			});
	#endregion
	#region Fan Beam
	new_create_upgrade({
		func : fanbeam_step,
				id : Weapons.FanBeam,
				name : "Fan Beam",
				weight : 3,
				maxlevel : 7,
				sprite : sFanBeam,
				thumb : sFanBeamThumb,
				mindmg : [27, 27, 27, 36, 36, 36, 36],
				maxdmg : [33, 33, 33, 44, 44, 44, 44],
				cooldown : [180, 180, 150, 150, 120, 120, 120],
				duration : 999, 
				hitCooldown : 60, 
				canBeHasted : true,
				speed : 0,
				hits : 9999,
				type : "white",
				shoots : [1, 1, 1, 1, 1, 1, 2],
				area : [1, 1.30, 1.30, 1.30, 1.30, 2, 2],
				knockbackSpeed : 15,
				knockbackDuration : 10,
				shotType : ShotTypes.Ranged,
				perk : false,
				unlocked : false
				//collabWith : Weapons.PlugAsaCoco
			});
	#endregion
	#region CEO Tears
	new_create_upgrade({
		func : ceotears_step,
				id : Weapons.CEOTears,
				weight : 2,
				name : "CEO's Tears",
				maxlevel : 7,
				sprite : sCeoTears,
				thumb : sCeoTearsThumb,
				mindmg : [8, 10, 10, 10, 12, 12, 12],
				maxdmg : [12, 14, 14, 14, 16, 16, 16],
				cooldown : [30, 30, 30, 20, 20, 10, 10],
				minimumcooldown : 1,
				shoots : [1, 1, 2, 2, 2, 2, 4],
				attackdelay : 1,
				hits : 1,
				hitCooldown : 30, 
				size : 0.9,
				duration : 90,
				speed : [4, 4, 4, 4, 5, 5, 5],
				knockbackDuration : 0,
				knockbackSpeed : 0,
				canBeHasted : true,
				type : "white",
				shotType : ShotTypes.Multishot,
				perk : false,
				unlocked : false,
			});
	#endregion
	#region EliteLavaBucket
		new_create_upgrade({ 
			func : lavabucket_step,
				id : Weapons.EliteLavaBucket,
				weight : 3,
				name : "Elite Lava Bucket",
				maxlevel : 7,
				sprite : sLavaPoolStart,
				thumb : sEliteLavaBucketThumb,
				mindmg : [6, 6, 6, 10, 14, 14, 14],
				maxdmg : [10, 10, 10, 14, 18, 18, 18],
				cooldown : 300,
				minimumcooldown : 1,
				shoots : [1, 1, 2, 2, 2, 3, 4],
				attackdelay : 5,
				hits : 9999,
				hitCooldown : 45, 
				duration : [180, 180, 180, 270, 270, 270, 270],
				speed : 0,
				knockbackDuration : 0,
				knockbackSpeed : 0,
				size : [.9, 1.1, 1.1, 1.1, 1.1, 1.1, 1.32],
				canBeHasted : true,
				type : "white",
				shotType : ShotTypes.Multishot,
				perk : false,
				incompatibleEnchantments : [0, Enchantments.Projectile]
				//collabWith : Weapons.PsychoAxe
			});
	#endregion
	#region EN's Curse
	new_create_upgrade({ 
		func : encurse_step,
			id : Weapons.ENsCurse,
			weight : 2,
			name : "EN's Curse",
			maxlevel : 7,
			sprite : sENCurse,
			thumb : sENCurseThumb,
			mindmg : [12, 12, 17, 17, 17, 17, 17],
			maxdmg : [16, 16, 21, 21, 21, 21, 21],
			cooldown : [110, 110, 110, 110, 110, 93, 93],
			minimumcooldown : 1,
			shoots : [1, 1, 1, 1, 2, 2, 3],
			attackdelay : 10,
			hits : 1,
			hitCooldown : 20, 
			duration : 90,
			speed : 7,
			knockbackDuration : 0,
			knockbackSpeed : 0,
			size : 1.5,
			range : [100, 100, 100, 125, 125, 125, 125],
			chance : [70, 80, 80, 80, 90, 90, 90],
			canBeHasted : true,
			type : "white",
			shotType : ShotTypes.Multishot,
			perk : false,
		});
	#endregion
	#region Holobomb
	new_create_upgrade({
		func : holobomb_step,
				id : Weapons.HoloBomb,
				name : "Holo Bomb",
				maxlevel : 7,
				weight : 3,
				sprite : sHolobomb,
				thumb : sHolobomb,
				mindmg : [15, 15, 15, 15, 15, 18, 18],
				maxdmg : [19, 19, 19, 19, 19, 22, 22],
				cooldown : [120, 120, 120, 120, 96, 96, 96],
				duration : 630,
				hitCooldown : 20, 
				canBeHasted : true,
				speed : 0,
				hits : 999,
				type : "white",
				shoots : [1, 1, 1, 2, 2, 2, 3],
				knockbackSpeed : 0,
				knockbackDuration : 0,
				shotType : ShotTypes.Multishot,
				perk : false,
				incompatibleEnchantments : [0, Enchantments.Projectile]
				//collabWith : Weapons.PlugAsaCoco
			});
		//Damage: 	170% (12 – 22)
		//Attack time: 	120 (2 s)
		//Attack count: 	1
		//Attack delay: 	5 (0.08 s)
		//Hit limit: 	-
		//Hit cooldown: 	20 (0.33 s)
		//Area: 	100%
		//Duration: 	630 (10.5 s)
		//Projectile speed: 	7 
		//Level 1 	A bomb that explodes, dealing damage to all nearby targets.
		//Level 2 	Increase explosion size by 15%.
		//Level 3 	Increase damage by 20%.
		//Level 4 	Throw 2 bombs.
		//Level 5 	Reduce the time between attacks by 20%.
		//Level 6 	Increase explosion size by 20%.
		//Level MAX 	Throw 3 bombs. 
	#endregion
	#region asacoco
	new_create_upgrade({ 
			func : asacoco_step,
				id : Weapons.PlugAsaCoco,
				weight : 4,
				name : "Plug Type Asacoco",
				maxlevel : 7,
				sprite : sAsaCocoShoot,
				thumb : sAsaCocoThumb,
				mindmg : [12, 15, 15, 20, 20, 20, 20],
				maxdmg : [16, 19, 19, 24, 24, 24, 24],
				cooldown : 150,
				minimumcooldown : 1,
				shoots : [1, 1, 2, 2, 3, 3, 4],
				attackdelay : 10,
				hits : 999,
				hitCooldown : 10, 
				duration : 45,
				speed : 20,
				knockbackDuration : [0, 0, 0, 0, 0, 15, 15],
				knockbackSpeed : [0, 0, 0, 0, 0, 7, 7],
				size : 1,
				canBeHasted : true,
				type : "white",
				shotType : ShotTypes.Multishot,
				afterimage : true,
				afterimageColor : c_yellow,
				perk : false,
				incompatibleEnchantments : [0, Enchantments.Size]
				//collabWith :[Weapons.FanBeam, Weapons.HoloBomb] 
			});
	#endregion
	#region SpiderCooking
		new_create_upgrade({
			func : spidercooking_step,
				id : Weapons.SpiderCooking,
				name : "Spider Cooking",
				maxlevel : 7,
				weight : 4,
				sprite : sSpiderCooking,
				thumb : sSpiderCookingThumb,
				mindmg : [7, 7, 10, 10, 10, 12, 12],
				maxdmg : [11, 11, 14, 14, 14, 16, 16],
				cooldown : 600,
				duration : 601, 
				hitCooldown : [45, 45, 45, 45, 36, 36, 36], 
				canBeHasted : false,
				speed : 0,
				hits : 9999,
				type : "white",
				shoots : [1, 1, 2, 2, 3, 3, 4],
				knockbackSpeed : [0, 0, 0, 0, 0, 0, 3],
				knockbackDuration : [0, 0, 0, 0, 0, 0, 8],
				perk : false,
				shotType : ShotTypes.Melee,
				size : [1, 1.15, 1.15, 1.40, 1.40, 1.40, 1.40],
				incompatibleEnchantments : [0, Enchantments.Cooldown]
			});
	#endregion
	#region Glowstick
			new_create_upgrade({
				func : glowstick_step,
				id : Weapons.Glowstick,
				name : "Glowstick",
				weight : 4,
				maxlevel : 7,
				sprite : sGlowstick,
				thumb : sGlowstickThumb,
				mindmg : [10, 12, 12, 12, 12, 17, 17],
				maxdmg : [14, 16, 16, 16, 16, 21, 21],
				explosionMinDmg : [16, 19, 19, 19, 19, 26, 26],
				explosionMaxDmg : [20, 24, 24, 24, 24, 32, 32],
				cooldown : 240,
				duration : 180, 
				hitCooldown : 30, 
				hitCooldownExplosion : 60, 
				canBeHasted : true,
				speed : 8,
				hits : [3, 3, 8, 8, 8, 8, 8],
				type : "white",
				shoots : [1, 1, 2, 2, 3, 3, 4],
				knockbackSpeed : 0,
				shotType : ShotTypes.Multishot,
				knockbackDuration : 0,
				perk : false,
			});
			#endregion
	#region Idol Song //TODO FIX THIS
			new_create_upgrade({
				func : idolsong_step,
				id : Weapons.IdolSong,
				name : "Idol Song",
				afterimage : true,
				afterimageColor : #ADD8E6,
				maxlevel : 7,
				weight : 3,
				sprite : sIdolSong,
				thumb : sIdolSongThumb,
				mindmg : [11, 14, 14, 14, 14, 14, 22],
				maxdmg : [15, 18, 18, 18, 18, 18, 27],
				cooldown : [200, 200, 200, 200, 160, 160, 160],
				duration : 150, 
				hitCooldown : 20, 
				canBeHasted : true,
				attackdelay : 1,
				speed : [1, 1, 1.2, 1.2, 1.2, 1.2, 1.2],
				hits : 999,
				type : "white",
				shoots : [2, 2, 2, 2, 2, 2, 2],
				knockbackSpeed : 0,
				knockbackDuration : 0,
				size : [1, 1, 1, 1.25, 1.25, 1.56, 1.56],
				travelWidth : [64, 64, 80, 64, 64, 64, 64],
				shotType : ShotTypes.Ranged,
				perk : false,
			});
			#endregion
	#region Psycho Axe
			new_create_upgrade({
				func : psychoaxe_step,
				id : Weapons.PsychoAxe,
				name : "Psycho Axe",
				maxlevel : 7,
				sprite : sPsychoAxe,
				thumb : sPsychoAxeThumb,
				mindmg : [10, 14, 14, 19, 19, 19, 28],
				maxdmg : [14, 18, 18, 23, 23, 23, 34],
				cooldown : [240, 240, 192, 192, 192, 192, 192],
				duration : [180, 180, 180, 180, 240, 240, 240],
				hitCooldown : 50, 
				canBeHasted : true,
				speed : 0,
				hits : [10, 10, 10, 10, 999, 999, 999],
				type : "white",
				shoots : [2, 2, 2, 2, 2, 4, 4],
				size : [1, 1.20, 1.20, 1.44, 1.44, 2.16, 2.16],
				knockbackSpeed : 0,
				knockbackDuration : 0,
				perk : false,
				shotType : ShotTypes.Ranged,
				afterimage : true,
				afterimageColor : #ADD8E6,
				weight : 3
				//collabWith : [Weapons.BlBook, Weapons.EliteLavaBucket]
			});
	#endregion
	#region Wamy Water
			new_create_upgrade({
				func : wamywater_step,
				id : Weapons.WamyWater,
				name : "Wamy Water",
				maxlevel : 7,
				weight : 3,
				sprite : sWamyWater,
				thumb : sWamyWaterThumb,
				mindmg : [9, 9, 9, 9, 9, 15, 15],
				maxdmg : [13, 13, 13, 13, 13, 19, 19],
				cooldown : [120, 120, 120, 120, 96, 96, 96],
				duration : 999,
				hitCooldown : 30, 
				canBeHasted : true,
				speed : 0,
				hits : 999,
				type : "white",
				shoots : 1,
				shotType : ShotTypes.Melee,
				knockbackSpeed : [5, 5, 5, 8, 8, 8 ,8],
				knockbackDuration : 10,
				perk : false,
				unlocked : false,
			});
	#endregion
	#region XPotato
	new_create_upgrade({
		func : xpotato_step,
				id : Weapons.XPotato,
				weight : 2,
				name : "X-Potato",
				maxlevel : 7,
				sprite : sXPotato,
				thumb : sXPotatoThumb,
				mindmg : [7, 7, 7, 12, 12, 12, 12],
				maxdmg : [11, 11, 11, 16, 16, 16, 16],
				mindmgExplosion : [16, 16, 16, 26, 26, 26, 26],
				maxdmgExplosion : [20, 20, 20, 31, 31, 31, 31],
				cooldown : [210, 210, 210, 210, 127, 127, 127],
				minimumcooldown : 1,
				shoots : [1, 1, 2, 2, 2, 2, 4],
				attackdelay : 5,
				hits : [10, 10, 10, 10, 9999, 9999, 9999],
				hitCooldown : 20,
				duration : 180,
				speed : [5, 5, 5, 6.5, 6.5, 6.5, 6.5],
				knockbackDuration : 0,
				knockbackSpeed : 0,
				size : [1, 1, 1, 1, 1, 1.30, 1.30],
				explosionSize : [.8, 1, 1, 1, 1, 1.30, 1.30],
				canBeHasted : true,
				type : "white",
				shotType : ShotTypes.Multishot,
				perk : false,
			});
	new_create_upgrade({
				id : Weapons.XPotatoExplosion,
				name : "XPotatoExplosion",
				maxlevel : 7,
				sprite : sXPotatoExplosion,
				thumb : sBombExplosion,
				mindmg : [16, 16, 16, 26, 26, 26, 26],
				maxdmg : [20, 20, 20, 31, 31, 31, 31],
				cooldown : 0,
				duration : 100, 
				attackdelay : 20,
				hitCooldown : 10, 
				canBeHasted : true,
				speed : 0,
				hits : 999,
				type : "red",
				shoots : 1,
				knockbackSpeed : 0,
				knockbackDuration : 0,
				perk : true,
				characterid : Characters.Lenght
			});
	#endregion
	#region Collabs
	#region MiComet
	new_create_upgrade({ 
		func : micomet_step,
				id : Weapons.MiComet,
				collab : true,
				weight : 0,
				name : "MiComet",
				maxlevel : 1,
				sprite : sBlank,
				thumb : sMiCometThumb,
				mindmg : 0,
				maxdmg : 0,
				cooldown : 60,
				minimumcooldown : 5,
				shoots : 1,
				attackdelay : 0,
				hits : 99999,
				hitCooldown : 0, 
				duration : 100,
				speed : 0,
				knockbackDuration : 0,
				knockbackSpeed : 0,
				size : 1,
				canBeHasted : true,
				type : "white",
				shotType : ShotTypes.Ranged,
				perk : false,
			});
	new_create_upgrade({ 
				id : Weapons.MiCometMeteor,
				collab : true,
				weight : 0,
				name : "MiComet",
				maxlevel : 1,
				sprite : sMiComet,
				thumb : sMiCometThumb,
				mindmg : 45,
				maxdmg : 55,
				cooldown : 60,
				minimumcooldown : 5,
				shoots : 1,
				attackdelay : 0,
				hits : 99999,
				hitCooldown : 60, 
				duration : 9999,
				speed : 0,
				knockbackDuration : 0,
				knockbackSpeed : 0,
				size : 2,
				canBeHasted : true,
				type : "white",
				shotType : ShotTypes.Ranged,
				perk : false,
			});
	new_create_upgrade({ 
				id : Weapons.MiCometPool,
				collab : true,
				weight : 0,
				name : "MiComet",
				maxlevel : 1,
				sprite : sLavaPoolStart,
				thumb : sMiComet,
				mindmg : 19,
				maxdmg : 23,
				cooldown : 60,
				minimumcooldown : 5,
				shoots : 1,
				attackdelay : 0,
				hits : 99999,
				hitCooldown : 15, 
				duration : 120,
				speed : 0,
				knockbackDuration : 0,
				knockbackSpeed : 0,
				size : 3,
				canBeHasted : true,
				type : "white",
				shotType : ShotTypes.Ranged,
				perk : false,
			});
	#endregion
	#region BLFujoshi
	new_create_upgrade({ 
		func : blfujoshi_step,
				id : Weapons.BLFujoshi,
				collab : true,
				weight : 0,
				name : "BL Fujoshi",
				maxlevel : 1,
				sprite : sBlank,
				thumb : sBLFujoshiThumb,
				mindmg : -1,
				maxdmg : -1,
				cooldown : 109,
				minimumcooldown : 110,
				shoots : 1,
				attackdelay : 0,
				hits : 99999,
				hitCooldown : 0, 
				duration : 110,
				speed : 0,
				knockbackDuration : 0,
				knockbackSpeed : 0,
				size : 1,
				canBeHasted : true,
				type : "white",
				shotType : ShotTypes.Melee,
				perk : false,
			});
	new_create_upgrade({ 
		func : blfujoshiaxe_step,
				id : Weapons.BLFujoshiAxe,
				collab : true,
				weight : 0,
				name : "",
				maxlevel : 1,
				sprite : sPsychoAxe,
				thumb : sMiCometThumb,
				mindmg : 11,
				maxdmg : 15,
				cooldown : 0,
				minimumcooldown : 0,
				shoots : 2,
				attackdelay : 0,
				hits : 99999,
				hitCooldown : 20, 
				duration : 110,
				speed : 0,
				knockbackDuration : 0,
				knockbackSpeed : 0,
				size : 2,
				canBeHasted : true,
				type : "white",
				afterimage : true,
				afterimageColor : c_yellow,
				shotType : ShotTypes.Melee,
				perk : false,
			});
	new_create_upgrade({ 
		func : blfujoshibook_step,
				id : Weapons.BLFujoshiBook,
				collab : true,
				weight : 0,
				name : "",
				maxlevel : 1,
				sprite : sBLFujoshiBook,
				thumb : sMiComet,
				mindmg : 3,
				maxdmg : 7,
				cooldown : 60,
				minimumcooldown : 5,
				shoots : 6,
				attackdelay : 0,
				hits : 99999,
				hitCooldown : 40, 
				duration : 110,
				speed : 0,
				knockbackDuration : 0,
				knockbackSpeed : 0,
				size : 1.5,
				canBeHasted : true,
				type : "white",
				afterimage : true,
				afterimageColor : c_blue,
				shotType : ShotTypes.Melee,
				perk : false,
			});
	#endregion
	#region Bone Bros
	new_create_upgrade({ 
		func : bonebros_step,
				id : Weapons.BoneBros,
				collab : true,
				weight : 0,
				name : "Bone Bros",
				maxlevel : 1,
				sprite : sBlank,
				thumb : sBoneBrosThumb,
				mindmg : -1,
				maxdmg : -1,
				cooldown : 60,
				minimumcooldown : 20,
				shoots : 1,
				attackdelay : 1,
				hits : 99999,
				hitCooldown : 1,
				duration : 30,
				speed : 0,
				knockbackDuration : 0,
				knockbackSpeed : 0,
				size : 1,
				canBeHasted : true,
				type : "white",
				shotType : ShotTypes.Multishot,
				perk : false,
			});
	new_create_upgrade({ 
		func : bonebros_slash_step,
				id : Weapons.BoneBrosSlash,
				collab : true,
				weight : 0,
				name : "",
				maxlevel : 1,
				sprite : sBoneBrosSlash,
				thumb : sBlank,
				mindmg : 18,
				maxdmg : 22,
				cooldown : 0,
				minimumcooldown : 0,
				shoots : 1,
				attackdelay : 0,
				hits : 99999,
				hitCooldown : 30,
				duration : 110,
				speed : 15,
				knockbackDuration : 0,
				knockbackSpeed : 0,
				size : 1.5,
				canBeHasted : true,
				type : "white",
				afterimage : true,
				afterimageColor : c_red,
				shotType : ShotTypes.Multishot,
				perk : false,
			});
	new_create_upgrade({ 
		func : bonebros_bullet_step,
				id : Weapons.BoneBrosBullet,
				collab : true,
				weight : 0,
				name : "",
				maxlevel : 1,
				sprite : sDouglasShoot,
				thumb : sBlank,
				mindmg : 16,
				maxdmg : 20,
				cooldown : 0,
				minimumcooldown : 0,
				shoots : 1,
				attackdelay : 0,
				hits : 99999,
				hitCooldown : 30,
				duration : 110,
				speed : 15,
				knockbackDuration : 0,
				knockbackSpeed : 0,
				size : 1.25,
				canBeHasted : true,
				type : "white",
				afterimage : true,
				afterimageColor : c_purple,
				shotType : ShotTypes.Multishot,
				perk : false,
			});
	#endregion
	#region Eldritch Horror
	new_create_upgrade({ 
		func : eldritchhorror_step,
				id : Weapons.EldritchHorror,
				collab : true,
				weight : 0,
				name : "Eldritch Horror",
				maxlevel : 1,
				sprite : sEldricthHorrorPool,
				thumb : sEldricthHorrorThumb,
				mindmg : 18,
				maxdmg : 22,
				cooldown : 390,
				minimumcooldown : 120,
				shoots : 1,
				attackdelay : 0,
				hits : 9999,
				hitCooldown : 30,
				duration : 240,
				speed : 0,
				knockbackDuration : 0,
				knockbackSpeed : 0,
				size : 3.5,
				canBeHasted : true,
				type : "white",
				shotType : ShotTypes.Ranged,
				perk : false,
			});
	#endregion
	#region Absolute Wall
	new_create_upgrade({ 
		func : absolutewall_step,
				id : Weapons.AbsoluteWall,
				collab : true,
				weight : 0,
				name : "Absolute Wall",
				maxlevel : 1,
				sprite : sAbsoluteWall,
				thumb : sAbsoluteWallIThumb,
				mindmg : 25,
				maxdmg : 31,
				cooldown : 599,
				minimumcooldown : 600,
				shoots : 5,
				attackdelay : 1,
				hits : 99999,
				hitCooldown : 30, 
				duration : 600,
				speed : 0,
				knockbackDuration : 15,
				knockbackSpeed : 16,
				size : 2,
				canBeHasted : false,
				type : "white",
				shotType : ShotTypes.Ranged,
				perk : false,
				afterimage : true,
				afterimageColor : c_blue,
			});
	#endregion
	#region Breathe-in Type Asacoco
	new_create_upgrade({ 
		func : breatheintypeasacoco_step,
				id : Weapons.BreatheInTypeAsacoco,
				weight : 0,
				collab : true,
				name : "Breathe-In Type Asacoco",
				maxlevel : 1,
				sprite : sBreathAsacoco,
				thumb : sBreathAsacocoThumb,
				mindmg : 22,
				maxdmg : 26,
				cooldown : 45,
				minimumcooldown : 20,
				shoots : 5,
				attackdelay : 5,
				hits : 9999,
				hitCooldown : 20,
				duration : 9999,
				speed : 0,
				knockbackDuration : 0,
				knockbackSpeed : 0,
				size : 2,
				canBeHasted : true,
				type : "white",
				shotType : ShotTypes.Multishot,
				perk : false,
			});
	#endregion
	#region Elite Cooking
	new_create_upgrade({ 
		func : elitecooking_step,
		id : Weapons.EliteCooking,
		weight : 0,
		collab : true,
		name : "Elite Cooking",
		maxlevel : 1,
		sprite : sSpiderCooking,
		thumb : sEliteCookingThumb,
		mindmg : 5,
		maxdmg : 9,
		cooldown : 35,
		minimumcooldown : 10,
		shoots : 1,
		attackdelay : 1,
		hits : 9999,
		hitCooldown : 30,
		duration : 300,
		speed : 0,
		knockbackDuration : 0,
		knockbackSpeed : 0,
		size : 2,
		canBeHasted : true,
		type : "white",
		shotType : ShotTypes.Ranged,
		perk : false,
	});
	#endregion
	#region Ring of Fitness
	new_create_upgrade({ 
		func : ringoffitness_step,
		id : Weapons.RingOfFitness,
		weight : 0,
		collab : true,
		name : "Ring of Fitness",
		maxlevel : 1,
		sprite : sBounceBall,
		thumb : sFitnessRingThumb,
		mindmg : 18,
		maxdmg : 22,
		cooldown : 75,
		minimumcooldown : 10,
		shoots : 15,
		attackdelay : 1,
		hits : 9999,
		hitCooldown : 30,
		duration : 300,
		speed : 10,
		knockbackDuration : 0,
		knockbackSpeed : 0,
		size : 0.60,
		canBeHasted : true,
		type : "white",
		shotType : ShotTypes.Multishot,
		perk : false,
	});
	#endregion
	#region Stream of Tears
	new_create_upgrade({
		func : streamoftears_step,
		id : Weapons.StreamOfTears,
		weight : 0,
		collab : true,
		name : "Stream of Tears",
		maxlevel : 1,
		sprite : sStreamOfTears,
		thumb : sStreamOfTearsThumb,
		mindmg : 25,
		maxdmg : 30,
		cooldown : 360,
		minimumcooldown : 360,
		shoots : 2,
		attackdelay : 1,
		hits : 9999,
		hitCooldown : 30,
		duration : 360,
		speed : 0,
		knockbackDuration : 0,
		knockbackSpeed : 0,
		size : 1,
		sizeX : 1.30,
		sizeY : 4,
		canBeHasted : false,
		type : "white",
		shotType : ShotTypes.Multishot,
		perk : false,
	});
	#endregion
	#region I'm Die
	new_create_upgrade({ 
		func : imdie_step,
		id : Weapons.ImDie,
		weight : 0,
		collab : true,
		name : "I'm Die, Thank You Forever",
		maxlevel : 1,
		sprite : sImDie,
		thumb : sImDieThumb,
		mindmg : 8,
		maxdmg : 12,
		cooldown : 180,
		minimumcooldown : 60,
		shoots : 1,
		attackdelay : 1,
		hits : 1,
		hitCooldown : 30,
		duration : 300,
		speed : 15,
		knockbackDuration : 0,
		knockbackSpeed : 0,
		size : 1.5,
		canBeHasted : true,
		type : "white",
		shotType : ShotTypes.Ranged,
		perk : false,
	});
	new_create_upgrade({ 
		func : imdieexplosion_step,
		id : Weapons.ImDieExplosion,
		weight : 0,
		collab : true,
		name : "I'm Die, Thank You ForeverEx",
		maxlevel : 1,
		sprite : sImDieExplosion,
		thumb : sImDieThumb,
		mindmg : 27,
		maxdmg : 33,
		cooldown : 180,
		minimumcooldown : 60,
		shoots : 1,
		attackdelay : 1,
		hits : 9999,
		hitCooldown : 30,
		duration : 95,
		speed : 0,
		knockbackDuration : 10,
		knockbackSpeed : 10,
		size : 1,
		canBeHasted : true,
		type : "white",
		shotType : ShotTypes.Ranged,
		perk : false,
	});
	#endregion
	#endregion
	#region Modded
	#region Pipkin Pippa
	new_create_upgrade({
		func : pipipistol_step,
		id : Weapons.PipiPilstol,
		name : "PiPiPilstols",
		maxlevel : 6,
		sprite : sBulletPink,
		thumb : sRifle,
		mindmg : [7, 7, 7*1.25, 7*1.25, 7*1.25*1.50, 7*1.25*1.50*1.75],
		maxdmg : [13, 13, 13*1.25, 13*1.25, 13*1.25, 13*1.20*1.40, 13*1.20*1.40],
		cooldown : [80, 80, 80, 80*0.75, 80*0.75, 30],
		duration : [120, 120, 120, 120, 120, 120, 120], 
		hitCooldown : [10, 10, 10, 10, 10, 10, 10], 
		canBeHasted : true,
		attackdelay : 10,
		speed : 5,
		hits : [1, 1, 2, 3, 3, 3],
		type : "red",
		shoots : [2, 4, 4, 4, 4, 4],
		knockbackSpeed : [0, 0, 0, 0, 0, 0, 0],
		knockbackDuration : [0, 0, 0, 0, 0, 0, 0],
		perk : true,
		characterid : Characters.Pippa,
		weight : 3
	},[snd_bullet, snd_bullet2, snd_bullet3]);
	new_create_upgrade({
		func : heavyartillery_step,
		id : Weapons.HeavyArtillery,
		name : "Heavy Artillery",
		maxlevel : 3,
		sprite : sBombExplosion,
		thumb : sRifle,
		mindmg : 0,
		maxdmg : 0,
		cooldown : [180, 174, 174],
		duration : 100, 
		attackdelay : 20,
		hitCooldown : 10, 
		canBeHasted : true,
		speed : 0,
		hits : 100,
		type : "red",
		shoots : [1, 1, 2],
		knockbackSpeed : [0, 0, 0, 0, 0, 0, 0],
		knockbackDuration : [0, 0, 0, 0, 0, 0, 0],
		perk : true,
		characterid : Characters.Null
	});
	new_create_upgrade({
		func : mold_step,
		id : Weapons.Mold,
		name : "mold",
		maxlevel : 1,
		sprite : sMoldSpread,
		thumb : sRifle,
		mindmg : 0,
		maxdmg : 0,
		cooldown : [180, 174, 174],
		duration : 100, 
		attackdelay : 20,
		hitCooldown : 10, 
		canBeHasted : true,
		speed : 0,
		hits : 100,
		type : "red",
		shoots : 1,
		knockbackSpeed : [0, 0, 0, 0, 0, 0, 0],
		knockbackDuration : [0, 0, 0, 0, 0, 0, 0],
		perk : true,
		characterid : Characters.Null
	});
	#endregion
	#endregion
	#endregion
}


#region Collabs
//global.collabs = array_create(Weapons.Length);
global.collabs = [];
#macro Collabs global.collabs
Collabs[Weapons.MiComet] = [Weapons.EliteLavaBucket, Weapons.PsychoAxe];
Collabs[Weapons.EldritchHorror] = [Weapons.ENsCurse, Weapons.SpiderCooking];
Collabs[Weapons.AbsoluteWall] = [Weapons.CuttingBoard, Weapons.BounceBall];
Collabs[Weapons.BLFujoshi] = [Weapons.BlBook, Weapons.PsychoAxe];
Collabs[Weapons.BoneBros] = [Weapons.ENsCurse, Weapons.CuttingBoard];
Collabs[Weapons.BreatheInTypeAsacoco] = [Weapons.PlugAsaCoco, Weapons.HoloBomb];
Collabs[Weapons.EliteCooking] = [Weapons.EliteLavaBucket, Weapons.SpiderCooking];
Collabs[Weapons.RingOfFitness] = [Weapons.BounceBall, Weapons.CEOTears];
Collabs[Weapons.StreamOfTears] = [Weapons.FanBeam, Weapons.CEOTears];
Collabs[Weapons.ImDie] = [Weapons.XPotato, Weapons.HoloBomb];
function populate_collabs(){
	for (var i = 0; i < array_length(Collabs); ++i) {
	    if (is_array(Collabs[i])) {
			for (var j = 1; j < array_length(WEAPONS_LIST[Collabs[i][0]]); ++j) {
				if (!variable_struct_exists(WEAPONS_LIST[Collabs[i][0]][j], "collabWith")) { WEAPONS_LIST[Collabs[i][0]][j][$ "collabWith"] = []; }
				if (!is_array(WEAPONS_LIST[Collabs[i][0]][j][$ "collabWith"])) { WEAPONS_LIST[Collabs[i][0]][j][$ "collabWith"] = []; }
				array_push(WEAPONS_LIST[Collabs[i][0]][j][$ "collabWith"], Collabs[i][1]);   
			}
			for (var j = 1; j < array_length(WEAPONS_LIST[Collabs[i][1]]); ++j) {
				if (!variable_struct_exists(WEAPONS_LIST[Collabs[i][1]][j], "collabWith")) { WEAPONS_LIST[Collabs[i][1]][j][$ "collabWith"] = []; }
				if (!is_array(WEAPONS_LIST[Collabs[i][1]][j][$ "collabWith"])) { WEAPONS_LIST[Collabs[i][1]][j][$ "collabWith"] = []; }
				array_push(WEAPONS_LIST[Collabs[i][1]][j][$ "collabWith"], Collabs[i][0]);   
			}
		}
	}
}
#endregion
//generate random list of possible upgrades
function random_upgrades(){
	random_set_seed(current_time);
	name="";
	
	#region Generate the lists
		//function generateLists() {
		weaponsList = [];
		itemsList = [];
		perksList = [];
	
		#region Weapons List
		var _maxWeapons = array_length(UPGRADES);
		var _spaceAvaliable = UPGRADES[_maxWeapons -1] == global.null ? true : false;
		var _maxed, _found, _canBeUnlocked, _unlocked, _isCollab, _currentWeaponOnList, _currentWeapon, _perkWeapon, _belongsToCharacter;
		for (var i = 0; i < array_length(WEAPONS_LIST); ++i) {
			_currentWeaponOnList = WEAPONS_LIST[i][1];
			_maxed = false;
			_found = false;
			_isCollab = variable_struct_exists(WEAPONS_LIST[i][1], "collab");
			_belongsToCharacter = false;
			_perkWeapon = variable_struct_exists(_currentWeaponOnList, "characterid");
			if (_perkWeapon) { _belongsToCharacter = _currentWeaponOnList.characterid == global.player[? "id"]; }
			_unlocked = false;
			_canBeUnlocked = variable_struct_exists(_currentWeaponOnList, "unlocked");
			if (_canBeUnlocked) { _unlocked = _currentWeaponOnList.unlocked; }
			if ((_canBeUnlocked and !_unlocked) or (_perkWeapon and !_belongsToCharacter) or _isCollab) { continue; }
			for (var j = 0; j < _maxWeapons; ++j) {
				_currentWeapon = UPGRADES[j];
				_found = _currentWeapon.id == _currentWeaponOnList.id ? true : false;
				_maxed = _currentWeapon.level == _currentWeapon.maxlevel ? true : false;
				if (_found) {
					break;
				}
			}
			if ((_found and !_maxed) or (!_found and _spaceAvaliable)) {
				repeat (_currentWeaponOnList.weight) {
					array_push(weaponsList, WEAPONS_LIST[i]);
				}
			}
		}
		
		#endregion
	
		#region Items
			if (playerItems[5] == global.nullitem) {
				for (var i = 0; i < array_length(ItemList); ++i) {
					if (variable_struct_exists(ItemList[i][1], "unlocked") and !ItemList[i][1][$ "unlocked"]) {
					    break;
					}
					var maxed = false;
					var found = false;
					for (var j = 0; j < array_length(playerItems); ++j) {
						if (playerItems[j][$ "name"] == ItemList[i][1][$ "name"]) {
							found = true;
						    if (playerItems[j][$ "level"] != ItemList[i][1][$ "maxlevel"]){
								maxed = false;
							}
							else maxed = true;
						}
						//else {array_push(ups, global.upgradesAvaliable[i]);}
					}	    
					if (found) {
					    if (!maxed) {
							for (var k = 0; k < ItemList[i][1][$ "weight"]; ++k) {
							    array_push(itemsList, ItemList[i]);
							}				    
						}
					} else {
						for (var k = 0; k < ItemList[i][1][$ "weight"]; ++k) {
							    array_push(itemsList, ItemList[i]);
							}
						}
				}
				//var str = "";
				//for (var i = 0; i < array_length(items_list); ++i) {
				//    str = str + " : " + items_list[i][1][$ "name"];
				//}
				//show_message(str);
			}else{
				for (var i = 0; i < array_length(playerItems); ++i) {
				    if (playerItems[i][$ "level"] != playerItems[i][$ "maxlevel"]) {
					    for (var k = 0; k < ItemList[playerItems[i][$ "id"]][1][$ "weight"]; ++k) {
							    array_push(itemsList, ItemList[playerItems[i][$ "id"]]);
						}
					}
				}
			}
		#endregion
	
		#region Perks
			for (var i = 0; i < array_length(PERK_LIST); ++i) {
				if (PERK_LIST[i][0][$ "characterid"] == global.player[?"id"]) {
				    //	array_push(ups, PERK_LIST[i]);
					var maxed = false;
					var found = false;
					//feather disable once GM1041
					for (var j = 0; j < array_length(PLAYER_PERKS); ++j) {
						if (PLAYER_PERKS[j][$ "name"] == PERK_LIST[i][1][$ "name"]) {
							found = true;
						    if (PLAYER_PERKS[j][$ "level"] != PERK_LIST[i][1][$ "maxlevel"]){
								maxed = false;
							}
							else maxed = true;
						}
						//else {array_push(ups, global.upgradesAvaliable[i]);}
					}	    
					if (found) {
					    if (!maxed) {
						    array_push(perksList, PERK_LIST[i]);	
						}
					} else {array_push(perksList, PERK_LIST[i]);}
					//show_debug_message("Added: " + string( PERK_LIST[i][0][$ "name"]));
				}	    
			}
		#endregion
		
	#endregion
	#region Generate the options
		isWhat = "";
		var canBeItem;
		var canBeWeapon;
		var canBePerk;
		#region 1&2
			function slotRandomizer12() {
				// randomize;
				isWhat = "";
				canBeWeapon = false;
				//feather disable once GM1041
				for (var i = 0; i < array_length(UPGRADES); ++i) {
					if (UPGRADES[i][$ "level"] != UPGRADES[i][$ "maxlevel"] or UPGRADES[i] == global.null) {
						canBeWeapon = true;
					}
				}
				
				canBeItem = false;
				for (var i = 0; i < array_length(playerItems); ++i) {
					//show_message(string(playerItems[i][$ "level"]) + ":" + string(playerItems[i][$ "maxlevel"]));
					if (playerItems[i][$ "level"] != playerItems[i][$ "maxlevel"] or playerItems[i] == global.nullitem) {
						canBeItem = true;
					}
				}
				
				canBePerk = false;
				for (var i = 0; i < array_length(PLAYER_PERKS); ++i) {
					if (PLAYER_PERKS[i][$ "level"] != PLAYER_PERKS[i][$ "maxlevel"]) {
						canBePerk = true;
					}
				}
				
				do {
					if (irandom_range(1,9) <= 4) {
					    isWhat = ItemTypes.Weapon;
					}else if (irandom_range(1,9) == 1) {
					    isWhat = ItemTypes.Item;
					}else if (irandom_range(1,18) == 1) {
							     isWhat = ItemTypes.Item; //TODO: change to stat-up
					}else if (irandom_range(1,18) <= 7) {
							     isWhat = ItemTypes.Perk;
					}
				} until (isWhat != "");
				// show_debug_message("type: {0}, weapon : {1}, array : {2}", is_what, can_be_weapon, array_length(weapons_list));
				if (isWhat == ItemTypes.Weapon and !canBeWeapon or isWhat == ItemTypes.Weapon and array_length(weaponsList) == 0) {
				    isWhat = ItemTypes.Item;
				}
				if (isWhat == ItemTypes.Item and !canBeItem or isWhat == ItemTypes.Item and array_length(itemsList) == 0) {
					isWhat = "null";
				    //TODO: change item type to statup
				}
				if (isWhat == ItemTypes.Perk and !canBePerk) {
				isWhat = "null";
			    //TODO: change item type to statup
				}
			}
			var rdn = 0;
			
			#region fill slot 1 & 2
				var m = 0;
				repeat (2) {
				    slotRandomizer12();
					switch (isWhat) {
					    case ItemTypes.Weapon:{
							rdn = irandom_range(0,array_length(weaponsList)-1);
					        global.upgradeOptions[m] = weaponsList[rdn][1];
							var maxI = array_length(weaponsList);
							var weapon_name = weaponsList[rdn][1][$ "id"];
							for (var i = maxI - 1; i >= 0; --i) {
							    if (weaponsList[i][1][$ "id"] == weapon_name) {
								    array_delete(weaponsList, i, 1);
								}
							}
					        break;}
						case ItemTypes.Item:{
							rdn = irandom_range(0,array_length(itemsList)-1);
					        global.upgradeOptions[m] = itemsList[rdn][1];
							var item_name = itemsList[rdn][1][$ "id"];
							var maxI = array_length(itemsList);
							for (var i = 0; i < maxI; ++i) {
							    if (itemsList[i][1][$ "id"] == item_name) {
								    array_delete(itemsList, i, 1);
									maxI = array_length(itemsList);
									i=0;
								}
							}
					        break;}
						case ItemTypes.Perk:{
							if (array_length(perksList) > 0) {
							    rdn = irandom_range(0,array_length(perksList)-1);
								global.upgradeOptions[m] = perksList[rdn][1];
								array_delete(perksList, rdn, 1);
							}else{
								global.upgradeOptions[m] = global.null; //TODO Change to statup
							}
					        break;}				
						case "null":{
					        global.upgradeOptions[m] = global.null;
					        break;}
						}
						m++;
					}				
			#endregion
		#endregion
		
		#region 3
			function slotRandomizer3() {
				// randomize;
				isWhat = "";
				canBeWeapon = false;
				//feather disable once GM1041
				for (var i = 0; i < array_length(UPGRADES); ++i) {
					if (UPGRADES[i][$ "level"] != UPGRADES[i][$ "maxlevel"] or UPGRADES[i] == global.null) {
						canBeWeapon = true;
					}
				}
				
				canBeItem = false;
				for (var i = 0; i < array_length(playerItems); ++i) {
					if (playerItems[i][$ "level"] != playerItems[i][$ "maxlevel"] or playerItems[i] == global.nullitem) {
						canBeItem = true;
					}
				}
				
				canBePerk = false;
				for (var i = 0; i < array_length(PLAYER_PERKS); ++i) {
					if (PLAYER_PERKS[i][$ "level"] != PLAYER_PERKS[i][$ "maxlevel"]) {
						canBePerk = true;
					}
				}
				repeat (5) {
				    do {
						if (irandom_range(1,5) <= 2) {
						    isWhat = ItemTypes.Weapon;
						}else if (irandom_range(1,2) == 1) {
						    isWhat = ItemTypes.Item;
						}else if (irandom_range(1,10) == 1) {
								     isWhat = ItemTypes.Perk;
						}
					} until (isWhat != "");
					if (isWhat == ItemTypes.Weapon and !canBeWeapon or array_length(weaponsList) == 0) {
					    isWhat = ItemTypes.Item;
					}
					if (isWhat == ItemTypes.Item and !canBeItem or array_length(itemsList) == 0) {
						isWhat = ItemTypes.Perk;
					}
					if (isWhat == ItemTypes.Perk and !canBePerk) {
					isWhat = "null";
					}
					if (isWhat != "null") {
					    break;
					}
				}
				if (isWhat == "null") {
				    isWhat = "food";
				}
			}
			rdn = 0;
			slotRandomizer3();
			#region fill slot 3
			//is_what = ItemTypes.Item;
			//show_message(string(can_be_item) + ":" + string(can_be_perk) + ":" + string(can_be_weapon) + ":" + string(is_what));
				switch (isWhat) {
				    case ItemTypes.Weapon:{
						rdn = irandom_range(0,array_length(weaponsList)-1);
				        global.upgradeOptions[2] = weaponsList[rdn][1];
						var maxI = array_length(weaponsList);
						var weapon_name = weaponsList[rdn][1][$ "id"];
						for (var i = maxI - 1; i >= 0; --i) {
							if (weaponsList[i][1][$ "id"] == weapon_name) {
								array_delete(weaponsList, i, 1);
							}
						}
				        break;}
					case ItemTypes.Item:{
				        rdn = irandom_range(0,array_length(itemsList)-1);
				        global.upgradeOptions[2] = itemsList[rdn][1];
						var item_name = itemsList[rdn][1][$ "id"];
							var maxI = array_length(itemsList);
							for (var i = 0; i < maxI; ++i) {
							    if (itemsList[i][1][$ "id"] == item_name) {
								    array_delete(itemsList, i, 1);
									maxI = array_length(itemsList);
									i=0;
								}
							}
				        break;}
					case ItemTypes.Perk:{
				        if (array_length(perksList) > 0) {
							    rdn = irandom_range(0,array_length(perksList)-1);
								global.upgradeOptions[2] = perksList[rdn][1];
								array_delete(perksList, rdn, 1);
							}else{
								global.upgradeOptions[2] = ItemList[ItemIds.Hamburguer][1];
							}
					        break;}				
					case "food":{
				        global.upgradeOptions[2] = ItemList[ItemIds.Hamburguer][1];
				        break;}
					}
			#endregion		
		#endregion
		
		#region 4
			function slotRandomizer4() {
				// randomize;
				isWhat = "";
				canBeWeapon = false;
				// feather disable once GM1041
				for (var i = 0; i < array_length(UPGRADES); ++i) {
					if (UPGRADES[i][$ "level"] != UPGRADES[i][$ "maxlevel"] or UPGRADES[i] == global.null or playerItems[i] == global.nullitem) {
						canBeWeapon = true;
					}
				}
				
				canBeItem = false;
				// feather disable once GM1041
				for (var i = 0; i < array_length(playerItems); ++i) {
					if (playerItems[i][$"level"] != playerItems[i][$"maxlevel"] or playerItems[i] == global.nullitem) {
						canBeItem = true;
					}
				}
				repeat (5) {
				    do {
						if (irandom_range(1,2) == 1) {
						    isWhat = ItemTypes.Weapon;
						}else if (irandom_range(1,2) == 1) {
						    isWhat = ItemTypes.Item;
						}
					} until (isWhat != "");
					if (isWhat == ItemTypes.Weapon and !canBeWeapon or array_length(weaponsList) == 0) {
					    isWhat = ItemTypes.Item;
					}
					if (isWhat == ItemTypes.Item and !canBeItem or array_length(itemsList) == 0) {
						isWhat = "null";
					}
					if (isWhat != "null") {
					    break;
					}
				}
				if (isWhat == "null") {
				    isWhat = "holocoin";
				}
			}
			rdn = 0;
			slotRandomizer4();
			#region fill slot 4
			//is_what = ItemTypes.Item;
			//show_message(string(can_be_item) + ":" + string(can_be_perk) + ":" + string(can_be_weapon) + ":" + string(is_what));
				switch (isWhat) {
				    case ItemTypes.Weapon:{
						rdn = irandom_range(0,array_length(weaponsList)-1);
				        global.upgradeOptions[3] = weaponsList[rdn][1];
						var maxI = array_length(weaponsList);
						var weapon_name = weaponsList[rdn][1][$ "id"];
						for (var i = maxI - 1; i >= 0; --i) {
							if (weaponsList[i][1][$ "id"] == weapon_name) {
								array_delete(weaponsList, i, 1);
							}
						}
				        break;}
					case ItemTypes.Item:{
				        rdn = irandom_range(0,array_length(itemsList)-1);
				        global.upgradeOptions[3] = itemsList[rdn][1];
						var item_name = itemsList[rdn][1][$"id"];
							var maxI = array_length(itemsList);
							for (var i = 0; i < maxI; ++i) {
							    if (itemsList[i][1][$"id"] == item_name) {
								    array_delete(itemsList, i, 1);
									maxI = array_length(itemsList);
									i=0;
								}
							}
				        break;}	
					case "holocoin":{
				        global.upgradeOptions[3] = ItemList[ItemIds.Holocoin][1];
				        break;}
					}
			#endregion		
		
	//global.upgradeOptions[3] = global.null;
	#endregion
	#endregion
	//first option
	//if (variable_struct_exists(global.upgradesAvaliable[Weapons.BounceBall][1], "unlocked") and global.upgradesAvaliable[Weapons.BounceBall][1][$ "unlocked"]) {
	//    global.upgradeOptions[0] = global.upgradesAvaliable[Weapons.BounceBall][1];
	//}
	 //global.upgradeOptions[0] = PERK_LIST[PerkIds.HeavyArtillery][0];
	 //global.upgradeOptions[0] = global.upgradesAvaliable[Weapons.PipiPilstol][1];
}	
#endregion
#region Random Enchantments
function apply_enchantments(_specificWeapon = -1, _repeat = 5){
	var _weapon = 0;
	var _isPerk = false;
	var _isCollab = false;
	var _possibleWeapons = [];
	for (_weapon = 0; _weapon < array_length(WEAPONS_LIST); ++_weapon) {
		_isCollab = variable_struct_exists(WEAPONS_LIST[_weapon][1], "collab");
		_isPerk = WEAPONS_LIST[_weapon][1].perk;
		
		if (!_isCollab and !_isPerk) {
			//show_debug_message($"{WEAPONS_LIST[_weapon][1].name}:c{_isCollab}:p{_isPerk}");
			array_push(_possibleWeapons, _weapon);
		}
	}
	//show_debug_message(_possibleEnchantments);
	//show_debug_message(_possibleWeapons);
	repeat (_repeat) {
	    _weapon = 0;
		var _compatible = false;
		var _possibleEnchantments = [];
		for (var i = 0; i < array_length(global.enchantmentWeights); ++i) {
			repeat (global.enchantmentWeights[i]) {
				array_push(_possibleEnchantments, i);
			}
		}
		var _canBeEnchanted = false;
		do {
		    _weapon = _possibleWeapons[irandom_range(0, array_length(_possibleWeapons) - 1)];
			_canBeEnchanted = WEAPONS_LIST[_weapon][1].enchantment == Enchantments.None;
		} until (_canBeEnchanted);
		//show_debug_message($"{WEAPONS_LIST[_weapon][1].name} c{_isCollab} : E {_canBeEnchanted}");
		if (_specificWeapon != -1) { _weapon = _specificWeapon; }
		array_delete(_possibleWeapons, _weapon, 1);
		if (variable_struct_exists(WEAPONS_LIST[_weapon][1], "incompatibleEnchantments")) {
			//show_debug_message("______________________")
			//show_debug_message(_possibleEnchantments);
			//show_debug_message(WEAPONS_LIST[_weapon][1].incompatibleEnchantments);
			for (var i = 0; i < array_length(WEAPONS_LIST[_weapon][1].incompatibleEnchantments); ++i) {
				//show_debug_message($"deleting {WEAPONS_LIST[_weapon][1].incompatibleEnchantments[i]}");
				for (var j = array_length(_possibleEnchantments) - 1; j >= 0; --j) {
				    if (WEAPONS_LIST[_weapon][1].incompatibleEnchantments[i] == _possibleEnchantments[j]) {
						//show_debug_message("deleted enchant " + lexicon_text("Enchantments." + string(_possibleEnchantments[j]) + ".desc") + " for weapon " + WEAPONS_LIST[_weapon][1].name);
					    array_delete(_possibleEnchantments, j, 1);
					}
				}
			}
			//show_debug_message(_possibleEnchantments);
		}
		if (_weapon != Weapons.EliteLavaBucket and _weapon != Weapons.SpiderCooking) {
		    for (var i = array_length(_possibleEnchantments) - 1; i >= 0 ; --i) {
			    if (_possibleEnchantments[i] == Enchantments.HitRate) {
				    array_delete(_possibleEnchantments, i, 1);
				}
			}
		}
		if (variable_struct_exists(WEAPONS_LIST[_weapon][1], "shotType") and WEAPONS_LIST[_weapon][1].shotType != ShotTypes.Multishot) {
		    for (var i = array_length(_possibleEnchantments) - 1; i >= 0 ; --i) {
			    if (_possibleEnchantments[i] == Enchantments.Projectile) {
				    array_delete(_possibleEnchantments, i, 1);
				}
			}
		}
		var _selectedEnchant = _possibleEnchantments[irandom_range(0, array_length(_possibleEnchantments) - 1)];
		WEAPONS_LIST[_weapon][1].enchantment = _selectedEnchant;
	}
}
#endregion
function tick_powers(){
	if (attacktick == true and UPGRADES[0][$ "name"]!="") {
		// feather disable once GM1041
		for (i=0; i < array_length(UPGRADES); i++) {
			if (UPGRADES[i] != global.null and global.upgradeCooldown[UPGRADES[i].id] <= 0) {
				instance_create_layer(x,y-8,"Upgrades",oUpgrade,{
					upg : UPGRADES[i],
					speed : UPGRADES[i][$ "speed"],
					hits : UPGRADES[i][$ "hits"],
					shoots : UPGRADES[i][$ "shoots"],
					sprite_index : UPGRADES[i][$ "sprite"],
					level : UPGRADES[i][$ "level"],
					mindmg: UPGRADES[i][$ "mindmg"],
					maxdmg: UPGRADES[i][$ "maxdmg"]
				});				
			}			
		}
	}
}

function default_behaviour(){
	if (owner.image_xscale==1) 
	{
		direction = point_direction(x,y,x+100,y+diroffset);
	}
	else 
	{
		direction = point_direction(x,y,x-100,y-diroffset);
	}
	image_xscale=owner.image_xscale;
	image_speed=1;
	image_alpha=1;
}

function spawn_upgrade(_upg = upg, _speed = upg[$ "speed"], _hits = upg[$ "hits"], _shoots = shoots, _mindmg = upg[$ "mindmg"], _maxdmg = upg[$ "maxdmg"], _sprite = upg[$ "sprite"], _arrowDir = arrowDir){
	if (_upg[$ "id"] != Weapons.PipiPilstol) { _shoots = -1; }
	var instancecreated = instance_create_layer(owner.x,owner.y-8,"Upgrades",oUpgrade,{
					upg : _upg,
					speed : _speed,
					hits : _hits,
					shoots : _shoots,
					mindmg : _mindmg,
					maxdmg : _maxdmg,
					sprite_index : _sprite,
					a : 0,
					owner : owner,
					arrowDir : _arrowDir
				});
		return instancecreated;
}
	
function can_collab(){
	totalWeapons = array_length(UPGRADES);
	for (var i = 0; i < totalWeapons; ++i) {
		if (UPGRADES[i][$ "level"] < UPGRADES[i][$ "maxlevel"]) { continue; }
		if (!variable_struct_exists(UPGRADES[i], "collabWith")) { continue; }
		var currentId = UPGRADES[i].id;
		var searchFor = UPGRADES[i][$ "collabWith"];
		for (var j = 0; j < totalWeapons; ++j) {
			if (UPGRADES[j][$ "level"] < UPGRADES[j][$ "maxlevel"]) { continue; }
			if (is_array(searchFor)) {
			    for (var k = 0; k < array_length(searchFor); ++k) {
				    if (UPGRADES[j][$ "id"] == searchFor[k]) {
						if (!instance_exists(oGoldenAnvil)) {
						    instance_create_layer(x, y + 50,"Props" , oGoldenAnvil);
						}
					}
				}
			}
			else{
			    if (UPGRADES[j][$ "id"] == searchFor) {
					if (!instance_exists(oGoldenAnvil)) {
					    instance_create_layer(x, y + 50,"Props" , oGoldenAnvil);
					}
				}
			}
		}
	}	
}

function draw_spider_cooking(){
	draw_set_color(c_purple);
	draw_set_alpha(.35);
	draw_circle(x,y, (sprite_get_height(sprite_index)/2) * image_yscale,false);
	draw_set_alpha(1);
	draw_circle(x,y, (sprite_get_height(sprite_index)/2) * image_yscale,true);
	draw_set_color(c_white);
}