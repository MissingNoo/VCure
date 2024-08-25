function heavy_artillery_create(obj){
	obj.mindmg = (UPGRADES[0].mindmg*333)/100;
	obj.maxdmg = (UPGRADES[0].maxdmg*333)/100;
	var closest = instance_nearest(obj.owner.x ,obj.owner.y, oEnemy);
	if (!instance_exists(closest)) { instance_destroy(obj); }
	else {
		obj.x = closest.x;
		obj.y = closest.y;
	}
}
function heavy_artillery_animation_end(obj){
	if (instance_exists(obj)) {
	    instance_destroy(obj);
	}
}
function perk_heavy_artillery_on_cooldown(data = {level : 0, upg : -1, enemy : noone}){
	instance_create_layer(oPlayer.x, oPlayer.y-8, "Upgrades", oUpgradeNew, {upg : global.upgradesAvaliable[Weapons.HeavyArtillery][data.level], shoots : 0});
}