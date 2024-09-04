function perk_slumber_on_cooldown(data = {level : 0}) {
	if (!oPlayer.moving) {
	    if (add_buff_to_player(BuffNames.Slumber)) {
		    oPlayer.slumber = true;
		}
	}
	
	if (player_have_buff(BuffNames.Slumber)) {
		var pos = player_get_buff_pos(BuffNames.Slumber);
		if (PlayerBuffs[pos][$ "icon"] == sAnyaPerk3){
			if (PlayerBuffs[pos][$ "count"] < 10) {
				PlayerBuffs[pos].count++;
			}
			if (HP < MAXHP) {
			    var healpercent = 0;
				switch (data.level) {
				    case 1:
				        healpercent = 9;
				        break;
				    case 2:
				        healpercent = 12;
				        break;
				    case 3:
				        healpercent = 15;
				        break;
				}
			    var calc = ceil((MAXHP * 15) / 100);
			    HP += calc;
				damage_number_spawn(oPlayer, calc, false, false, true);
			}
		}
	}
}

function perk_slumber_on_move(){
	if (player_have_buff(BuffNames.Slumber)) {
		var pos = player_get_buff_pos(BuffNames.Slumber);
		PlayerBuffs[pos][$ "icon"] = sAnyaPerk3D;
		PlayerBuffs[pos][$ "permanent"] = undefined;
		PlayerBuffs[pos][$ "cooldown"] = 2;
		oPlayer.slumber = false;
	}
}

function perk_slumber_on_player_hit(data = {level : 0, damage : 0}) {
	if (player_have_buff(BuffNames.Slumber)) {
		var pos = player_get_buff_pos(BuffNames.Slumber);
		if (PlayerBuffs[pos][$ "icon"] == sAnyaPerk3) {
			var count = PlayerBuffs[pos][$ "count"];
			return ((data.damage * (5 * count)) / 100) * -1;
		}
	}
	return 0;
}

function perk_slumber_on_hit(data = {enemy : noone}) {
	if (player_have_buff(BuffNames.Slumber)) {
		var pos = player_get_buff_pos(BuffNames.Slumber);
		if (PlayerBuffs[pos][$ "icon"] == sAnyaPerk3) {
			var count = PlayerBuffs[pos][$ "count"];
			return ((data.damage * (7 * count)) / 100) * -1;
		}
	}
	return 0;
}