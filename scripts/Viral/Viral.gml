function perk_viral_on_crit(data = {level : 0, upg : -1, enemy : noone, perk : undefined}){
	var _infectChance = data.perk.chance;
	_rnd = irandom_range(1, 100);
	//show_message(data.enemy);
	if (_rnd <= _infectChance and oPlayer.liaLikers < data.perk.maxInfected and data.enemy[$ "boss"] == false) {
		data.enemy.infected = true;
		_virusInfected = true;
		//data.enemy.speed = data.enemy.speed * global.player[?"speed"];
		data.enemy.baseSPD = data.enemy.baseSPD * global.player[?"speed"];
		data.enemy.hp = data.enemy.baseHP;
		oPlayer.liaLikers += 1;
		dmg = 0;
	}				    
}