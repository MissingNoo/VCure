var offset;
NAME=CHARACTERS[selectedCharacter][?"name"];
var _isUnlocked = CharacterData[CHARACTERS[selectedCharacter][?"id"]].unlocked;
#region CharacterList
if (!characterSelected) {
	//Feather disable once GM1041
	scribble("[white][fa_middle][fa_center]Choose your vtuber").scale(4.30, 4.30).draw(GW/4, GH/8);
	var _offset = 0;
	var _yoffset = 0;
	var _x = GW/10;
	var _y = GH/4;
	//draw_sprite_ext(sWhiteBack, 0, GW/2.30, GH/6, .65, .48, 0, c_white, 1);
	//if (_isUnlocked) {
	//	draw_sprite_ext(CHARACTERS[selectedCharacter][?"bigArt"], 0, GW/1.86, GH/2.11, .5, .5, 0, c_white, 1);
	//}
	for (var i=1; i < Characters.Lenght; i++) {
		if (CHARACTERS[i][?"agency"] != selectedAgency and selectedAgency != "All") {
			continue;
		}
		var _pW = sprite_get_width(CHARACTERS[i][?"portrait"]);
		var _pH = sprite_get_height(CHARACTERS[i][?"portrait"]);
		if (!sidebarOpen and point_in_rectangle(MX, MY, _x - _pW + _offset, _y - _pH + _yoffset, _x + _pW + _offset, _y + _yoffset + _pH) and selectedCharacter == i and mouse_click) { menuClick = true; }
		if (!sidebarOpen and point_in_rectangle(MX, MY, _x - _pW + _offset, _y - _pH + _yoffset, _x + _pW + _offset, _y + _yoffset + _pH)) { selectedCharacter = i; }
		switch (CHARACTERS[i][? "finished"]) {
			case 0:
				if (os_get_config() == "Release") { continue; }
			    draw_set_color(c_red);
			    break;
			case 3:
				if (os_get_config() == "Release") { continue; }
			    draw_set_color(c_orange);
			    break;
		}
		draw_rectangle(_x - _pW - 2 + _offset, _y - _pH - 2 + _yoffset, _x + _pW + 2 + _offset, _y + _pH + 2 + _yoffset, false);
		draw_set_color(c_white);
		draw_sprite_ext(CharacterData[i].unlocked ? CHARACTERS[i][?"portrait"] : sCharacterLockedIcon, 0, _x + _offset, _y + _yoffset, 2, 2, 0, c_white, 1);
		if (selectedCharacter == i) {
			draw_sprite_ext(sMenuCharSelectCursor,-1,_x + _offset, _y + _yoffset, 2, 2, 0, c_white,1);
		}
		if (i == 5) {
			_yoffset += 85;
			_offset = 0;
		}
		else {
			_offset += 95;
		}
	}
	if (_isUnlocked) {
		scribble(string_replace(string_upper(CHARACTERS[selectedCharacter][?"name"]), " ", "\n")).scale(7, 7).draw(GW/1.48, GH/7.31);
		draw_sprite_ext(sCharShadow, 0, GW/1.41, GH/1.46, 5, 5, 0, c_white, 0.8);
		draw_sprite_ext(currentSprite == 0 ? CHARACTERS[selectedCharacter][?"sprite"] : CHARACTERS[selectedCharacter][?"runningsprite"], characterSubImage[0], GW/1.41, GH/1.46, 5, 5, 0, c_white, 1);
		var _charInfo = CHARACTERS[selectedCharacter];
		var _info = [[sHudHPIcon, _charInfo[?"hp"], ""], [sHudAtkIcon, _charInfo[?"atk"], "x"], [sHudSpdIcon,_charInfo[?"speed"], "x"], [sHudCrtIcon,_charInfo[?"crit"], "%"]];
		_yoffset = 0;
		for (var i = 0; i < array_length(_info); ++i) {
			draw_sprite_ext(_info[i][0], 0, GW/1.49, GH/1.37 + _yoffset, 1.5, 1.5, 0, c_white, 1);
			draw_set_alpha(0.25);
			draw_rectangle_color(GW/1.46, GH/1.39 + _yoffset, GW/1.35, GH/1.34 + _yoffset, c_black, c_black, c_black, c_black, false);
			draw_set_alpha(1);
			scribble(string($"{_info[i][1]}{_info[i][2]}")).scale(1.5).draw(GW/1.49 + 25, GH/1.39 + _yoffset);
			_yoffset += 35;
		}
	}
	#region Special Window
	select_screen_window(GW/1.12, GH/1.31, GW/1.02, GH/1.07, "Special");
	var _speX = GW/1.09;
	var _speY = GH/1.21;
	var _speSpr = _isUnlocked ? SPECIAL_LIST[CHARACTERS[selectedCharacter][?"special"]].thumb : sLockIcon;
	var _speSprW = sprite_get_width(_speSpr);
	var _speSprH = sprite_get_height(_speSpr);
	var _specialsUnlocked = global.shopUpgrades[$ "SpecialAtk"][$ "level"] == 1;
	draw_sprite_ext(_specialsUnlocked ? _speSpr : sLockIcon, 0, _speX, _speY, 3, 3, 0, c_white, 1);
	#endregion
	#region Atk Window
	select_screen_window(GW/1.26, GH/1.31, GW/1.13, GH/1.07, "Attack");
	var _atkSpr = _isUnlocked ? CHARACTERS[selectedCharacter][?"weapon"][1].thumb : sCharacterLockedIcon;
	var _atkX = GW/1.19;
	var _atkY = GH/1.14;
	var _atkSprW = sprite_get_width(_atkSpr);
	var _atkSprH = sprite_get_height(_atkSpr);
	draw_sprite_ext(_atkSpr, 0, _atkX, _atkY, 3, 3, 0, c_white, 1);
	#endregion
	#region Skills Window
	select_screen_window(GW/1.26, GH/1.68, GW/1.02, GH/1.33, "Skills");
	_offset = 0;
	for (var i = 0; i < 3; ++i) {
		var _xx = GW/1.20 + _offset;
		var _yy = GH/1.43;
		var _perk = global.characterPerks[selectedCharacter][i]
		var _spr = _isUnlocked ? _perk.thumb : sCharacterLockedIcon;
		var _sprW = sprite_get_width(_spr) * 3 / 2;
		var _sprH = sprite_get_height(_spr) * 3 / 2;
		draw_sprite_ext(_spr, 0, _xx, _yy, 3, 3, 0, c_white, 1);
		_offset += 75;
	}
	_offset = 0;
	for (var i = 0; i < 3; ++i) {
		var _xx = GW/1.20 + _offset;
		var _yy = GH/1.43;
		var _perk = global.characterPerks[selectedCharacter][i]
		var _spr = _perk.thumb;
		var _sprW = sprite_get_width(_spr) * 3 / 2;
		var _sprH = sprite_get_height(_spr) * 3 / 2;
		if (_isUnlocked and point_in_rectangle(TouchX1, TouchY1, _xx - _sprW, _yy - _sprH, _xx + _sprW, _yy + _sprH)) {
			select_screen_window(GW/1.43, GH/1.80, GW/1.02-6, GH/1.08, "Skill", 0.75);
			draw_sprite_ext(_spr, 0, GW/1.36, GH/1.51, 3, 3, 0, c_white, 1);
			scribble(lexicon_text("Perks." + _perk.name + ".name")).scale(2.5).draw(GW/1.29, GH/1.59);
			//draw_text_transformed(GW/1.29, GH/1.59, lexicon_text("Perks." + _perk.name + ".name"), 2.5, 2.5, 0);
			scribble(lexicon_text("Perks." + _perk.name + ".desc")).scale(2).wrap(190 * global.guiScale).draw(GW/1.40, GH/1.41);
		}
		_offset += 75;
	}
	#endregion
	#region Open Window when mouse over
	if (_isUnlocked and point_in_rectangle(TouchX1, TouchY1, _speX, _speY, _speX + (_speSprW*3), _speY + (_speSprH*3)) and global.shopUpgrades[$ "SpecialAtk"][$ "level"] == 1) {
		select_screen_window(GW/1.43, GH/1.80, GW/1.02-6, GH/1.08, "Special", 0.75);
		draw_sprite_ext(_speSpr, 0, GW/1.36 - _speSprW, GH/1.51 - _speSprH, 3, 3, 0, c_white, 1);
		scribble(lexicon_text("Specials." + SPECIAL_LIST[CHARACTERS[selectedCharacter][?"special"]].name + ".name")).scale(2.5).draw(GW/1.29, GH/1.59);
		//draw_text_transformed(GW/1.29, GH/1.59, lexicon_text("Specials." + SPECIAL_LIST[CHARACTERS[selectedCharacter][?"special"]].name + ".name"), 2.5, 2.5, 0);
		scribble(lexicon_text("Specials." + SPECIAL_LIST[CHARACTERS[selectedCharacter][?"special"]].name + ".desc")).scale(2).wrap(190 * global.guiScale).draw(GW/1.40, GH/1.41);
	}
	if (_isUnlocked and point_in_rectangle(TouchX1, TouchY1, _atkX - (_atkSprW*3/2), _atkY - (_atkSprH*3/2), _atkX + (_atkSprW*3/2), _atkY + (_atkSprH*3/2))) {
		select_screen_window(GW/1.43, GH/1.80, GW/1.02-6, GH/1.08, "Attack", 0.75);
		draw_sprite_ext(_atkSpr, 0, GW/1.36, GH/1.51, 3, 3, 0, c_white, 1);
		scribble(lexicon_text("Weapons." + CHARACTERS[selectedCharacter][?"weapon"][1].name + ".name")).scale(2.5).draw(GW/1.29, GH/1.59);
		//draw_text_transformed(GW/1.29, GH/1.59, lexicon_text("Weapons." + CHARACTERS[selectedCharacter][?"weapon"][1].name + ".name"), 2.5, 2.5, 0);
		scribble(lexicon_text("Weapons." + CHARACTERS[selectedCharacter][?"weapon"][1].name + ".desc")).scale(2).wrap(190 * global.guiScale).draw(GW/1.40, GH/1.41);
	}
	#endregion
}
#endregion	
#region SideBar
	
