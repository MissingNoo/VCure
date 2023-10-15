switch (upg[$ "id"]) {
    case Weapons.XPotato:{
		if (justBounced) { return; }
		if (!justBounced) {
		    justBounced = true;
			dAlarm[2]=50;
		}
		direction += 180;
		break;
	}
	case Weapons.UrukaNote:{
		if (upg.level == 7) {
		    noteExplosion();
		}
		break;}
    default:
        // code here
        break;
}