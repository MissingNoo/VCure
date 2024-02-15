switch (currentStep) {
    case ConfigSteps.Language:
		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);
		DebugManager.debug_add_config("a", DebugTypes.UpDown, self, "a");
		DebugManager.debug_add_config("b", DebugTypes.UpDown, self, "b");
		DebugManager.debug_add_config("c", DebugTypes.UpDown, self, "c");
        draw_text_transformed(GW/2, GH/2 - 128, "Language", 4, 4, 0);
		var _offset = 0;
		for (var i = 0; i <= selectedLanguage[1]; ++i) {
			var _isSelected = selectedLanguage[0] == i;
			var _color = _isSelected ? c_black : c_white;
			var _xscale = _isSelected ? 1.75 : 1.5;
		    draw_sprite_ext(sHudButton, _isSelected, GW/2, GH/2 + _offset, _xscale, 2, 0, c_white, 1);
			draw_text_transformed_color(GW/2, GH/2 + _offset, languages[i][0], 2, 2, 0, _color, _color, _color, _color, 1);
			var _w = (sprite_get_width(sHudButton) * _xscale) / 2;
			var _h = sprite_get_height(sHudButton) / 2;
			if (mouse_on_area([GW/2 - _w, GH/2 - _h + _offset, GW/2 + _w, GH/2 + _h + _offset])) {
			    selectedLanguage[0] = i;
			}
			_offset += 75;
		}
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
        break;
    default:
        // code here
        break;
}