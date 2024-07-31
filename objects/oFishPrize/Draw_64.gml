draw_sprite_ext(sprite_index, 0, GW/2, offset, 2, 2, 0, c_white, 1) ;
draw_sprite_ext(prize.icon, 0, GW/2, offset, 2, 2, 0, c_white, 1) ;
var _off = [[-2, 0], [2, 0], [0, -2], [0, 2]];
var _text = "";
if (prize.name != "Nothing") {
    _text = $"{prize.name} x {amount}";
}
else {
	_text = $"{prize.name}";
}
for (var i = array_length(_off) - 1; i >= 0 ; --i) {
    scribble($"[c_black][fa_middle][fa_center]{_text}").scale(2).draw(GW/2 + _off[i][0], offset + 85 + _off[i][1]);
	scribble($"[c_black][fa_middle][fa_center]{prize.name != "Nothing" ? "CAUGHT!" : "FAIL!"}").scale(4).draw(GW/2 + _off[i][0], offset - 85 + _off[i][1]);
}
scribble($"[fa_middle][fa_center]{_text}").scale(2).draw(GW/2, offset + 85);
scribble($"[fa_middle][fa_center]{prize.name != "Nothing" ? "CAUGHT!" : "FAIL!"}").scale(4).draw(GW/2, offset - 85);
draw_sprite_ext(sHudButton, 1, GW/2, offset + 172, 1.25, 2, 0, c_white, 1);
scribble($"[c_black][fa_middle][fa_center]OK").scale(2.25).draw(GW/2, offset + 174);