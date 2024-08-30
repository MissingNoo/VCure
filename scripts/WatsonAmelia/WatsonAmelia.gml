function WatsonAmelia(){

    new_create_upgrade({
        create : amepistol_create,
        on_hit : amepistol_on_hit,
        id : Weapons.AmePistol,
        name : "Pistol Shot",
        maxlevel : 7,
        sprite : sAmeliaWeaponProjectile,
        thumb : sAmeliaWeapon,
        mindmg : [8, 8, 10, 10, 10, 12, 12],
        maxdmg : [12, 12, 14, 14, 14, 16, 16],
        cooldown : [80, 80, 80, 80, 60, 60, 60],
        minimumcooldown : 50,
        duration : 120,
        hitCooldown : 20,
        canBeHasted : true,
        attackdelay : 6,//
        speed : 5,
        hits : [1, 2, 2, 2, 3, 3, 3],
        type : "red",
        shoots : [3, 5, 5, 5, 5, 5, 5],
        perk : true,
        characterid : "Amelia Watson",
        weight : 3
    },[snd_bullet, snd_bullet2, snd_bullet3]);

    createCharacterNew({
        id : "Amelia Watson",
        name : "Amelia Watson",
        agency : "Hololive",
        portrait : sAmeliaPortrait,
        bigArt : sAmeliaArt,
        sprite : sAmeliaIdle,
        runningsprite : sAmeliaRun,
        hp : 75,
        atk : 1.30,
        speed : 1.35,
        crit : 1.10,
        weapon : Weapons.AmePistol,
        ballsize : 3,
        flat : false,
        unlockedbydefault : true,
        finished : true
    });

    #region FPS Mastery
    create_perk({
        id : PerkIds.FpsMastery,
        name : "FPS Mastery",
        maxlevel : 3, 
        weight : 1,
        thumb : sAmeliaFpsMastery,
        cooldown : [3, 3, 2.01, 2.01],
        bonus : true,
        bonusType : [BonusType.Damage, BonusType.Haste],
        bonusValue : [[0, 20, 40, 60], [0, 0, 0, 10]],
        characterid : "Amelia Watson"
    });
    #endregion
    #region Detective Eye
    create_perk({
        id : PerkIds.DetectiveEye,
        on_hit : detective_eye_on_hit,
        name : "Detective Eye",
        maxlevel : 3, 
        weight : 1,
        thumb : sAmeliaDetectiveEye,
        cooldown : [3, 3, 2.01, 2.01],
        characterid : "Amelia Watson",
        bonus : true,
        bonusType : BonusType.Critical,
        bonusValue : [0, 1.10, 1.20, 1.30]
    });
    #endregion
    #region Bubba
    create_perk({
        id : PerkIds.Bubba,
        on_cooldown : perk_bubba_on_cooldown,
        name : "Bubba",
        maxlevel : 3, 
        weight : 1,
        thumb : sAmeliaBubba,
        cooldown : [3, 3, 2.01, 2.01],
        characterid : "Amelia Watson"
    });
    #endregion

    var sp = new Special(SpecialIds.SlowTime, "Amelia Watson", "Slow Time", sHudSpecialCooldownIcon, 60)
	.set_function(function(){
		oPlayer.slowTime = true;
		oPlayer.slowTimeTimer = 10;
		if (global.screenShake) {
			oGame.shakeMagnitude=12;
		}
		if (!instance_exists(oEnemy)) { exit; }
		with (oEnemy) {
			/// @localvar {Any} debuffs 
			var _struct = { baseCooldown : 0 };
			_struct = copy_struct(Buffs[BuffNames.SpdDown]);
			_struct.count = 8;
			_struct.cooldown = _struct.baseCooldown;
			array_push(debuffs, _struct);
		}
	})
	.set_sequence(seq_AmeSpecial);
	SPECIAL_LIST[SpecialIds.SlowTime] = sp;
}