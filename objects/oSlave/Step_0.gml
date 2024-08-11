if(direction > 90 and direction < 270) {
    image_xscale = -1;
}
else {
    image_xscale = 1;
}

if (point_distance(x, y, xx, yy) > 3) {
    move_towards_point(xx, yy, spd);
    speed = spd;
    sprite_index = runsprite;
    direction = point_direction(x, y, xx, yy);
}
else {
    sprite_index = sprite;
    speed = 0; 
}