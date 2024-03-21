//distanceFromPlayer = oGui.a;
//spd = oGui.b;
//image_xscale = oGui.c;
//image_yscale = oGui.c;
//if (oPlayer.image_xscale < 0) {
//    image_xscale = image_xscale * -1;
//}
if (direction > 90 and direction < 270) {
    scaleMult = -1
}
else {
	scaleMult = 1;
}
direction = lerp(direction, point_direction(x, y, oPlayer.x, oPlayer.y), 0.1);