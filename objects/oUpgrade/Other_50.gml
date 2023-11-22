var _prevDirection = direction;
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
		    // Feather disable once GM2016
		    noteExplosion();
		}
		break;}
    default:
        // code here
        break;
}
if (_prevDirection != direction) {
    sendMessage({
		command : Network.UpdateUpgrade,
		socket,
		upgID,
		extrainfo : json_stringify({direction})
	});
}