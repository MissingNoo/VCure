if (distance_to_object(oPlayer) < originalDistance) {
    x = oPlayer.x + irandom_range(-40, 40);
	y = oPlayer.y + irandom_range(-40, 40);
}
goingInside = false;
distanceFromPlayer = originalDistance;
sprite_index = choose(sXiboo, sDiaboo, sSpoodle, sCupid, sChillaboo, sBooba);
alarm[0] = 10 * 60;