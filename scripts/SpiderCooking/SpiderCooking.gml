function spidercooking_create(obj){
	obj.x = oPlayer.x;
	obj.y = oPlayer.y - (sprite_get_height(global.player[?"sprite"]) / 3);
	obj.image_yscale = obj.image_xscale;
	for (var i = 0; i < instance_number(oUpgradeNew); ++i) {
		try{
			var inst = instance_find(oUpgradeNew, i);
			if (inst.upg[$ "id"] == Weapons.SpiderCooking and inst.id != obj) {
				instance_destroy(inst);
			}
		}
		catch (err){ }
	}
}
function spidercooking_step(obj){
	obj.x = oPlayer.x;
	obj.y = oPlayer.y - (sprite_get_height(global.player[?"sprite"]) / 3);
}
function spidercooking_draw(obj){
	draw_set_color(c_purple);
	draw_set_alpha(.35);
	draw_circle(obj.x, obj.y, (sprite_get_height(obj.sprite_index)/2) * obj.image_yscale, false);
	draw_set_alpha(1);
	draw_circle(obj.x, obj.y, (sprite_get_height(obj.sprite_index)/2) * obj.image_yscale, true);
	draw_set_color(c_white);
}