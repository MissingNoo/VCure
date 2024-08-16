if (!instance_exists(oPlayer)) { exit; }
for (var i = 0; i < array_length(clouds); ++i) {
	if (global.gamePaused) { return; }
    clouds[i][0] += clouds[i][2];
}
while (array_length(clouds) > 15) {
    array_shift(clouds);
}

//if (event == false and time_source_get_state(_time_source) == time_source_state_stopped) {
//    time_source_reset(_time_source);
//	time_source_start(_time_source);
//}
if (lastsecond < round(Seconds)) {
    event = true;
}
if (instance_exists(oPlayer) and enable) {
	//feather disable once GM1041
	var _seconds = string(round(Seconds));
	if (real(_seconds) < 10) { _seconds = $"0{_seconds}"; }
	var _minutes = string(round(Minutes));
	if (real(_minutes) < 10) { _minutes= $"0{_minutes}"; }
	var _time = global.stage[$ "Stage1"][$ string($"m{_minutes}s{_seconds}")];	
	if (_time != undefined and event) {
	    event = false;
		lastsecond = round(Seconds);
		if (_time[$ "event"] != undefined) {
			for (var i = array_length(_time[$ "event"]) - 1; i >= 0; --i) {
				var _hp = _time[$ "event"][i][$ "hp"] == undefined ? "-" : _time[$ "event"][i][$ "hp"];
				var _atk = _time[$ "event"][i][$ "atk"] == undefined ? "-" : _time[$ "event"][i][$ "atk"];
				var _spd = _time[$ "event"][i][$ "spd"] == undefined ? "-" : _time[$ "event"][i][$ "spd"];
				var _xp = _time[$ "event"][i][$ "xp"] == undefined ? "-" : _time[$ "event"][i][$ "xp"];
				var _lifetime = _time[$ "event"][i][$ "lifetime"] == undefined ? "-" : _time[$ "event"][i][$ "lifetime"];
				var _followplayer = _time[$ "event"][i][$ "followPlayer"] == undefined ? 0 : _time[$ "event"][i][$ "followPlayer"];
				var _radius = _time[$ "event"][i][$ "radius"] == undefined ? 1 : _time[$ "event"][i][$ "radius"];
				var _offset = _time[$ "event"][i][$ "offset"] == undefined ? 1 : _time[$ "event"][i][$ "offset"];				
				if (_time[$ "event"][i][$ "offset"] == undefined) {
				    _offset = 1;
				}
				if (_time[$ "event"][i][$ "offset"] == 1) {
				    _offset = 2;
				}
				spawn_event(_time[$ "event"][i][$ "id"], _time[$ "event"][i][$ "pattern"], _hp, _atk, _spd, _xp, _lifetime, _time[$ "event"][i][$ "amount"], _radius, undefined, _followplayer, _offset);
			}
		}
		if (_time[$ "addEnemy"] != undefined) {
			for (var i = array_length(_time[$ "addEnemy"]) - 1; i >= 0; --i) {
				add_enemy_to_pool(_time[$ "addEnemy"][i]);
			}
		}
		if (_time[$ "delEnemy"] != undefined) {
			for (var i = array_length(_time[$ "delEnemy"]) - 1; i >= 0; --i) {
				remove_enemy_from_pool(_time[$ "delEnemy"][i]);
			}
		}
	}
	//if (_seconds == 5 and Minutes == 0 and event) {	
}