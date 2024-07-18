function ceotears_create(obj){
	if (instance_exists(oEnemy)) {
		var enemies = instance_number(oEnemy);
		if (enemies == 0) { instance_destroy(); }
		obj.ce = instance_find(oEnemy, irandom_range(0,enemies-1));
		obj.direction = point_direction(obj.x, obj.y, obj.ce.x, obj.ce.y);
		obj.image_angle = point_direction(obj.x, obj.y, obj.ce.x, obj.ce.y);
	} else instance_destroy();
}