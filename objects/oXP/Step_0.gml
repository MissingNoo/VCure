if (!global.gamePaused) {
	if (justSpawned) {
	    exit;
	}
	if (gotRainbow) {
		direction = point_direction(x, y, oPlayer.x, oPlayer.y);
		speed = oPlayer.spd * 1.3 * Delta;
		exit;
	}
	if (onArea) {
		direction = point_direction(x,y,oPlayer.x,oPlayer.y);
		speed = oPlayer.spd*1.3 * Delta;
	}
	else{
		speed = 0;
		//y = sine_wave(current_time / 1000, 1, .5, y);
		var nearestxp = instance_nearest(x,y, oXP);
		if (!nearestxp.justSpawned and distance_to_point(nearestxp.x, nearestxp.y) < 40) {
		    otherxp = collision_circle(x,y, 30, oXP,false,true);
		}
		if (otherxp != noone and !onArea and canMerge and otherxp.canMerge) {    
			direction = point_direction(x,y,otherxp.x,otherxp.y);
			speed = 1 * Delta;
			if (collision_circle(x,y, 3, oXP,false,true)) {
			    otherxp.xp += xp;
				instance_destroy();
			}
		}
	}
}