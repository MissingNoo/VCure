//feather disable all
var _ax = oPlayer.x - x;
var _ay = oPlayer.y - y;
var _xx = clamp(GW/2 - _ax * 2, 28, GW - 28);
var _yy = clamp(GH/2 - _ay * 2, 28, GH - 28);
depth = oGui.depth - 1;
if (_draw) {
    draw_sprite_ext(offScreenArrow, 0, _xx, _yy, 2, 2, point_direction(oPlayer.x, oPlayer.y, x, y), c_white, 1);
}