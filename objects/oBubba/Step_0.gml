if (global.gamePaused) {
	speed = 0;
    exit;
}
speed = basespeed;
barktimer -= 0.75 * Delta;
if (barktimer < 0) {
    barktimer = 100;
	instance_create_depth(x, y, depth - 1, oBubbaBark, {level : level});
}
direction = point_direction(x, y, target.x, target.y);
if (distance_to_point(target.x, target.y) < 10 or x - xprevious > 50) {
    target.x = oPlayer.x + irandom_range(-200, 200);
    target.y = oPlayer.y + irandom_range(-200, 200);
}
if (direction < 90 or direction > 270) {
    image_xscale = 1;
}
if (direction > 90 and direction < 270) {
    image_xscale = -1;
}
var list = ds_list_create();
var amount = collision_circle_list(x, y, oPlayer.pickupRadius, oXP, false, true, list, true);
for (var i = 0; i < ds_list_size(list); i += 1) {
    var inst = list[| i];
    inst.onBubbaArea = true;
}
var xpcol = instance_place(x, y, oXP);
if (xpcol != noone) {
    add_xp(xpcol);
}