function perk_lick_on_cooldown(data = {level : 0, upg : -1, enemy : noone, perk : undefined}) {
	var _list = ds_list_create();
	var _y = oPlayer.y - (sprite_get_height(global.player[?"sprite"]) / 3);
	var _num = collision_circle_list(oPlayer.x, _y, data.perk.lickArea, oEnemy, false, true, _list, false);
	var totalheal = 0;
	for (var j = 0; j < _num; ++j) {
		var _heal = ceil(MAXHP/100);
		totalheal += _heal;
		heal_player(_heal);
	}
	show_debug_message("Lick healed:" + string(totalheal));
	ds_list_destroy(_list);
}

function perk_lick_draw(data = {perk : undefined}) {
	var lickArea = data.perk.lickArea;
	var _y = oPlayer.y - (sprite_get_height(oPlayer.sprite_index) / 3);
	draw_circle_color(oPlayer.x, _y, lickArea, c_white, c_white, true);
}