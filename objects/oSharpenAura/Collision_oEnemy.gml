if (timer > 0) { exit; }
timer = 1;
var pos = player_get_buff_pos(BuffNames.Sharpen);
var _dmg = irandom_range(UPGRADES[0][$ "mindmg"], UPGRADES[0][$ "maxdmg"]);
var percent = 1;
switch (level) {
	case 1:
	    percent = 40;
	    break;
	case 2:
	    percent = 50;
	    break;
	case 3:
	    percent = 60;
	    break;
}
var final_dmg = 0;
for (var i = 1; i <= PlayerBuffs[pos][$ "count"] ; ++i) {
	if (i % 10 == 0) {
		final_dmg += (_dmg * percent) / 100;
	}
}
other.damaged = true;
other.hp -= final_dmg;
other.damagedAlarm = 15;
damage_number_spawn(other, final_dmg, false);