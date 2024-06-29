//enum MascotID {
//	Bubba,
//	Boos
//}
//global.mascots = [];
//function Mascot(_name, _sprite, _walksprite) constructor{
//	name = _name;
//	sprite = _sprite;
//	walksprite = _walksprite;
//	create = undefined;
//	beginstep = undefined;
//	step = undefined;
//	endstep = undefined;
//	draw = undefined;
//	static setcreate = function(func) {
//		create = func;
//		return self;
//	}
//	static setbeginstep = function(func) {
//		beginstep = func;
//		return self;
//	}
//	static setstep = function(func) {
//		step = func;
//		return self;
//	}
//	static setendstep = function(func) {
//		endstep = func;
//		return self;
//	}
//	static setdraw = function(func) {
//		draw = func;
//		return self;
//	}
//}
//global.mascots[MascotID.Bubba] = new Mascot("Bubba", sAmeBubba, sAmeBubba);
//global.mascots[MascotID.Boos] = new Mascot("Boos", sXiboo, sXiboo);
//global.mascots[MascotID.Boos].setcreate(function(){
//	x = oPlayer.x;
//	y = oPlayer.y;
//	sprite_index = choose(sXiboo, sDiaboo, sSpoodle, sCupid, sChillaboo);
//	originalDistance = 20;
//	distanceFromPlayer = originalDistance;
//	spd = 1.25;
//	speed = 1.25;
//	direction = 0;
//	originalScale = 0.75;
//	scale = originalScale;
//	scaleMult = 1;
//	image_xscale = scale;
//	image_yscale = scale;

//	goingInside = false;
//	alarm[0] = 10 * 60;
//	alarm[1] = 5 * 60;
//}).setbeginstep(function(){
//	if (direction > 90 and direction < 270) {
//	    scaleMult = -1
//	}
//	else {
//		scaleMult = 1;
//	}
//	direction += angle_difference(point_direction(x, y, oPlayer.x, oPlayer.y), direction) * 0.1;
//}).setstep(function(){
//	if (keyboard_check_pressed(vk_numpad0) or distance_to_object(oPlayer) > 300) {
//	    instance_destroy(self);
//	}
//	if (goingInside) {
//		scale = lerp(scale, 0, 0.1);
//	}
//	else {
//		scale = lerp(scale, originalScale, 0.1);
//	}
//	image_xscale = scale * scaleMult;
//	image_yscale = scale;
//}).setendstep(function(){
//	if (distance_to_object(oPlayer) > distanceFromPlayer) {
//	    speed = lerp(speed, spd, 0.1);
//	}
//	else {
//		speed = lerp(speed, 0, 0.1);
//	}
//}).setdraw(function(){
//	draw_self();
//});
