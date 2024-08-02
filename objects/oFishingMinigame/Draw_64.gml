if (!surface_exists(rhythmsurf)) {
	rhythmsurf = surface_create(sprite_get_width(sRhythmBar) + 100, sprite_get_height(sRhythmBar) + 20);
}
else {
	surface_set_target(rhythmsurf);
	draw_clear_alpha(c_black, 0);
	draw_sprite(sRhythmBar, 0, 0, 0);
	draw_sprite_ext(sRhythmButton, key, xx, sprite_get_height(sRhythmBar) / 2, scale, scale, 0, c_white, alpha);
	draw_sprite_ext(sFishingGrade, judgement, jx, (sprite_get_height(sRhythmBar) - 20) / 2 + 40, 1, 1, 0, c_white, jalpha);
	jalpha -= 0.025;
	alpha -= 0.05;
	scale += 0.10;
	for (var i = array_length(keys) - 1; i >= 0 ; --i) {
		draw_sprite_ext(sRhythmButton, keys[i].spr, keys[i].pos, sprite_get_height(sRhythmBar) / 2, 1, 1, 0, c_white, 1);
	}
	surface_reset_target();
}
//if (true) {
if (caught) {
	var _x = GW/2;
	var _sw = (surface_get_width(rhythmsurf) + 50) / 2;
	var _y = GH/1.50;
	draw_surface_ext(rhythmsurf, _x - _sw, _y, 2, 2, 0, c_white, 1);
	draw_set_alpha(0.35);
	draw_rectangle_color(0, 0, GW, bars[0], c_black, c_black, c_black, c_black, false);
	draw_rectangle_color(0, GH, GW, GH - bars[0], c_black, c_black, c_black, c_black, false);
	draw_set_alpha(1);
	scribble($"CHAIN: {combo}").scale(3).draw(_x + _sw + 70, _y + 15);
	scribble($"Bonus Fish: {bonusFish}").scale(2).draw(_x + _sw + 80, _y + 58);
	draw_healthbar(GW/2 - 215, GH/3.25 - 16, GW/2 + 220, GH/3.25 + 20, hp, c_black, c_aqua, c_aqua, 0, 1, false);
	draw_sprite_ext(sHook, 0, GW/2, GH/3.25, 2.50, 2.50, 0, c_white, 1);
}
var _text = "";
//for (var i = array_length(Fishes.data) - 1; i >= 0; --i) {
//    _text += $"\n[{sprite_get_name(Fishes.data[i].icon)},{Fishes.data[i].golden ? 1 : 0}]:{Fishes.data[i].amount}";
//}
//scribble(_text).scale(2).draw(10, 10);
//var _spd = 2;
//var _combolen = string_length(string(combo));
//var _comboval = 0;
//if (_combolen == 2) {
//    _comboval = real(string_char_at(string(combo), 1));
//}
//if (_combolen > 2) {
//    _comboval = 7;
//}
//_comboval -= 2;
//_spd = clamp(_spd + (_comboval / 2), 2, 7);
//_spd += min(35, ((combo div 10) * 5));
//var _names = variable_struct_get_names(self);
//for (var i = array_length(_names) - 1; i >= 0; --i) {
//	if (is_array(variable_struct_get(self, _names[i]))) {
//	    continue;
//	}
//    _text += $"\n{_names[i]}: {string_replace_all(variable_struct_get(self, _names[i]), "[", "[[")}";
//}
//scribble(_text).scale(2).draw(10, 10);
//scribble($"[fa_right]{(bpm / DebugManager.a)}").scale(2).draw(GW - 10, 10);
//scribble($"{_spd}/{combo}/_comboval").scale(2).draw(10, 10);
