function rest_note_on_hit(obj){
	/// @localvar {Any} hasbuff 
	hasbuff = array_find_index(other.debuffs, function(e, i) {
		return e.id == BuffNames.RestNote;
	});
	if (hasbuff == -1) { array_push(other.debuffs, copy_struct(Buffs[BuffNames.RestNote])); }
	var _time = 0;
	for (var i = 0; i < array_length(PLAYER_PERKS); ++i) {
		if (PLAYER_PERKS[i].id == PerkIds.WeakBones) {
			_time = 2 + PLAYER_PERKS[i].level;
		}
	}
	for (var i = 0; i < array_length(other.debuffs); ++i) {
		if (other.debuffs[i].id == BuffNames.RestNote) {
			other.debuffs[i].enabled = true;
			other.debuffs[i].cooldown = _time;
		}
	}
}
function rest_buff_draw(x, y){
	/// @localvar {Any} mimg 
	if (!variable_instance_exists(self, "mimg")) { mimg = 0; }
	mimg += 1;
	if (mimg > 60) { mimg = 0; }
	var spr = sMetronome;
	var simg = sprite_get_number(spr);
	draw_sprite_ext(sMetronome, ((mimg / room_speed) * simg), x, y - 8, 1.50, 1.50, 0, c_white, 1);
}

function perk_weak_bones_on_player_hit(data = {level : 0}) {
	switch (data.level) {
		case 1:
			bonusdmg = 2;
			break;
		case 2:
			bonusdmg = 3;
			break;
		case 3:
			bonusdmg = 4;
			break;
	}
	if (!player_have_buff(BuffNames.RestNoteCooldown)) {
		add_buff_to_player(BuffNames.RestNoteCooldown);
		var _angles = [0, 45, 315, 135, 180, 225];
		var _w = WEAPONS_LIST[Weapons.RestNote][1];
		for (var j = 0; j < array_length(_angles); ++j) {
			instance_create_layer(self.x, self.y-8,"Upgrades",oUpgradeNew,{
				upg : _w,
				owner : self,
				direction : _angles[j]
			});
		}
	}

}