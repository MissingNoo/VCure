// Feather disable all
// Feather disable GM2017
#macro HP global.hp
#macro MAXHP global.maxhp
#macro NAME global.name
function initializePlayer(_p){
	mouseAim = false;
	attacktick=true;
	global.newcoins = 0;
	global.minibossDefeated = 0;
	global.defeatedEnemies = 0;
	global.bossDefeated = 0;
	global.score = 0;
	blacksmithLevel = 0;
	#region shop hp upgrade
	var _hpBonus = 4 * global.shopUpgrades[$ "Hp"][$ "level"];
	#endregion
	HP=_p[?"hp"] + _hpBonus;
	MAXHP=_p[?"hp"] + _hpBonus;
	if (global.shopUpgrades.Hardcore.level == 1) {
		MAXHP = 1;
		HP = 1;
	}
	NAME=_p[?"name"];
	for (var i=0; i<6; i++) {
		UPGRADES[i]=global.null;
	}
	for (var i=0; i<6; i++) {
		playerItems[i]=global.nullitem;
	}
	PLAYER_PERKS = global.characterPerks[global.player[? "id"]];
	for (var i=0; i<3; i++) {
		PLAYER_PERKS[i] = PERK_LIST[PLAYER_PERKS[i].id][0];
	}
	global.upgrade=0;
	global.xp=0;
	global.level = 1;
	damaged=false;
	spddefault=_p[?"speed"];
	spd=_p[?"speed"];
	// Feather disable GM2017
	canShoot = 1;
	arrowDir=0;
	// Feather enable GM2017
	atk=_p[?"atk"];
	sprite=_p[?"outfits"][global.selectedOutfit][$ "sprite"];
	runningsprite=_p[?"outfits"][global.selectedOutfit][$ "runningSprite"];
	sprite_index=sprite;
	global.upgrades[0] = _p[?"weapon"][1];
	Shield = 0;
	MaxShield = 0;
	revives = 0;
	pickupRadius = 35;
	#region Reset bonuses
		for (var i = 0; i < array_length(Bonuses); ++i) {
			if (is_array(Bonuses[i])) {
			    for (var j = 0; j < array_length(Bonuses[i]); ++j) {
					Bonuses[i][j]=0;
				}
			}
			else{
				Bonuses[i]=0;
			}
		}
		Bonuses[BonusType.Critical][ItemIds.MoldySoulBonus] = 1;
		if(variable_global_exists("pig") and time_source_exists(global.pig)) {time_source_destroy(global.pig);}
	#endregion
	
	#region reset perk bonuses
		PerkBonuses = array_create(BonusType.Lenght);
		for (var i = 0; i < array_length(PerkBonuses); ++i) {
			PerkBonuses[i]=array_create(PerkIds.Lenght, 0);
			//if (is_array(PerkBonuses[i])) {
			//    for (var j = 0; j < array_length(PerkBonuses[i]); ++j) {
			//		PerkBonuses[i][j]=0;
			//	}
			//}
			//else{
			//	PerkBonuses[i]=0;
			//}
		}
	#endregion
	
	#region reset buffs
		for (var i = 0; i < array_length(Buffs); ++i) {
			if (is_struct(Buffs[i])) {
			    Buffs[i].cooldown = 0;
			}
		}
	#endregion
	#region Reset enchantments
	for (var i = 0; i < array_length(WEAPONS_LIST); ++i) {
	    WEAPONS_LIST[i][1].enchantment = Enchantments.None;
	}
	//Feather disable once GM2017
	if (global.shopUpgrades.Enchantment.level > 0) {
	    apply_enchantments();
	}	
	#endregion
	gx = 0;
	gy =0;
	pimanLevel = 0;
	oGui.upgradesSurface();
}
global.characters=[];
#macro CHARACTERS global.characters
enum Characters {
	Null,
	Pippa,
	Uruka,
	Lia,
	Tenma,
	Trickywi,
	Amelia,
	Aki,
	Anya,
	//Aqua,
	//Ayame,
	//Azki,
	//Baelz,
	//Mori,
	//Choco,
	//Fauna,
	//Gura,
	//Haachama,
	//Iofi,
	//Irys,
	//Kaela,
	//Kobo,
	//Korone,
	//Matsuri,
	//Mel,
	//Mio,
	//Moona,
	//Mumei,
	//Ina,
	//Okayu,
	//Ollie,
	//Kronii,
	//Reine,
	//Risu,
	//Roboco,
	//Sana,
	//Shion,
	//Fubuki,
	//Sora,
	//Subaru,
	//Suisei,
	//Kiara,
	//Zeta,
	Lenght
}
function createCharacter(_id, _agency, _name, _portrait, _bigArt, _sprite, _runningsprite, _hp, _speed, _atk, _crt, _ballsize, _weapon, _flat, _unlocked)
{
	if (_unlocked) {
	    UnlockableCharacters[_id] = _unlocked;
	}	
	global.characters[_id]=ds_map_create();
	m = global.characters[_id];
	ds_map_add(m, "id", _id);
	ds_map_add(m, "agency", _agency);
	ds_map_add(m, "name", _name);
	ds_map_add(m, "portrait", _portrait);
	ds_map_add(m, "bigArt", _bigArt);
	ds_map_add(m, "sprite", _sprite);
	ds_map_add(m, "runningsprite", _runningsprite);
	ds_map_add(m, "hp", _hp);
	ds_map_add(m, "speed", _speed);
	ds_map_add(m, "atk", _atk);
	ds_map_add(m, "weapon", _weapon);
	ds_map_add(m, "ballsize", _ballsize);
	ds_map_add(m, "flat", _flat);
	ds_map_add(m, "crit", _crt);
	ds_map_add(m, "outfits", []);
	ds_map_add(m, "chooseText", lexicon_text($"Characters.{_name}.chooseText"));
}
function createCharacterNew(_data)
{
	if (_data.unlocked) {
	    UnlockableCharacters[_data.id] = _data.unlocked;
	}	
	global.characters[_data.id]=ds_map_create();
	m = global.characters[_data.id];
	ds_map_add(m, "id", _data.id);
	ds_map_add(m, "agency", _data.agency);
	ds_map_add(m, "name", _data.name);
	ds_map_add(m, "portrait", _data.portrait);
	ds_map_add(m, "bigArt", _data.bigArt);
	ds_map_add(m, "sprite", _data.sprite);
	ds_map_add(m, "runningsprite", _data.runningsprite);
	ds_map_add(m, "hp", _data.hp);
	ds_map_add(m, "speed", _data.speed);
	ds_map_add(m, "atk", _data.atk);
	ds_map_add(m, "weapon", u[_data.weapon]);
	ds_map_add(m, "ballsize", _data.ballsize);
	ds_map_add(m, "flat", _data.flat);
	ds_map_add(m, "crit", _data.crit);
	ds_map_add(m, "finished", _data.finished);
	ds_map_add(m, "outfits", []);
}
enum BuffNames{
	//ShortHeight,
	//SharkBite,
	//Slowness,
	Sake,
	SakeFood,
	Spaghetti,
	Paralyzed,
	Soda,
	testbuff,
	WallmartDefense,
	BellyDance
}
function populate_characters(){
	createCharacter(Characters.Null, "Phase-Connect","",sBlank,sBlank, sBlank,sBlank,0,0,0, 0, 0,u[Weapons.PipiPilstol], false, false);
	createCharacter(Characters.Uruka, "Phase-Connect","Fujikura Uruka",sUrukaPortrait, sUrukaArt, sUrukaIdle,sUrukaRunning,75,1.35,1.30, 1.10, 3,u[Weapons.UrukaNote], false, true);
	createCharacter(Characters.Pippa, "Phase-Connect","Pipkin Pippa",sPippaPortrait, sPippaArt, sPippaIdle,sPippaRun,60,1.50,0.95, 1.10, 1,u[Weapons.PipiPilstol], true, true);
	createCharacter(Characters.Lia, "Phase-Connect","Rinkou Ashelia",sLiaPortrait, sLiaArt, sLiaIdle,sLiaRunningOld, 70, 1.30, 1.25, 0.75, 1,u[Weapons.LiaBolt], true, true);
	createCharacter(Characters.Tenma, "Phase-Connect","Tenma Maemi",sTenmaPortrait, sTenmaArt, sTenmaIdle, sTenmaRun, 65, 1.40, 1.35, 1, 1, u[Weapons.Brick], true, false);
	createCharacter(Characters.Trickywi, "Indies","Trickywi",sTrickyPortrait, sTrickyArt, sTrickyIdle, sTrickyRun, 65, 1.40, 1.35, 1, 1, u[Weapons.Brick], true, true);
	createCharacter(Characters.Amelia, "Hololive", "Amelia Watson", sAmeliaPortrait, sAmeliaArt, sAmeliaIdle, sAmeliaRun, 75, 1.35, 1.30, 1.10, 3, u[Weapons.AmePistol], false, true);
	createCharacter(Characters.Aki, "Hololive", "Aki Rosenthal", sAkiPortrait, sPlaceholderArt, sAkiIdle, sAkiRun, 80, 1.35, 1.30, 1.10, 3, u[Weapons.AmePistol], false, true);
	//createCharacterNew({
	//	id : Characters.,
	//	name : "",
	//	agency : "",
	//	portrait : s,
	//	bigArt : s,
	//	sprite : s,
	//	runningsprite : s,
	//	hp : ,
	//	speed : ,
	//	atk : ,
	//	crit : ,
	//	weapon : ,
	//	ballsize : ,
	//	flat : ,
	//});
	createCharacterNew({
		id : Characters.Aki,
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
		unlocked : false,
		finished : false
	});
	createCharacterNew({ id : Characters.Anya, name : "Anya Melfissa", agency : "Hololive", portrait : sAnyaPortrait, bigArt : sPlaceholderArt, sprite : sAnyaIdle, runningsprite : sAnyaRun, hp : 60, atk : 1.50, speed : 1.20, crit : 5, weapon : Weapons.Keris, ballsize : 2, flat : true, unlocked : true, finished : false });
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
		id : BuffNames.SakeFood,
		name : "SakeFood",
		icon : sSakeFood,
		enabled : false,
		baseCooldown : 5,
		cooldown : 0,
	}
	Buffs[BuffNames.Spaghetti] = {
		id : BuffNames.Spaghetti,
		name : "Spaghetti",
		icon : sSpaghetti,
		enabled : false,
		baseCooldown : 3,
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
	Buffs[BuffNames.Soda] = {
		id : BuffNames.Soda,
		name : "Soda",
		icon : sSodaFueled,
		enabled : false,
		baseCooldown : 3,
		cooldown : 0,
	}
	Buffs[BuffNames.WallmartDefense] = {
		id : BuffNames.WallmartDefense,
		name : "Wallmart",
		icon : sWalmart,
		enabled : false,
		permanent : true,
		baseCooldown : 1,
		cooldown : 0,
	}
	Buffs[BuffNames.BellyDance] = {
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
	//Buffs[BuffNames.Slowness] = {
	//	id : BuffNames.Slowness,
	//	name : "Slowness",
	//	icon : sShortHeight, //TODO: add slow speed icon
	//	time : 15,
	//}
	//createCharacter(Characters.Ina,"Ninomae Ina'nis",sInaPortrait,sInaIdle,sInaRunning,75,1.50,0.90,u[Weapons.InaTentacle]);
	//createCharacter(Characters.Kiara,"Takanashi Kiara",sAmePortrait,sAmeIdle,sAmeRunning,30,1.35,10,u[Weapons.UrukaNote]);
	//createCharacter(Characters.Calli,"Mori Calliope",sAmePortrait,sAmeIdle,sAmeRunning,30,1.35,10,u[Weapons.UrukaNote]);
	NAME=CHARACTERS[Characters.Uruka][?"name"];
}
function Movement()
{
if (canMove == true){
	var _target = noone;
	if (instance_exists(oCam)) {
	    _target = oCam;
	}
	if (instance_exists(oCamWorld)) {
	    _target = oCamWorld;
	}
	var _maxx = _target.x + (((view_wport[0])/2) - 16);
	var _minx = (_target.x - ((view_wport[0])/2)) + 16;
	var _maxy = _target.y + (((view_hport[0])/2) - 16);
	var _miny = (_target.y - ((view_hport[0])/2)) + 32;
	//if (round(y) <= round(_miny)) { y = _miny; }
	//if (round(x) <= round(_minx)) { x = _minx; }
	gamepad_set_axis_deadzone(global.gPnum, 0.7);
	var _left, _right, _up, _down;
	     _left = input_check("left");
	    _right = input_check("right");
	    _up = input_check("up");
	    _down = input_check("down");
	
	if (!instance_exists(oJoystick) and !global.strafe) {
		//if (gamepad_axis_value(global.gPnum, gp_axisrh) != 0 or gamepad_axis_value(global.gPnum, gp_axisrv) != 0) {
			
		//}
		
		if (!global.gamePad) {
			//TODO: fix
			if (os_type != os_android) {
				var _destination = undefined;
				var _step = 15;
				if (_down) { _destination=270; }
				if (_up) { _destination=90; }
				if (_right) { 
					if (global.arrowDir > 179) { _destination=360; }
					else { _destination = 0; }					
				}
				if (_left) { 
					if (global.arrowDir == 360) {global.arrowDir = 0; _destination=180; }
					else{ _destination=180; }
				}
				if (_up and _right) { _destination=45; }
				if (_up and _left) { _destination=135; }
				if (_down and _right) { _destination=315; }
				if (_down and _left) { _destination=225; }
				
				if (_destination != undefined) {
					var _calc = global.arrowDir - _destination;
					if (_calc < -180 or _calc > 180) { _calc = _calc *-1; }
				    if (_calc < 0 and _calc < _step - 1) {
					    global.arrowDir += _step;
					}
					if (_calc > 0 and _calc > _step - 1) {
						global.arrowDir -= _step;
					}
				    if (_calc < 0 and _calc < _step/2 - 1) {
					    global.arrowDir += _step/2;
					}
					if (_calc > 0 and _calc > _step/2 - 1) {
						global.arrowDir -= _step/2;
					}
				}
				if (global.arrowDir > 360) { global.arrowDir = 0; }
				if (global.arrowDir < 0) { global.arrowDir = 360; }
				if (oPlayer.mouseAim) {
				    global.arrowDir = point_direction(oPlayer.x, oPlayer.y, mouse_x, mouse_y + 16);
				}
				if (global.arrowDir > 90 and global.arrowDir < 270) {
					    image_xscale = -1;
					};
					if (global.arrowDir < 90 and (global.arrowDir > 270 or global.arrowDir > 0)) {
					    image_xscale = 1;
					};
					if (global.arrowDir < 360 and global.arrowDir > 270) {
					    image_xscale = 1;
					};
			}
			else{
				if (global.aim.check() and global.aim.get_touch_x() != undefined and global.aim.get_touch_y() != undefined) {
					x1 = global.aim.get_touch_start_x();
					y1 = global.aim.get_touch_start_y();
				    x2 = global.aim.get_touch_x();
					y2 = global.aim.get_touch_y();
				}				
				if (!instance_exists(oPlayerWorld)) {
				    global.arrowDir = point_direction(x1, y1, x2, y2);
					if (global.arrowDir > 90 and global.arrowDir < 270) {
						image_xscale = -1;
					};
					if (global.arrowDir < 90 and (global.arrowDir > 270 or global.arrowDir > 0)) {
						image_xscale = 1;
					};
					if (global.arrowDir < 360 and global.arrowDir > 270) {
						image_xscale = 1;
					};
				}
			}
		}
		else{
			gx = - input_check("aim_left") + input_check("aim_right"); 
			gy = - input_check("aim_up") + input_check("aim_down");
			if (!instance_exists(oPlayerWorld)) {global.arrowDir = point_direction(0,0, gx, gy);}
		}
	}
	var _hspd = 0;
	var _vspd = 0;
	
	if (os_type != os_android or global.gamePad) {
	    _hspd = _right - _left;
		_vspd = _down - _up;
	}
	else {
		if (global.move.check() and global.move.get_touch_x() != undefined and global.move.get_touch_y() != undefined) {
			sprite_index=runningsprite;
			_mx1 = global.move.get_touch_start_x();
			_my1 = global.move.get_touch_start_y();
			_mx2 = global.move.get_touch_x();
			_my2 = global.move.get_touch_y();
			_dir = point_direction(_mx1, _my1, _mx2, _my2);
			var _spd = spd * Delta;
			var _xadd = lengthdir_x(_spd, _dir);
			var _yadd = lengthdir_y(_spd, _dir);
			if (x + _xadd > _maxx or x - _xadd < _minx) { _xadd = 0;}
			if (y + _yadd > _maxy or y - _yadd < _miny) { _yadd = 0;}
			move_and_collide(_xadd, _yadd,oCollision);
			moving = true;
		}
		else {
			moving = false;
			sprite_index=sprite;
		}
	}
    

    if (_hspd != 0 || _vspd != 0)
    {
		if (_hspd != 0) {
			if (!global.strafe and !instance_exists(oJoystick)) {
			    image_xscale=_hspd;
			}		    
		}
		
        var _spd = spd * Delta;
        var _dir = point_direction(0, 0, _hspd, _vspd);
		
        var _xadd = lengthdir_x(_spd, _dir);

        var _yadd = lengthdir_y(_spd, _dir);
		
		if (x + _xadd > _maxx or x + _xadd < _minx) { _xadd = 0;}
		if (y + _yadd > _maxy or y + _yadd < _miny) { _yadd = 0;}
		move_and_collide(_xadd, _yadd,oCollision);
		moving = true;
		sprite_index=runningsprite;
        }
		else if (os_type != os_android or global.gamePad) {
			sprite_index=sprite;
			moving = false;
		}
    } 
	else if (os_type != os_android or global.gamePad) {
		sprite_index=sprite;
		moving = false;
	}
}