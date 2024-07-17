function asacoco_create(obj){
	obj.originaly = obj.y;
	obj.image_alpha = .99;
	if (instance_exists(oEnemy)) {
		var enemies = instance_number(oEnemy);
		obj.ce = instance_find(oEnemy, irandom_range(0,enemies-1));
		obj.direction = point_direction(obj.x,obj.y-50.75,obj.ce.x, obj.ce.y);
		obj.image_angle = point_direction(obj.x,obj.y-50.75,obj.ce.x, obj.ce.y);
	} 
	else {
		instance_destroy(obj);
		exit;
	}
	obj.originalspeed = obj.speed;
	obj.speed = 0;
	array_push(obj.dAlarm, [30, function(){}]);
	obj.asacocoalarmpos = array_length(obj.dAlarm) - 1;
}
function asacoco_step(obj){
	if (obj.dAlarm[obj.asacocoalarmpos][0] > 0) {
			obj.y -= 1.75;
			//extra.asay = y;
			if (instance_exists(obj.ce)) {
				obj.direction = point_direction(obj.x, obj.y, obj.ce.x, obj.ce.y);
				obj.image_angle = point_direction(obj.x, obj.y, obj.ce.x, obj.ce.y);
			}				
		}
		else {
			obj.image_alpha = 1;
			obj.dAlarm[0][0] = obj.upg.duration;
			obj.speed = obj.originalspeed;
		}
}