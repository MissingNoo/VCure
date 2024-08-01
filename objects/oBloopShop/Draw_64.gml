var _yoff = 0;
var a = DebugManager.a;
var b = DebugManager.b;
var c = DebugManager.c;
var d = DebugManager.d;
var e = DebugManager.e;
draw_sprite_ext(sHudArea, 0, (GW - 30) - (sprite_get_width(sHudArea) * 8), 30, 8, 2.25, 0, c_white, 1);
scribble($"[fa_right][fa_middle][sSand]      {global.sand}").scale(2).draw(GW - 40, 52);
draw_sprite_ext(sHudArea, 0, (GW - 260) - (sprite_get_width(sHudArea) * 8), 30, 8, 2.25, 0, c_white, 1);
scribble($"[fa_right][fa_middle][sHolocoin,0]      {global.holocoins}").scale(2).draw(GW - 270, 52);
for (var i = 0; i < array_length(options); ++i) {
	var _spr = menuoption == i ? 1 : 0;
	var _color = menuoption == i ? "c_black" : "c_white";
    draw_sprite_ext(sHudButton, _spr, GW/6.76, GH/9.15 + 35 + _yoff, 1.5, 2, 0, c_white, 1);
	scribble(lexicon_text($"[{_color}][fa_middle][fa_center]ShopOptions.{options[i]}")).scale(2).draw(GW/6.76, GH/9.15+35+_yoff);
	_yoff += 75;
}
state.draw();