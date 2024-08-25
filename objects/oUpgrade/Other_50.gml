/*var _prevDirection = direction;
switch (upg[$ "id"]) {
    case Weapons.XPotato:
		if (justBounced) { return; }
		if (!justBounced) {
		    justBounced = true;
			dAlarm[2]=50;
		}
		direction += 180;
		break;
	
	case Weapons.UrukaNote:
		
		break;
    default:
        // code here
        break;
}
if (_prevDirection != direction) {
    sendMessage(0, {
		command : Network.UpdateUpgrade,
		socket,
		upgID,
		extrainfo : json_stringify({direction})
	});
}