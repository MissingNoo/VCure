function perk_mukirose(o, event = WeaponEvent.Null){
	switch (o) {
	    case 1:
			oPlayer.mukirose[0] = true;
			oPlayer.mukirose[1] = 50;
			oPlayer.mukirose[2] = .5;
			break;
	    case 2:
			oPlayer.mukirose[1] = 66;
			oPlayer.mukirose[2] = .75;
			break;
	    case 3:
			oPlayer.mukirose[1] = 75;
			oPlayer.mukirose[2] = 1;
			break;
	}
}
