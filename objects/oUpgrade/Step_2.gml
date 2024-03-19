if (global.pauseGame) { exit; }
if (instance_exists(enemyTarget) and direction - point_direction(x, y, enemyTarget.x, enemyTarget.y) < -250) {
	direction = point_direction(x, y, enemyTarget.x, enemyTarget.y);
}
if (instance_exists(enemyTarget) and direction - point_direction(x, y, enemyTarget.x, enemyTarget.y) > 360) {
	direction = point_direction(x, y, enemyTarget.x, enemyTarget.y);
}
switch (upg[$ "id"]) {
    case Weapons.UrukaNote:{
		if (sprite_index == sMonsterPulse) {
		    image_xscale += 0.15;
		    image_yscale += 0.15;
		}
		break;
	}
    default:
        // code here
        break;
}
