function perk_cutting_deep_on_hit(data = {level : 0, upg : -1, enemy : noone, shottype : undefined}) {
	var _chance = -1;
	switch (data.level) {
		case 1:
		    _chance = 15;
		    break;
		case 2:
		    _chance = 20;
		    break;
		case 3:
			_chance = 25;
		    break;
	}
	var _list = ds_list_create();
	var num = collision_circle_list(oPlayer.x, oPlayer.y, oPlayer.pickupRadius, oEnemy, false, true, _list, true);
	var on_area = ds_list_find_index(_list, data.enemy.id);
	ds_list_destroy(_list);
	if (data.upg[$ "shotType"] == ShotTypes.Melee and on_area != -1) {
		var _rnd = irandom_range(0, 100);
		if (_rnd <= _chance) {
			resetcooldown = true;
		}
	}
}
