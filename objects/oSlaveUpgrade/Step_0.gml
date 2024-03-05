afterimage_step();
var _names = variable_struct_get_names(extraInfo);
for (var i = 0; i < array_length(_names); ++i) {
	if (_names[i] == "orbitPlace" and orbitPlace != 1) { continue; }
	if (_names[i] == "orbitLength" and orbitLength != 1) { continue; }
	if (_names[i] == "coscounter") { continue; }
	if (_names[i] == "sincounter") { continue; }
    if (variable_instance_get(self, _names[i]) != extraInfo[$ _names[i]]) {
	    variable_instance_set(self, _names[i], extraInfo[$ _names[i]]);
	}
    if (!variable_instance_exists(self, _names[i])) {
	    variable_instance_set(self, _names[i], extraInfo[$ _names[i]]); //lavabucket xy, idolsolg, absolutewall wrong place
	}
}
owner = oSlave;
switch (extraInfo.uid) {
	case Weapons.EliteLavaBucket:{
		if (extraInfo[$ "lx"] != undefined) {
		    x = extraInfo.lx;
			y = extraInfo.ly;
		}
		break;}
	case Weapons.LiaBolt:{
		if (extraInfo[$ "lx"] != undefined) {
			x = extraInfo.lx;
			y = extraInfo.ly;
		}		
		break;}
	case Weapons.PlugAsaCoco:{
		if (speed == 0 and extraInfo[$ "asay"] != undefined) {
		    y = extraInfo.asay;
		}		
		break;}
    case Weapons.PsychoAxe:{
        psycho_axe_step();
        break;}
	case Weapons.UrukaNote:{
		if (!variable_instance_exists(self, "coscounter")) {
			if (extraInfo[$ "coscounter"] != undefined) {
			    variable_instance_set(self, "coscounter", extraInfo.coscounter);
			}
		}
		else{
			y = cose_wave(coscounter / 1000, 1 * extraInfo.upDown, extraInfo.travelWidth, extraInfo.noteStartY);
		}
		break;}
	case Weapons.BLFujoshiAxe:{
		blfujoshiaxe_step();
		break;}
	case Weapons.BLFujoshiBook:{
		blfujoshibook_step();
		break;}
	case Weapons.BlBook:
		blbook_step();
		break;
	case Weapons.SpiderCooking:{
		x= owner.x;
		y = owner.y - (sprite_get_height(owner.sprite_index) / 3);
		break;}
	case Weapons.StreamOfTears:{
		stream_of_tears();
		break;}
    default:
        // code here
        break;
}