if (distance_to_object(oPlayer) > distanceFromPlayer) {
    speed = lerp(speed, spd, 0.1);
}
else {
	speed = lerp(speed, 0, 0.1);
}