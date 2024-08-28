function perk_mukirose_on_cooldown(data = {level : 0, upg : -1, enemy : noone}) {
	switch (data.level) {
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
