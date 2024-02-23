draw_text(10, 10, currentStep);
DebugManager.debug_add_config("a", DebugTypes.UpDown, self, "a");
DebugManager.debug_add_config("b", DebugTypes.UpDown, self, "b");
DebugManager.debug_add_config("c", DebugTypes.UpDown, self, "c");
var _offset;
switch (currentStep) {
    case ConfigSteps.Language:
		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);
        draw_text_transformed(GW/2, GH/2 - 128, "Language", 4, 4, 0);
		_offset = 0;
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
	case ConfigSteps.PlayerName:
		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);
		draw_text_transformed(GW/2, GH/2 - 50, lexicon_text("Config.PlayerName"), 3, 3, 0);
		var _min = [(string_width("Player") * 2 / 2) + 5, (string_height("Player") * 2 / 2) + 2];
		var _nameSize = [(string_width(playername) * 2 / 2) + 5, (string_height(playername) * 2 / 2) + 2];
		if (_nameSize[0] < _min[0]) { _nameSize[0] = _min[0]; }
		if (_nameSize[1] < _min[1]) { _nameSize[1] = _min[1]; }
		draw_rectangle(GW/2 - _nameSize[0], GH/2 - _nameSize[1], GW/2 + _nameSize[0], GH/2 + _nameSize[1], true);
		draw_text_transformed(GW/2, GH/2, playername, 2, 2, 0);
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
		break;
	case ConfigSteps.ShowNames:
		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);
		draw_text_transformed(GW/2, GH/2 - 130, lexicon_text("Config.ShowNames1"), 3, 3, 0);
		_offset = -51;
		for (var i = 0; i <= 1; ++i) {
			var _text = i == 0 ? lexicon_text("Config.Show") : lexicon_text("Config.DontShow");
			var _isSelected = showOtherNames == i;
			var _color = _isSelected ? c_black : c_white;
			var _xscale = _isSelected ? 1.75 : 1.5;
		    draw_sprite_ext(sHudButton, _isSelected, GW/2, GH/2 + _offset, _xscale, 2, 0, c_white, 1);
			draw_text_transformed_color(GW/2, GH/2 + _offset, _text, 2, 2, 0, _color, _color, _color, _color, 1);
			var _w = (sprite_get_width(sHudButton) * _xscale) / 2;
			var _h = sprite_get_height(sHudButton) / 2;
			if (mouse_on_area([GW/2 - _w, GH/2 - _h + _offset, GW/2 + _w, GH/2 + _h + _offset])) {
			    showOtherNames = i;
			}
			_offset += 75;
		}
		draw_text_transformed(GW/2, GH/2 + 130, lexicon_text("Config.ShowNames2"), 2, 2, 0);
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
		break;
	case ConfigSteps.Anonymous:
		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);
		draw_text_transformed_color(GW/2, GH/2 - 265, lexicon_text("Config.PlayerName") + ": " + playername, 2.5, 2.5, 0, c_yellow, c_yellow, c_yellow, c_yellow, 1);
		draw_text_transformed(GW/2, GH/2 - 140, lexicon_text("Config.ConsentText"), 2.5, 2.5, 0);
		_offset = 0;
		for (var i = 0; i <= 1; ++i) {
			var _text = i == 0 ? lexicon_text("Config.Consent") : lexicon_text("Config.DontConsent");
			var _isSelected = sendMyName == i;
			var _color = _isSelected ? c_black : c_white;
			var _xscale = _isSelected ? 1.75 : 1.5;
		    draw_sprite_ext(sHudButton, _isSelected, GW/2, GH/2 + _offset, _xscale, 2, 0, c_white, 1);
			draw_text_transformed_color(GW/2, GH/2 + _offset, _text, 2, 2, 0, _color, _color, _color, _color, 1);
			var _w = (sprite_get_width(sHudButton) * _xscale) / 2;
			var _h = sprite_get_height(sHudButton) / 2;
			if (mouse_on_area([GW/2 - _w, GH/2 - _h + _offset, GW/2 + _w, GH/2 + _h + _offset])) {
			    sendMyName = i;
			}
			_offset += 75;
		}
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
		break;
	case ConfigSteps.FinalInfo:
		var _info = [
						[lexicon_text("Config.LanguageText"), languages[selectedLanguage[0]][0]],
						[lexicon_text("Config.PlayerName"), playername],
						[lexicon_text("Config.ShowHiscoreNames"), !showOtherNames ? lexicon_text("Config.Show") : lexicon_text("Config.DontShow")],
						[lexicon_text("Config.ShowMyName"), !showOtherNames ? lexicon_text("Config.Consent") : lexicon_text("Config.DontConsent")],
					]
		_offset = 0;
		for (var i = 0; i < array_length(_info); ++i) {
		    draw_text_transformed(GW/2 - 256, GH/2 - 190 + _offset, _info[i][0], 2, 2, 0);
		    draw_text_transformed(GW/2 + 173, GH/2 - 190 + _offset, _info[i][1], 2, 2, 0);
			_offset += 62;
		}
		_offset = 128;
		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);
		for (var i = 0; i <= 1; ++i) {
			var _text = i == 0 ? lexicon_text("Config.FinalAccept") : lexicon_text("Config.FinalRefuse");
			var _isSelected = finalAccept == i;
			var _color = _isSelected ? c_black : c_white;
			var _xscale = _isSelected ? 1.75 : 1.5;
		    draw_sprite_ext(sHudButton, _isSelected, GW/2, GH/2 + _offset, _xscale, 2, 0, c_white, 1);
			draw_text_transformed_color(GW/2, GH/2 + _offset, _text, 2, 2, 0, _color, _color, _color, _color, 1);
			var _w = (sprite_get_width(sHudButton) * _xscale) / 2;
			var _h = sprite_get_height(sHudButton) / 2;
			if (mouse_on_area([GW/2 - _w, GH/2 - _h + _offset, GW/2 + _w, GH/2 + _h + _offset])) {
			    finalAccept = i;
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