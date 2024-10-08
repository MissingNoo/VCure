draw_sprite_ext(sprite_index, 0, GW/2, offset, 2, 2, 0, c_white, 1);
draw_sprite_ext(prize.sprite, 0, GW/2, offset, 2, 2, 0, c_white, 1);
var _text = "";
if (prize.name != "Nothing") {
    _text = $"{prize.name} x {amount}";
}
else {
	_text = $"{prize.name}";
}
scribble($"[sHFontOutline][fa_middle][fa_center]{_text}").scale(2).draw(GW/2, offset + 85);

scribble($"[sHFontOutline][fa_middle][fa_center]{prize.name != "Nothing" ? "PICKED!" : "FAIL!"}").scale(4).draw(GW/2, offset - 85);
draw_sprite_ext(sHudButton, 1, GW/2, offset + 172, 1.25, 2, 0, c_white, 1);
scribble($"[c_black][fa_middle][fa_center]OK").scale(2.25).draw(GW/2, offset + 174);