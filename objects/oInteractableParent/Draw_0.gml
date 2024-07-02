//feather disable all
draw_self();
_x = x;
_y = y - 40;
_draw = false;
if (x < oPlayer.x - view_wport[0] / 2) {
    _draw = true;
}
if (x > oPlayer.x + view_wport[0] / 2) {
    _draw = true;
}
if (y < oPlayer.y - view_hport[0] / 2) {
	_draw = true;
}
if (y - 60 > oPlayer.y + view_hport[0] / 2) {
	_draw = true;
}
draw_sprite_ext(onScreenArrow, 0, _x, _y, 1, 1, point_direction(_x, _y, x, y), c_white, 1);