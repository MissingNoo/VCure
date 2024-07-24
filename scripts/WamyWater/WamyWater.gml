function wamy_water_create(obj){
	obj.image_angle = obj.arrowDir;
}
function wamy_water_animation_end(obj){
	if (instance_exists(obj)) {
	    instance_destroy(obj);
	}
}