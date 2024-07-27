function en_curse_create(obj){
	obj.direction = obj.arrowDir;
	obj.image_angle  = obj.arrowDir;
}
function en_curse_on_hit(obj){
	var chance = irandom_range(0, 100);
	//show_debug_message($"###\nchance:{chance}/{obj.upg[$ "chance"]}\nRange:{obj.upg[$ "range"]}");
	if (chance <= obj.upg[$ "chance"]) {
		//feather disable once GM1041
		var _list = ds_list_create();
		var _num = collision_circle_list(obj.x, obj.y, obj.upg.range, oEnemy, false, true, _list, false);
		if (_num > 0)
		{
			var near = noone;
			do{
				var rnd = ds_list_size(_list) - 1;
				near = _list[| irandom_range(0, rnd)];
				ds_list_delete(_list, rnd);
				if (ds_list_size(_list) <= 0) {
					break;
				}
			} until (near != noone and instance_exists(near));
			if (near != noone and instance_exists(near)) {
				if (instance_exists(near)){
					obj.hits = 2;
					obj.image_alpha = 1;
					obj.image_angle = point_direction(obj.x, obj.y, near.x, near.y - 8);
					obj.direction = point_direction(obj.x, obj.y, near.x, near.y - 8);
					if (obj.upg.level == 7) {
						obj.mindmg = obj.mindmg + ((obj.mindmg * 10) / 100);
						obj.maxndmg = obj.maxdmg + ((obj.maxdmg * 10) / 100);
					}
				}
			}
		}
		ds_list_destroy(_list);
	}
}