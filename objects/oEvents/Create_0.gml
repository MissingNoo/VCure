if (instance_exists(oPlayer)) {
    depth = layer_get_depth("Clouds");
}
repeatSource = undefined;
enable = true;
var _my_method = function()
{
	if (!global.gamePaused) {
	    event = true;
	}
}
clouds = [];
spawnCloud = function(){
	if (!instance_exists(oPlayer)) { return; }
	if (global.gamePaused) { return; }
	var _size = irandom_range(0, 9);
	var _speed = random_range(0.2, 0.5);
	var _x = oPlayer.x - 500;
	var _y = oPlayer.y + random_range(-100, 100);
	array_push(clouds, [_x, _y, _speed, _size]);
}
//feather disable GM2017
_time_source = time_source_create(time_source_game, 3, time_source_units_seconds, _my_method);
time_source_start(_time_source);
_cloud = time_source_create(time_source_game, 10, time_source_units_seconds, spawnCloud,[], -1);
time_source_start(_cloud);
event = true;