var _surf = surface_create(sidebar[1], GH);
surface_set_target(_surf);
var _yoff = 0;
for (var i = 0; i < array_length(agencies); ++i) {
	var _color = selectedAgency == agencies[i][0] ? #add8e6 : c_white;
	scribble($"[{_color}]{agencies[i][0]}").scale(3).draw(75, 15 + _yoff);
	//draw_text_transformed_color(75, 15 + _yoff, agencies[i][0], 3, 3, 0, _color, _color, _color, _color, 1);
	draw_sprite_ext(agencies[i][1], 0, 32, 32 + _yoff + 4, .35, .35, 0, _color, 1);
	if (selectedAgency == agencies[i][0]) {
		draw_rectangle_color(0, sidebar[2] - 30, 3, sidebar[2] + 30, #add8e6, #add8e6, #add8e6, #add8e6, false);
	}
	//draw_text(TouchX1, TouchY1 - 30, $"{sidebar[2]}   /   {sidebar[3]}");
	var _w = (sprite_get_width(agencies[i][1]) * 0.35) / 2;
	var _h = (sprite_get_height(agencies[i][1]) * 0.35) / 2 + 5;
	DEBUG
		draw_rectangle(32 - _w, 32 + _yoff - _h, 32 + _w + (string_width(agencies[i][0]) * 3) + 25, 32 + _yoff + _h, true);
	ENDDEBUG
	if (sidebarOpen and mouse_click and point_in_rectangle(MX, MY, 32 - _w, 32 + _yoff - _h, 32 + _w + (string_width(agencies[i][0]) * 3) + 25, 32 + _yoff + _h)) {
		selectAgency(i);
	}
	_yoff += 60;
}
surface_reset_target();
draw_set_alpha(0.75);
draw_rectangle_color(0,0, 64, GH, c_black, c_black, c_black, c_black, false);
draw_rectangle_color(64,0, sidebar[0], GH, c_black, c_black, c_black, c_black, false);
draw_set_alpha(1);
draw_surface_part(_surf, 0, 0, sidebar[0], GH, 0, 0);
surface_free(_surf);
//draw_circle(MX, MY, 32, false);
if (point_in_rectangle(TouchX1, TouchY1, 0, 0, 64 + (sidebar[0] > 64 ? sidebar[0] - 64 : sidebar[0]), GH) or sidebarOpenByButton) {
	sidebarOpen = true;
}
else {
	sidebarOpen = false;
}
#endregion
#region Outfit
if (selectingOutfit) {
	draw_text(GW/2, GH/2, "Press Z");
}
//    _x = GW/3.27;
//	_y = 0;
//	_xx = GW/1.43;
//	_yy = GH;
//	draw_set_color(c_black);
//	draw_set_alpha(.25);
//	draw_rectangle(_x, _y, _xx, _yy, false);
//	draw_set_color(c_white);
//	draw_set_alpha(1);
//	str="Outfits";
//	_x = GW/2;
//	_y = GH/2;
//	draw_set_halign(fa_center);
//	draw_set_valign(fa_top);
//	draw_sprite_ext(sCharacterselected, 0, _x, _y, 6, 6, 0, c_white, 1);
//	draw_text_transformed(_x, _y - (sprite_get_height(sCharacterselected) * 6) / 2, str, 4.50, 4.50, 0);		
//	draw_set_halign(fa_left);
//	outfitIdleAnimation[1] = sprite_get_number(CHARACTERS[selectedCharacter][?"outfits"][selectedOutfit][$ "sprite"]);
//	outfitIdleSpeed = sprite_get_speed(CHARACTERS[selectedCharacter][?"outfits"][selectedOutfit][$ "sprite"]);
//	if (outfitIdleAnimation[0] < outfitIdleAnimation[1]) {
//		outfitIdleAnimation[0] += outfitIdleSpeed / game_get_speed(gamespeed_fps) * Delta;
//	}
//	else{ outfitIdleAnimation[0] = 0; }
//	var _spr = CHARACTERS[selectedCharacter][?"outfits"][selectedOutfit][$ "sprite"];
//	var _isUnlocked = CHARACTERS[selectedCharacter][?"outfits"][selectedOutfit][$ "unlocked"] ? c_white : c_black;
//	draw_sprite_ext(_spr, outfitIdleAnimation[0], _x, _y + sprite_get_height(_spr) * 3, 6, 6, 0, _isUnlocked, 1);
//}
#endregion
var _x;
var _y;
#region Stage
if (characterSelected and outfitSelected) {
	_x = round(GW/3.27);
	_y = 0;
	draw_set_color(c_white);
	draw_set_alpha(1);
	draw_set_halign(fa_center);
	draw_text_transformed(GW/2, GH/22.50, "CHOOSE MODE", 4.50, 4.50, 0);
	draw_set_halign(fa_left);
	_x = GW/2;
	_y = round(GH/3.14);
	if (!stageSelected) {
		offset = 0;
		draw_set_halign(fa_center);
		for (var i = 0; i < array_length(stageModes); ++i) {
			draw_sprite_ext(sUpgradeBackground, 0, _x, _y + offset, 1.495, 1.35, 0, c_black, .75);
			draw_sprite_ext(sUpgradeBackground, 2, _x, _y - 19 + offset, 1.47, 1, 0, c_white, .75);
			draw_text_transformed(_x, _y - 67 + offset, stageModes[i][$ "name"], 2.50, 2.50, 0);
			draw_text_ext_transformed(_x, _y - 35 + offset, stageModes[i][$ "desc"], 13, 180, 2.5, 2.5, 0);
			var _sprW = sprite_get_width(sUpgradeBackgroundWH);
			var _sprH = sprite_get_height(sUpgradeBackgroundWH);
			DEBUG
				draw_rectangle(_x - _sprW, _y + offset - _sprH, _x + _sprW, _y + offset + _sprH, true);
			ENDDEBUG
			if (point_in_rectangle(oGui.x, oGui.y, _x - _sprW, _y + offset - _sprH, _x + _sprW, _y + offset + _sprH)) {
				selected = i;
				if (mouse_click) {
					menuClick = true;
				}
			}
			if (i == selected) {
				draw_sprite_ext(sUpgradeBackground, 1, _x, _y + offset, 1.49, 1.34, 0, c_white, 1);
			}
		offset += 160;
		}
	}
	if (stageSelected) {
		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);
		draw_text_transformed(GW/2, GH/3.61, string_upper(stages[0].name), 4, 4, 0);
		draw_sprite_ext(stages[0].port, 0, GW/2, GH/2, 2.30, 2.30, 0 ,c_white, 1);
		draw_sprite_ext(sHudButton, 1, GW/2, GH/1.40, 1, 2, 0, c_white, 1);
		draw_set_color(c_black);
		draw_text_transformed(GW/2, GH/1.40, "GO!", 2, 2, 0);
		draw_set_color(c_white);
	}
	draw_set_valign(fa_top);
	draw_set_halign(fa_left);
}
#endregion