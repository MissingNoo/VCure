function heavy_artillery_create(obj){
	obj.mindmg = (UPGRADES[0].mindmg*333)/100;
	obj.maxdmg = (UPGRADES[0].maxdmg*333)/100;
	var closest = instance_nearest(oPlayer.x ,oPlayer.y, oEnemy);
	if (!instance_exists(closest)) { instance_destroy(); }
	obj.x = closest.x;
	obj.y = closest.y;
}
function heavy_artillery_animation_end(obj){
	if (instance_exists(obj)) {
	    instance_destroy(obj);
	}
}