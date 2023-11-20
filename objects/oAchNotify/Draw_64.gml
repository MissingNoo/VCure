if (ach == -1) { exit; }
draw_set_alpha(alpha);
//ach = AchievementIds.DeckedOut;
var _x = GW;
var _y = GH;

draw_set_valign(fa_bottom);
var _offset = 40;

var _name = lexicon_text(Achievements[ach].name);
var _nameScale = 2;
var _nameHeight = string_height(_name) * _nameScale;
var _nameWidth= string_width(_name) * _nameScale;
var _endTextOffset = _offset;
_offset += _nameWidth;
var _textOffset = _offset;

_offset += 30;
_offset += sprite_get_width(sItemSquare);
var _squareOffset = _offset;
var _squareHeight = sprite_get_height(sItemSquare);
_offset += sprite_get_width(sItemSquare);
_offset += 10;

var _height = GH - _nameHeight - 30;
draw_set_alpha(alpha/1.75);
draw_rectangle_color(GW - _offset, GH, GW, _height - _nameHeight, c_black, c_black, c_black, c_black, false);
draw_set_alpha(alpha);
draw_text_transformed(GW - _textOffset, _height, _name, 2, 2, 0);
draw_text_transformed(GW - _textOffset - 5, _height + _nameHeight, "Achievement", 2, 2, 0);
draw_text_transformed(GW - _textOffset + 35, _height + _nameHeight + 20, "Get", 2, 2, 0);
draw_line(_x - _textOffset, _height, _x - _endTextOffset, _height);
draw_line(_x - _textOffset, _height+1, _x - _endTextOffset, _height+1);
draw_sprite_ext(sItemSquare, 0, _x - _squareOffset, _y - _squareHeight * 1.25, 2, 2, 0, c_white, alpha);
var _thumb = Achievements[ach].thumbnail;
draw_sprite_ext(_thumb, 0, _x - _squareOffset, _y - _squareHeight * 1.25, 2, 2, 0, c_white, alpha);
draw_set_alpha(1);
draw_set_valign(fa_top);