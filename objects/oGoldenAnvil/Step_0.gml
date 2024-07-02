if (maxuses == 0 and !global.gamePaused and !GoldenANVIL) {
	instance_destroy();
}	
if (GoldenANVIL) {
	if (input_check_pressed("accept") and canCollab) {
	    UPGRADES[gAnvilWeapon1Position] = global.null;
	    UPGRADES[gAnvilWeapon2Position] = global.null;
		for (var i = 0; i < array_length(Collabs); ++i) {
		    if (is_array(Collabs[i]) and ((Collabs[i][0] == gAnvilWeapon1[$ "id"] and Collabs[i][1] == gAnvilWeapon2[$ "id"]) or (Collabs[i][0] == gAnvilWeapon2[$ "id"] and Collabs[i][1] == gAnvilWeapon1[$ "id"]))) {
				var _n = min(gAnvilWeapon1Position, gAnvilWeapon2Position);
			    UPGRADES[_n] = WEAPONS_LIST[i][1];
				UPGRADES[_n][$ "materials"] = [];
				UPGRADES[_n][$ "materials"][0] = gAnvilWeapon1;
				UPGRADES[_n][$ "materials"][1] = gAnvilWeapon2;
				break;
			}
		}	
		for (var i = 0; i < array_length(UPGRADES) - 1; ++i) {
		    if (UPGRADES[i] == global.null and UPGRADES[i+1] != global.null) {
			    UPGRADES[i] = UPGRADES[i + 1];
			    UPGRADES[i + 1] = global.null;
				i=0;
			}
		}
		GoldenANVIL = false;
		gAnvilWeapon1 = global.null;
	    gAnvilWeapon2 = global.null;
		gAnvilWeapon1Position = 0;
		gAnvilWeapon2Position = 0;
		canCollab = false;
		pause_game();
		oGui.upgradesSurface();
		return;
	}
	if (input_check_pressed("cancel")) {
	    gAnvilWeapon1 = global.null;
	    gAnvilWeapon2 = global.null;
		gAnvilWeapon1Position = 0;
		gAnvilWeapon2Position = 0;
		canCollab = false;
	}	
}
