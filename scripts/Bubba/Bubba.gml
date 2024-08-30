function perk_bubba_on_cooldown(data = {level : 0, upg : -1, enemy : noone}) {
	switch (data.level) {
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