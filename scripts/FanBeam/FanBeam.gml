function fanbeam_create(obj){
	obj.image_xscale = obj.owner.image_xscale;
	if(obj.shoots == -1){
		obj.image_xscale = obj.image_xscale * -1;
	}
}
function fanbeam_step(obj){
	x = obj.owner.x;
	y = obj.owner.y;
}
function fanbeam_animation_end(obj){
	instance_destroy(obj);
}