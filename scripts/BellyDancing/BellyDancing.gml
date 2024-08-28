function belly_dancing_on_cooldown(data = {level : 0, upg : -1, enemy : noone}) {
	add_buff_to_player(BuffNames.BellyDance);
	var pos = player_get_buff_pos(BuffNames.BellyDance);
	switch (data.level) {
	    case 1:
			PlayerBuffs[pos][$ "level"] = 0.20;
	        break;
	    case 2:
	        PlayerBuffs[pos][$ "level"] = 0.30;
	        break;
	    case 3:
	        PlayerBuffs[pos][$ "level"] = 0.40;
	        break;
	}
}

function buff_belly_dance_cooldown() {
	var pos = player_get_buff_pos(BuffNames.BellyDance);
	if (oPlayer.moving) {
		PlayerBuffs[pos][$ "count"]++;
	}
	else if (PlayerBuffs[pos][$ "count"] > 0) {
		instance_create_depth(oPlayer.x, oPlayer.y, oPlayer.depth, oUpgradeAttach, {upg : UPGRADES[0], mindmg : UPGRADES[0][$ "mindmg"], maxdmg : UPGRADES[0][$ "maxdmg"], sprite_index : sAkiCircle, step : bellydance_step, image_xscale : .1, image_yscale : .1, count : PlayerBuffs[pos][$ "count"]})
		PlayerBuffs[pos][$ "count"] = 0;
	}
}