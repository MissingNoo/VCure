var _updown = - input_check_pressed("up") + input_check_pressed("down");
var _leftright = - input_check_pressed("left") + input_check_pressed("right");
var _left = input_check_pressed("left");
var _right = input_check_pressed("right");
var _up = input_check_pressed("up");
var _down = input_check_pressed("down");
var xKey = input_check_pressed("cancel");
var zKey= input_check_pressed("accept");

#region shop
if (selectingTab) {
	isFirstItem = false;
    selectedTab += _leftright;
	if (selectedTab < 0) { selectedTab = GlobalShopTabs.Others; }
	if (selectedTab > GlobalShopTabs.Others) { selectedTab = 0; }
	if (_down) { 
		selectingTab = false;
		selected = -1;
		nextItem();
		return;
	}
	if (xKey) {
	    room_goto(rInicio);
	}
}

if (!selectingTab and !interacting) {
	if (_leftright > 0) {
	    nextItem();
	}
	if (_leftright < 0) {
	    lastItem();
	}
	if (_down) {
	    repeat (4) {
		    nextItem();
		}
	}
	if (_up) {
	    repeat (4) {
		    lastItem();
		}
		if (isFirstItem) {
		    selectingTab = true;
			selected = -1;
		}
	}
	if (xKey) {
	    selectingTab = true;
		selected = -1;
		return;
	}
	if (zKey) {
		if (global.shopUpgrades[$ ups[selected]].level == global.shopUpgrades[$ ups[selected]].maxlevel) {
			interactOption = 1;
		}
		if (global.shopUpgrades[$ ups[selected]].level == 0) {
			interactOption = 0;
		}
	    interacting = true;
		return;
	}
}

if (interacting) {
	interactOption += _leftright;
	if (interactOption < 0) { interactOption = 1; }
	if (interactOption > 1) { interactOption = 0; }
    if (xKey) {
	    interacting = false;
		return;
	}
	if (zKey) {
		var _upg = global.shopUpgrades[$ ups[selected]];
		var _level = _upg.level;
		var _maxlevel = _upg.maxlevel;
		var _cost = _upg.costs[_level - _level == _maxlevel ? 1 : 0];
		switch (interactOption) {
		    case 0:
		        if (global.holocoins > _cost and _level < _maxlevel) {
				    global.holocoins -= _cost;
					global.shopUpgrades[$ ups[selected]].level += 1;
					interacting = false;
				}
		        break;
		    case 1:
		        if (_level > 0) {
				    global.holocoins += _cost;
					global.shopUpgrades[$ ups[selected]].level -= 1;
				}
				interacting = false;
		        break;
		}
		
	    //			    if (selectedThing[$ "level"] > 0) {
//					var upgradecost = selectedThing[$ "costs"][selectedThing[$ "level"] - 1];
//					if (selectedThing[$ "level"] == selectedThing[$ "maxlevel"]) {
//					    upgradecost = selectedThing[$ "costs"][selectedThing[$ "maxlevel"] - 1];
//					}
//					global.holocoins += upgradecost;
//					selectedThing[$ "level"] -= 1;
//				}
	}
}

//if (!onMenu and optionSelected == 1) {
//	if (!interact) {
//		if (xKey) {
//		    onMenu = true;
//		}
//		if (_left) {
//		    if (selected == 0) {
//			    selected = variable_struct_names_count(global.shopUpgrades) - 1;
//			}
//			else
//			{
//				selected -= 1;
//			}
//		}

//		if (_right) {
//		    if (selected == variable_struct_names_count(global.shopUpgrades) - 1) {
//			    selected = 0;
//			}
//			else
//			{
//				selected += 1;
//			}
//		}
//		var newselected = selected;
//		if (_up) {
//			newselected -= 6;
//		    if (newselected < 0) {
//			    newselected = 0;
//			}
//			selected = newselected;
//		}
//		if (_down) {
//			newselected += 6;
//			if (newselected >= variable_struct_names_count(global.shopUpgrades)) {
//			    newselected = variable_struct_names_count(global.shopUpgrades) -1;
//			}
//			selected = newselected;
//		}
//		if (zKey) {
//		    interact = true;
//		}
//	}
//	else{
//		if (xKey) {
//		    interact = false;
//		}
	
//		if (_left) {
//		    interactSelected = interactSelected == 1 ? 0 : 1;
//		}
//		if (_right) {
//		    interactSelected = interactSelected == 0 ? 1 : 0;
//		}
	
//		if (zKey) {
		
		
//			if (interactSelected == 0) {	
//			    if (selectedThing[$ "level"] < selectedThing[$ "maxlevel"] and selectedThing[$ "costs"][selectedThing[$ "level"]] < global.holocoins) {
//					global.holocoins -= selectedThing[$ "costs"][selectedThing[$ "level"]];
//					selectedThing[$ "level"] += 1;
//				}
//			}
		
//			if (interactSelected == 1) {
//			    if (selectedThing[$ "level"] > 0) {
//					var upgradecost = selectedThing[$ "costs"][selectedThing[$ "level"] - 1];
//					if (selectedThing[$ "level"] == selectedThing[$ "maxlevel"]) {
//					    upgradecost = selectedThing[$ "costs"][selectedThing[$ "maxlevel"] - 1];
//					}
//					global.holocoins += upgradecost;
//					selectedThing[$ "level"] -= 1;
//				}
//			}
//		}
//	}
//}
#endregion