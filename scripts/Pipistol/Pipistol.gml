function pipipistol_create(obj){
	obj.direction = obj.arrowDir;
	obj.image_angle = obj.arrowDir;
	//alarm[0] = 10;
	if (obj.remaining_shoots % 2) {
	//if (shoots == -1) {
		obj.sprite_index = sBulletBlue;
		var enemies = instance_number(oEnemy);
		obj.ce = instance_find(oEnemy, irandom_range(0,enemies-1));
		try{
			obj.direction = point_direction(obj.x, obj.y, obj.ce.x, obj.ce.y - 8);
			obj.image_angle = point_direction(obj.x, obj.y, obj.ce.x, obj.ce.y - 8);
		}
		catch (err){
			obj.direction = point_direction(obj.x, obj.y, 0, 0);
			obj.image_angle = point_direction(obj.x, obj.y, 0, 0);
		}				
	}
}