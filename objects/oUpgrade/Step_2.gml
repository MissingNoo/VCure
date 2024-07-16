if (global.pauseGame) { exit; }
if (subImg < maxImg and sprReset and !stopanimation) {
	subImg += sprSpeed / game_get_speed(sprSpeedType) * Delta;
	if (subImg > maxImg) {
		subImg = maxImg;
		event_perform(ev_other, ev_animation_end);
	}
}
if (instance_exists(enemyTarget) and direction - point_direction(x, y, enemyTarget.x, enemyTarget.y - 8) < -250) {
	direction = point_direction(x, y, enemyTarget.x, enemyTarget.y - 8);
}
if (instance_exists(enemyTarget) and direction - point_direction(x, y, enemyTarget.x, enemyTarget.y - 8) > 360) {
	direction = point_direction(x, y, enemyTarget.x, enemyTarget.y - 8);
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
