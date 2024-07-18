function lavabucket_create(obj){
	random_set_seed(current_time + global.currentFrame);
	obj.x = oPlayer.x + irandom_range(-100,100);
	random_set_seed(current_time + global.currentFrame/ 2);
	obj.y = oPlayer.y + irandom_range(-100,100);
	obj.depth = layer_get_depth("Pools");
}

function lavabucket_animation_end(obj){
	if (!instance_exists(obj)) { exit; }
	switch (obj.sprite_index) {
	    case sLavaPoolStart:
			obj.sprite_index = sLavaPoolLoop;
			update_sprite_info(obj);
			//obj.dAlarm[0][0] = obj.upg.duration;
			array_push(obj.dAlarm, [obj.upg.duration/1.8, function(){}]);
			obj.loopalarm = array_length(obj.dAlarm) - 1;
	        break;
	    case sLavaPoolLoop:
			//obj.dAlarm[0][0] = obj.upg.duration;
			if (obj.dAlarm[obj.loopalarm][0] == -1) {
				obj.sprite_index = sLavaPoolEnd;
				update_sprite_info(obj, 1);
			}
	        break;
	    case sLavaPoolEnd:
	        instance_destroy(obj);
	        break;
	}
}