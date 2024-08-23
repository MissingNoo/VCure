function rest_note_on_hit(obj){
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
	draw_sprite_ext(sMetronome, ((mimg / room_speed) * simg), x, y - 8, DebugManager.a, DebugManager.a, 0, c_white, 1);
}