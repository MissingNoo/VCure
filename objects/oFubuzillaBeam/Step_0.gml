image_speed = oImageSpeed * Delta;
//Feather disable once GM1041
if (owner != 0 and instance_exists(owner)) {
    x = owner.x + (35 * owner.image_xscale);
	y = owner.y - 55;
}
