function amepistol_create(obj){
	obj.direction = global.arrowDir;
	obj.image_angle = global.arrowDir;
	if (obj.shoots > 0 and oPlayer.slowTime) { //TODO: multiplayer
		global.upgradeCooldown[Weapons.AmePistol] = global.upgradeCooldown[Weapons.AmePistol] / 2;
	}
	obj.amePistolLastHit = false;
}
function amepistol_on_hit(obj){
	if (obj.upg[$"level"] == obj.upg[$"maxlevel"]) {
		if (other.helddamagetimer == 0) {
			other.helddamagetimer = 2;
		}
	}
	if (obj.hits == 1 and !obj.amePistolLastHit and obj.upg[$"level"] >= 4) {
		obj.amePistolLastHit = true;
		obj.hits += 5;
		obj.direction = random(360);
	}
}