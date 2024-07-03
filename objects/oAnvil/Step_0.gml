if (maxuses == 0 and !ANVIL) {
	instance_destroy();
}
if (ANVIL) {
	var selectedThing;
	if (anvilSelectedCategory == 0) {
		selectedThing = UPGRADES[anvilSelected];
	}else{
		selectedThing = playerItems[anvilSelected];
	}
	var level = selectedThing[$ "level"];
	var maxlevel = selectedThing[$ "maxlevel"];	
	if (input_check_pressed("cancel")) {
		if (anvilconfirm and !upgradeconfirm) {
		    anvilconfirm = false;
		}
		if (anvilconfirm and upgradeconfirm) {
		    upgradeconfirm = false;
		}	    
	}
	if (input_check_pressed("accept")) {
		var _finishAnvil = false;
		if (upgradeconfirm) {
		    if (anvilSelectedCategory == 0) {
				if (level < maxlevel) {
				    UPGRADES[anvilSelected] = global.upgradesAvaliable[UPGRADES[anvilSelected][$ "id"]][UPGRADES[anvilSelected][$ "level"] + 1];
					_finishAnvil = true;
				}
				else if (global.newcoins >= upgradeCoinValue) {
					var _bonusdmg = 0;
					switch (oPlayer.blacksmithLevel) {
					    case 0:
					        _bonusdmg = 2;
					        break;
					    case 1:
					        _bonusdmg = 2;
					        break;
					    case 2:
					        _bonusdmg = 2.5;
					        break;
					    case 3:
					        _bonusdmg = 3;
					        break;
					    default:
					        break;
					}
					if (!variable_struct_exists(UPGRADES[anvilSelected], "bonusLevel")) {
					    variable_struct_set(UPGRADES[anvilSelected], "bonusLevel", 1);
						UPGRADES[anvilSelected][$ "bonusDamage"] = [_bonusdmg];
					}
					else{
						variable_struct_set(UPGRADES[anvilSelected], "bonusLevel", variable_struct_get(UPGRADES[anvilSelected], "bonusLevel") + 1);
						array_push(UPGRADES[anvilSelected][$ "bonusDamage"], _bonusdmg);
					}
					global.newcoins -= upgradeCoinValue;
					_finishAnvil = true;
				}
			}
			if (anvilSelectedCategory == 1) {
				if (level < maxlevel) {
					playerItems[anvilSelected] = global.itemList[playerItems[anvilSelected][$ "id"]][playerItems[anvilSelected][$ "level"] + 1];
					_finishAnvil = true;
				}
			}
			if (_finishAnvil) {
			    ANVIL = false;
				anvilconfirm = false;
				upgradeconfirm = false;
				pause_game();
			}
		}	
		if (!upgradeconfirm and anvilconfirm) {
		    upgradeconfirm = true;
		}
		if (!anvilconfirm and ANVIL and selectedThing!=global.null and selectedThing != global.nullitem) {
			if (anvilSelectedCategory == 1 and level < maxlevel) {
			    anvilconfirm = true;
			}
			if (anvilSelectedCategory == 0) {
			    anvilconfirm = true;
			}
		}
		//feather disable once GM2016
		oGui.upgradesSurface();
	}
}