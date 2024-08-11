function glowstick_create(obj){
	if (instance_exists(oEnemy)) {
		var enemies = instance_number(oEnemy);
		if (enemies == 0) { instance_destroy(); }
		obj.ce = instance_find(oEnemy, irandom_range(0, enemies-1));
		obj.direction = point_direction(obj.x, obj.y, obj.ce.x, obj.ce.y);
		obj.image_angle = point_direction(obj.x, obj.y, obj.ce.x, obj.ce.y);
	} else instance_destroy();
}
function glowstick_animation_end(obj){
	if (instance_exists(obj)) {
		if (obj.sprite_index == sGlowstickThumbExplosion) {
		    instance_destroy(obj);
		}
		else {
			obj.animate = true;
		}
	}
}
function glowstick_step(obj){
	if (obj.hits <= 0) {
		obj.dAlarm[0][0] = 999;
		obj.sprite_index = sGlowstickThumbExplosion;
		update_sprite_info(obj, 0);
		obj.animate = true;
		obj.hits = 999;
		obj.image_alpha = 1;
		obj.speed = 0;
	}
	with (obj) {
	    if (distance_to_object(obj.owner) > 200) {
			direction = point_direction(obj.x, obj.y, obj.owner.x, obj.owner.y);
		}
	}
}