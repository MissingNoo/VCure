function perk_bubba(level, event = WeaponEvent.Null){
	switch (level) {
	    case 1:
			if (!instance_exists(oBubba)) {
			    instance_create_depth(oPlayer.x, oPlayer.y, oPlayer.depth, oBubba);
			}
	        oBubba.basespeed = 1;
			oBubba.level = 1;
	        break;
	    case 2:
	        oBubba.basespeed = 1.15;
			oBubba.level = 2;
	        break;
	    case 3:
	        oBubba.basespeed = 1.30;
			oBubba.level = 3;
	        break;
	}
}
function detective_eye(level, event = WeaponEvent.Null){
	switch (level) {
	    case 1:
	        // code here
	        break;
	    case 2:
	        // code here
	        break;
	    case 3:
	        if (event == WeaponEvent.PerkOnHit) {
			    var _chance = irandom_range(0, 100);
				show_debug_message($"Detective Eye rolled: {_chance}");
				if (_chance <= 2) {
					perkBonusDmg += 99999;
				}
			}
	        break;
	}
}
function perk_ankh(o, event = WeaponEvent.Null){
	switch (o) {
	    case 1:
	    case 2:
	    case 3:
			if (!instance_exists(oMascot) and o > 0) {
			    instance_create_depth(oPlayer.x - 20, oPlayer.y - 20, oPlayer.depth, oMascot);
			}
			break;
	}
}
function trash_bear(level, event = WeaponEvent.Null, enemy = noone, xx = 0, yy = 0){
	var _spaghettiChance = irandom_range(0, 100);
	var dropChance = -1;
	switch (level) {
	    case 1:
	        dropChance = 10;
	        break;
	    case 2:
	        dropChance = 11;
	        break;
	    case 3:
	        dropChance = 12;
	        break;
	}
	if (_spaghettiChance <= dropChance) {
		if (enemy != noone) {
		    instance_create_depth(xx, yy, depth, oSpaghetti);
		}
	}
}
function heavy_artillery(level, event = WeaponEvent.Null, enemy = noone, xx = 0, yy = 0){
	if (event == WeaponEvent.PerkCooldown) {
	    instance_create_layer(oPlayer.x, oPlayer.y-8, "Upgrades", oUpgradeNew, {upg : global.upgradesAvaliable[Weapons.HeavyArtillery][level], shoots : 0});
	}
}