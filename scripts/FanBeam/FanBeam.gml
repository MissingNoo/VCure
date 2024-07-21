function fanbeam_create(obj){
	obj.image_xscale = oPlayer.image_xscale;
	if(obj.shoots == -1){
		obj.image_xscale = obj.image_xscale * -1;
	}
}
function fanbeam_step(obj){
	x = oPlayer.x;
	y = oPlayer.y;
}
function fanbeam_animation_end(obj){
	instance_destroy(obj);
}