function holobomb_create(obj){
	obj.x = obj.owner.x + irandom_range(-50,50);
	obj.y = obj.owner.y + (irandom_range(-50,50));
	obj.depth = obj.owner.depth;
}
function holobomb_on_hit(obj){
	obj.image_xscale = obj.original_scale[0];
	obj.image_yscale = obj.original_scale[1];
	obj.sprite_index = sBombExplosion;
	obj.level = obj.upg[$ "level"];
	update_sprite_info(obj, 0);
	obj.animate = true;
	var calc = get_bonus_percent(BonusType.WeaponSize);
	obj.image_xscale = obj.image_xscale + ((obj.image_xscale * calc) / 100);
	obj.image_yscale = obj.image_yscale + ((obj.image_yscale * calc) / 100);
	if (obj.level >= 2) {
		obj.image_xscale = obj.image_xscale * 1.15;
		obj.image_yscale = obj.image_yscale * 1.15;
	}
	if (obj.level >= 6) {
		obj.image_xscale = obj.image_xscale * 1.35;
		obj.image_yscale = obj.image_yscale * 1.35;
	}
}
function holobomb_animation_end(obj){
	if (!instance_exists(obj)) { exit; }
	if (obj.sprite_index = sBombExplosion) {
	    instance_destroy(obj);
	}
}