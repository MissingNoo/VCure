if (distance_to_point(xx, yy) > 3) {
    direction = point_direction(x, y, xx, yy);
	speed = spd;
}
else{ speed = 0; x = xx; y = yy; }