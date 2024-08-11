/// @instancevar {Any} upg 
/// @instancevar {Any} owner 
/// @instancevar {Any} updata 
/// @instancevar {Any} oid 
original_scale = [image_xscale, image_yscale];
afterimage = [[0], [0], [0], [0]];
alarm[0] = 700;
sprite_index = upg.sprite;
speed = upg.speed;
shoots = 0;
last_frame = sprite_get_number(sprite_index);
sprite_speed = sprite_get_speed(sprite_index);
sprite_speed_type = sprite_get_speed_type(sprite_index);
current_frame = 0;
animate = true;
dAlarm = [];
array_push(dAlarm, [upg.duration, function() {
	instance_destroy();
}]);
if (upg[$ "create"] != undefined) {
	upg.create(self.id);
}
var names = variable_struct_get_names(updata);
for (var i = 0; i < array_length(names); i++) {
	self[$ names[i]] = updata[$ names[i]];
}