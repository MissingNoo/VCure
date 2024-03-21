// Feather disable GM1041
#region Start variables
var str = "";
var _x = 0;
var _y = 0;
draw_set_alpha(1);
draw_set_color(c_white);
var header;
var digit;
#endregion
#region black screen below gui
if (GoldenANVIL or global.upgrade == 1 or PrizeBox or global.gamePaused and room != rInicio and HP > 0) {
	draw_set_alpha(.75);
	draw_rectangle_color(0, 0, display_get_gui_width(), display_get_gui_height(), c_black, c_black, c_black, c_black, false); // Darken the screen
	draw_set_alpha(1);
}
#endregion
#region Menu room
draw_set_font(global.newFont[1]);
if (room == rInicio) {
	#region Menu
	if (!global.gamePaused) {
		//draw_sprite_ext(sMenuTitle, 0, GW/3.77, GH/8.53, 0.7, 0.7, 0, c_white, 1);
		var _talents = [
			[sIoriArt, #e7eeea, 8.99, 1.88],
			[sUrukaArt, #455b82, 6.13, 1.71],
			[sTenmaArt, #e3dee4, 4.74, 1.54],
			[sMichiruArt, #703e6e, 2.38, 1.88],
			[sNasaArt, #fadf9e, 2.80, 1.91],
			[sPippaArt, #f7bcb3, 3.18, 1.69],
			[sLiaArt, #fce1ae, 3.96, 1.88]			
		]
		for (var i = 0; i < array_length(_talents); ++i) {
		    gpu_set_fog(true, _talents[i][1],0,0);
			var _sine = i % 2 ? sine_wave(current_time  / 1000, 10, 10, GH/_talents[i][3]) : cose_wave(current_time  / 1000, 10, 10, GH/_talents[i][3]);
			draw_sprite_ext(_talents[i][0], 0, GW/_talents[i][2], _sine, 0.3, 0.3, 0, c_white, 1);
		}
		gpu_set_fog(false,c_white,0,0);
		draw_text_transformed(20,GH-50,"version ? by Airgeadlamh", 1, 1, 0);
		var _menuyoffset = 0;
		draw_set_valign(fa_center);
		draw_set_halign(fa_middle);
		var _w = sprite_get_width(sHudButton) * 2 / 2;
		var _h = sprite_get_height(sHudButton) * 2 / 2;
		for (var i = 0; i < array_length(menuOptions); i++) {
			var _spr = selected == i ? 1 : 0;
			var _color = selected == i ? c_black : c_white;
			var _xx = GW - 305;
			var _yy = GH/4 + _menuyoffset + 3;
			draw_sprite_ext(sHudButton, _spr, _xx, _yy, selected == i ? 2 : 1.75, 2, 0, c_white, 1);
			draw_text_transformed_color(_xx, _yy + 5, menuOptions[i], 2, 2, 0, _color, _color, _color, _color, 1);
			if (point_in_rectangle(MX, MY, _xx - _w, _yy - _h, _xx + _w, _yy + _h) and selected == i and mouse_click) { menuClick = true; }
			if (point_in_rectangle(MX, MY, _xx - _w, _yy - _h, _xx + _w, _yy + _h)) { selected = i; }
			_menuyoffset += 93;
		}
		draw_set_valign(fa_top);
		draw_set_halign(fa_left);
	}
	#endregion
}
draw_set_font(global.newFont[2]);
#endregion
#region Character Select Room
var offset = 0;
if (room == rCharacterSelect) {
	NAME=CHARACTERS[selectedCharacter][?"name"];
	var _isUnlocked = CharacterData[CHARACTERS[selectedCharacter][?"id"]].unlocked;
	#region CharacterList
	if (!characterSelected) {
		draw_set_valign(fa_middle);
		draw_set_halign(fa_center);
		draw_text_transformed(GW/4, GH/8, "Choose your vtuber", 4.30, 4.30, 0);
		draw_set_valign(fa_top);
		draw_set_halign(fa_left);
		draw_set_color(c_white);
		var _offset = 0;
		var _yoffset = 0;
		_x = GW/10;
		_y = GH/4;
		draw_sprite_ext(sWhiteBack, 0, GW/2.30, GH/6, .65, .48, 0, c_white, 1);
		if (_isUnlocked) {
		    draw_sprite_ext(CHARACTERS[selectedCharacter][?"bigArt"], 0, GW/1.86, GH/2.11, .5, .5, 0, c_white, 1);
		}
		for (var i=1; i < Characters.Lenght; i++) {
			if (CHARACTERS[i][?"agency"] != selectedAgency and selectedAgency != "All") {
			    continue;
			}
			var _pW = sprite_get_width(CHARACTERS[i][?"portrait"]);
			var _pH = sprite_get_height(CHARACTERS[i][?"portrait"]);
			if (!sidebarOpen and point_in_rectangle(x, y, _x - _pW + _offset, _y - _pH + _yoffset, _x + _pW + _offset, _y + _yoffset + _pH) and selectedCharacter == i and mouse_click) { menuClick = true; }
			if (!sidebarOpen and point_in_rectangle(x, y, _x - _pW + _offset, _y - _pH + _yoffset, _x + _pW + _offset, _y + _yoffset + _pH)) { selectedCharacter = i; }
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
			_offset += 95;
			if (i == 5) {
			    _yoffset += 85;
				_offset = 0;
			}
		}
		if (_isUnlocked) {
		    draw_text_ext_transformed(GW/1.48, GH/7.31, string_upper(CHARACTERS[selectedCharacter][?"name"]), string_height("W"), 50, 7, 7, 0);		
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
				draw_text_transformed(GW/1.49 + 25, GH/1.39 + _yoffset, string($"{_info[i][1]}{_info[i][2]}"), 1.5, 1.5, 0);
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
				draw_text_transformed(GW/1.29, GH/1.59, lexicon_text("Perks." + _perk.name + ".name"), 2.5, 2.5, 0);
				drawDesc(GW/1.40, GH/1.41, lexicon_text("Perks." + _perk.name + ".desc"), GW/3.90, 2);
			}
			_offset += 75;
		}
		#endregion
		#region Open Window when mouse over
		if (_isUnlocked and point_in_rectangle(TouchX1, TouchY1, _speX, _speY, _speX + (_speSprW*3), _speY + (_speSprH*3)) and global.shopUpgrades[$ "SpecialAtk"][$ "level"] == 1) {
		    select_screen_window(GW/1.43, GH/1.80, GW/1.02-6, GH/1.08, "Special", 0.75);
			draw_sprite_ext(_speSpr, 0, GW/1.36 - _speSprW, GH/1.51 - _speSprH, 3, 3, 0, c_white, 1);
			draw_text_transformed(GW/1.29, GH/1.59, lexicon_text("Specials." + SPECIAL_LIST[CHARACTERS[selectedCharacter][?"special"]].name + ".name"), 2.5, 2.5, 0);
			drawDesc(GW/1.40, GH/1.41, lexicon_text("Specials." + SPECIAL_LIST[CHARACTERS[selectedCharacter][?"special"]].name + ".desc"), GW/3.90, 2);
		}
		if (_isUnlocked and point_in_rectangle(TouchX1, TouchY1, _atkX - (_atkSprW*3/2), _atkY - (_atkSprH*3/2), _atkX + (_atkSprW*3/2), _atkY + (_atkSprH*3/2))) {
		    select_screen_window(GW/1.43, GH/1.80, GW/1.02-6, GH/1.08, "Attack", 0.75);
			draw_sprite_ext(_atkSpr, 0, GW/1.36, GH/1.51, 3, 3, 0, c_white, 1);
			draw_text_transformed(GW/1.29, GH/1.59, lexicon_text("Weapons." + CHARACTERS[selectedCharacter][?"weapon"][1].name + ".name"), 2.5, 2.5, 0);
			drawDesc(GW/1.40, GH/1.41, lexicon_text("Weapons." + CHARACTERS[selectedCharacter][?"weapon"][1].name + ".desc"), GW/3.90, 2);
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
	    draw_text_transformed_color(75, 15 + _yoff, agencies[i][0], 3, 3, 0, _color, _color, _color, _color, 1);
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
}
#endregion
#region Inside Stage
if (instance_exists(oPlayer)) {	
	draw_sprite_ext(sPhaseCoin, 0, GW/1.23, GH/15.06, 1, 1, 0, c_white, 1);
	draw_text_transformed(GW/1.18, GH/16.35, string(global.newcoins), 2, 2, 0);
	draw_sprite_stretched(sHuddefeatedEnemies, 0, GW/1.25, GH/9, 55, 55);
	draw_text_transformed(GW/1.18, GH/7.60, string($"{global.defeatedEnemies} {global.player[?"id"] == Characters.Lia ? string(": " + string(oPlayer.menheraKills)) : string("")}"), 2, 2, 0);
	#region Character Portrait
	_x = GW/25.10
	_y = GH/10.59;
	var _portraithalf = sprite_get_height(sUiPortraitFrame);
	draw_set_alpha(global.debug ? .5 : 1);
	if (global.showhpui) {
		draw_healthbar(_x + 87, _y - 38, _x + 340, _y - 27, ((HP / MAXHP) * 100), c_red, #8cffbd, #8cffbd, 0, 1, 0);
		draw_healthbar(_x + 87, _y - 40, _x + 340, _y - 27, ((HP / MAXHP) * 100), c_red, #069617, #069617, 0, 1, 0);
		draw_healthbar(_x + 87, _y - 38, _x + 340, _y - 29, ((HP / MAXHP) * 100), c_red, c_lime, c_lime, 0, 1, 0);		
		draw_rectangle_color(_x, _y - _portraithalf, _x + 85, _y - _portraithalf + 15, c_white, c_white, c_white, c_white, false);
		draw_text_transformed_color(_x + 57, _y - _portraithalf - 3, "HP", 2, 1.5, 0, c_black, c_black, c_black, c_black, 1);		
	}		
	draw_sprite_ext(sUiPortraitBg,0, _x, _y, 2,2,0,c_white,1);
	draw_sprite_ext(global.player[?"portrait"],0,_x, _y ,2,2,0,c_white,1);
	draw_sprite_ext(sUiPortraitFrame,0,_x, _y,2,2,0,c_white,1);
	#endregion
	#region Special
	if (global.shopUpgrades[$ "SpecialAtk"][$ "level"] == 1) {
		var _sx = GW/273;
		var _sy = GH/6;
		var casesize = 27;
		var special = SPECIAL_LIST[global.player[?"special"]];
		draw_sprite_ext(sHudSpecial,0, _sx + casesize, _sy, 1, 2, 0, c_white, 1);
		var chargeColor = c_white;
		if (oPlayer.skilltimer > oPlayer.specialcooldown) { chargeColor = c_red; }
		draw_sprite_part_ext(sHudSpecial,2, 0, 0, ((oPlayer.skilltimer / oPlayer.specialcooldown) * sprite_get_width(sHudSpecial)), sprite_get_height(sHudSpecial), _sx + casesize, _sy, 1, 2, chargeColor, 1);
		draw_sprite_ext(sHudSpecial,1, _sx + casesize, _sy, 1, 2, 0, c_white, 1);
		if (oPlayer.skilltimer > oPlayer.specialcooldown) { draw_text(_sx+oGui.a, _sy + casesize, "READY"); }
		//draw_sprite_ext(sHudSpecialCase, 0, _sx, _sy, 2.1, 2.1, 0, c_white, 1);
		draw_sprite_ext(special[$ "thumb"], 0, _sx + 4, _sy, 2, 2, 0, c_white, .5);
		DEBUG 
			draw_text(_sx + 90, _sy + casesize / 2,string(oPlayer.skilltimer) + "/" + string(oPlayer.specialcooldown)); 
		ENDDEBUG
	}
	#endregion
	#region Upgrades
	if (surface_exists(itemsSurface)) {
		draw_set_alpha(1);
	    draw_surface(itemsSurface, 0, 0);
	}
	#endregion
	#region XP
	if (global.xp > 0) {
		draw_rectangle_color(5, 5, 5 + ((global.xp / oPlayer.neededxp) * GW - 5), 30, c_blue, c_blue, c_blue, c_blue, false);
	}
	draw_rectangle(5, 5, GW - 5, 30, true);
	#endregion
	#region LevelUP
	if (global.upgrade) {
		#region UpgradeList
		offset = 0;
		var _xx = round(GW/1.55);
		var _yy = round(GH/4.16);
		var _xscale = 2.06;
		var _yscale = 1.32;
		for (var i = 0; i < array_length(global.upgradeOptions); i++) {			
			draw_sprite_ext(sUpgradeBackground, 0, _xx, _yy + offset, _xscale, _yscale, 0, c_black, .75);
			draw_rectangle(_xx - 365, _yy + offset - 35, _xx + 365, _yy + offset - 34, false);
			if (mouse_on_button(_xx, _yy + offset, sUpgradeBackground, i, _xscale / 1.32, _yscale / 2.2, "selected", i)) {
			    menuClick = true;
			}
			if (i == selected) {
				draw_sprite_ext(sUpgradeBackground, 1, _xx, _yy + offset, _xscale, _yscale, 0, c_white, 1);
				draw_sprite_ext(sHoloCursor, holoarrowspr, _xx - 415, _yy + 2 + offset, 2, 2, 0, c_white, 1);
			}
			draw_set_halign(fa_left);
			var uptype = "";
			var style = "";
			var foundup = false;
			var foundlv = 0;
			switch (global.upgradeOptions[i][$ "style"]) { // type of upgrade
				case ItemTypes.Weapon:{
					for (var j = 0; j < array_length(UPGRADES); ++j) {
						if (UPGRADES[j][$ "name"] == global.upgradeOptions[i][$ "name"]) {
							foundup = true;
							foundlv = UPGRADES[j][$ "level"] + 1;
						}
					}
					style = " >> Weapon";
					uptype = "Weapons.";
					var _enchantment = WEAPONS_LIST[global.upgradeOptions[i].id][1].enchantment;
					var _isEnchanted = _enchantment != Enchantments.None;
					if (_isEnchanted) {						
						draw_set_color(#add8e6);
						draw_set_halign(fa_right);
						draw_text_transformed(_xx + 365, _yy + 35 + offset, "> " + lexicon_text($"Enchantments.{_enchantment}.desc"), 2, 2, 0);
						draw_set_halign(fa_left);
					}
					break;}
				case ItemTypes.Item:{
					for (var j = 0; j < array_length(playerItems); ++j) {
						if (playerItems[j][$ "id"] == global.upgradeOptions[i][$ "id"]) {
							foundup = true;
							foundlv = playerItems[j][$ "level"] + 1;
						}
					}
					style = " >> Item";
					uptype = "Items.";
					break;}
				case ItemTypes.Perk:{
					for (var j = 0; j < array_length(PLAYER_PERKS); ++j) {
						if (PLAYER_PERKS[j][$ "id"] == global.upgradeOptions[i][$ "id"]) {
							foundup = true;
							foundlv = PLAYER_PERKS[j][$ "level"] + 1;
						}
					}
					style = " >> Skill";
					uptype = "Perks.";
					break;}
			}
			var _name = lexicon_text(uptype + string(global.upgradeOptions[i][$ "name"]) + ".name");
			draw_text_transformed(_xx - 348, _yy - 57 + offset, _name, 2, 2, 0);
			draw_set_color(c_white);
			draw_set_halign(fa_right);
			draw_text_transformed(_xx + 340, _yy - 57 + offset, string(style), 2, 2, 0);
			draw_set_halign(fa_left);
			draw_sprite_ext(global.upgradeOptions[i][$ "thumb"],0,_xx - 322, _yy + 8 + offset,2, 2,0,c_white,1);
			draw_sprite_ext(sItemType, global.upgradeOptions[i][$ "style"], _xx - 322, _yy + 8 + offset,2, 2,0,c_white,1);
			var maxx = 600;
			var desc = "";
			if (foundup) {
				var idd = global.upgradeOptions[i][$ "id"];
				desc = lexicon_text(uptype + global.upgradeOptions[i][$ "name"] + "." + string(foundlv));
			}
			else{
				desc = lexicon_text(uptype + global.upgradeOptions[i][$ "name"] + ".1");
			}
			drawDesc(_xx- 230, _yy - 28 + offset, desc , maxx, 2);
			offset += 138;
			draw_set_color(c_white);
		}//feather disable once GM2017
		if (global.shopUpgrades.Reroll.level > 0) {
			var _rerollX = GW/2;
			var _rerollY = GH/1.05;
			var _sprW = sprite_get_width(sHudButton);
			var _sprH = sprite_get_height(sHudButton);
			if (global.rerolls > 0 and point_in_rectangle(x, y, _rerollX - _sprW, _rerollY - _sprH, _rerollX + _sprW, _rerollY + _sprH)and selected == 4 and mouse_click) { menuClick = true; }
			if (global.rerolls > 0 and point_in_rectangle(x, y, _rerollX - _sprW, _rerollY - _sprH, _rerollX + _sprW, _rerollY + _sprH)) {
				selected = 4;
			}
			draw_sprite_ext(sHudButton, selected == 4 ? 1 : 0, _rerollX, _rerollY, 1.15, 2, 0, c_white, 1);			
			var color = selected == 4 ? c_black : c_white;
			draw_set_halign(fa_center);
			draw_set_valign(fa_middle);
			draw_text_transformed_color(_rerollX, _rerollY, $"Reroll ({global.rerolls})",2,2,0,color, color, color, color, 1);
			draw_set_halign(fa_left);
			draw_set_valign(fa_top);
		}
		#endregion
		drawStats();
	}
	#endregion
	#region Anvil
	if (ANVIL) {
		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);
		_x = GW/1.56;
		_y = GH/5.30;
		draw_text_transformed_color(_x+1, _y+1, "UPGRADE!", 5, 5, 0, c_black, c_black, c_black, c_black, 1);
		draw_text_transformed_color(_x-1, _y-1, "UPGRADE!", 5, 5, 0, c_black, c_black, c_black, c_black, 1);
		draw_text_transformed(_x, _y, "UPGRADE!", 5, 5, 0);
		draw_set_valign(fa_top);
		draw_set_halign(fa_left);			
		#region Weapons
		var xoffset = 0;
		var anvilIsSelected = 0;
		for (var i = 0; i < array_length(UPGRADES); ++i){
			if (anvilSelectedCategory == 0 and i == anvilSelected){
				anvilIsSelected = 1;
			}else{
				anvilIsSelected = 0;
			}
			draw_sprite_ext(sItemSquare, anvilIsSelected, GW/2.30 + xoffset, GH/3, 2, 2, 0, c_white, 1);
			var _sprHalf = (sprite_get_width(sItemSquare) * 2 ) / 2;
			if (!anvilconfirm and buttonClick([GW/2.30 - _sprHalf + xoffset, GH/3 - _sprHalf, GW/2.30 + _sprHalf + xoffset, GH/3 + _sprHalf], true)) {
			    anvilSelected = i;
				anvilSelectedCategory = 0;
			}
			draw_sprite_ext(UPGRADES[i][$ "thumb"], 0, GW/2.30 + xoffset, GH/3, 2, 2, 0, c_white, 1);
			xoffset += GW/12;
		}
		#endregion
		#region Items
		xoffset = 0;
		for (var i = 0; i < array_length(playerItems); ++i){
			//if (!anvilconfirm) { mouseOnButton(GW/2.30, GH/2.30, GW/12, sItemSquare, 2, 2, playerItems, "anvilSelected", "horizontal");}
			if (anvilSelectedCategory == 1 and i == anvilSelected){
				anvilIsSelected = 1;
			}else{
				anvilIsSelected = 0;
			}
			var _alpha = (playerItems[i][$ "level"] < playerItems[i][$ "maxlevel"]) ? 1 : 0.5;
			draw_sprite_ext(sItemSquare, anvilIsSelected, GW/2.30 + xoffset, GH/2.30, 2, 2, 0, c_white, 1);
			var _sprHalf = (sprite_get_width(sItemSquare) * 2 ) / 2;
			if (!anvilconfirm and buttonClick([GW/2.30 - _sprHalf + xoffset, GH/2.30 - _sprHalf, GW/2.30 + _sprHalf + xoffset, GH/2.30 + _sprHalf], true)) {
			    anvilSelected = i;
				anvilSelectedCategory = 1;
			}
			draw_sprite_ext(playerItems[i][$ "thumb"], 0, GW/2.30 + xoffset, GH/2.30, 2, 2, 0, c_white, _alpha);
			xoffset += GW/12;
		}
		#endregion
		#region Item Info
		var _xx = GW/1.55;
		var _yy = GH/1.60;
		var style;
		draw_sprite_ext(sUpgradeBackground, 0, _xx, _yy, 2.10, 1.25, 0, c_black, .75);//upgrade background
		draw_sprite_ext(sUpgradeBackground, 2, _xx, _yy, 2.10, 1.25, 0, c_white, .75);//upgrade line for the text
		draw_sprite_ext(sUpgradeBackground, 1, _xx, _yy, 2.10, 1.25, 0, c_white, 1); 
		var selectedThing, _name;
		if (anvilSelectedCategory == 0) {
			selectedThing = UPGRADES[anvilSelected];
			_name = lexicon_text("Weapons." + selectedThing[$ "name"] + ".name");
		}else{
			selectedThing = playerItems[anvilSelected];
			_name = lexicon_text("Items." + selectedThing[$ "name"] + ".name");
		}
		var level = selectedThing[$ "level"];
		var maxlevel = selectedThing[$ "maxlevel"];
		draw_set_valign(fa_top);
		draw_text_transformed(_xx - 385, _yy - 59.50 , _name, 1, 1, 0); // draw the name
		draw_set_color(c_yellow);
		if (level < maxlevel) {
			str = string_ext("LV {0} >> LV {1} ", [string(selectedThing[$ "level"]), string(selectedThing[$ "level"] + 1)]);
		}else if (anvilSelectedCategory == 0){
			if (!variable_struct_exists(UPGRADES[anvilSelected], "bonusLevel")) {
				str = "+ 1";
			}
			else{
				str = string("+ {0} >> + {1}", variable_struct_get(UPGRADES[anvilSelected], "bonusLevel"), variable_struct_get(UPGRADES[anvilSelected], "bonusLevel") + 1);
			}					
		}
		if (selectedThing != global.null and selectedThing != global.nullitem and anvilconfirm) {
			draw_text_transformed(_xx - 385 + (string_width(_name) + 20), _yy - 59.50 , str, 1, 1, 0); // draw the name
		}
		draw_set_color(c_white);
		switch (selectedThing[$ "style"]) { // type of upgrade
			case ItemTypes.Weapon:{
				style = " >> Weapon";
				break;}
			case ItemTypes.Item:{
				style = " >> Item";
				break;}
			case ItemTypes.Perk:{
				style = " >> Skill";
				break;}
		}
		draw_set_halign(fa_right);
		draw_text_transformed(_xx + 370, _yy - 59.50, string(style), 1, 1, 0);  // draw type of upgrade
		draw_set_halign(fa_left);
		draw_sprite_ext(selectedThing[$ "thumb"],0, _xx - 350, _yy, 2, 2,0,c_white,1); // item thumb
		draw_sprite_ext(sItemType, selectedThing[$ "style"], _xx - 350, _yy, 2, 2,0,c_white,1); // item thumb type
		if (!anvilconfirm) {
			if (level > maxlevel) {	level -= 1;}
			if (anvilSelectedCategory == 0 and selectedThing != global.null and selectedThing != global.nullitem) {
				drawDesc(_xx - 290,_yy - 35, lexicon_text("Weapons." + selectedThing[$ "name"] + "." + string(level)), GW/2, 2);
			}
			if (anvilSelectedCategory == 1 and selectedThing != global.null and selectedThing != global.nullitem) {
				drawDesc(_xx - 290,_yy - 35, lexicon_text("Items." + selectedThing[$ "name"] + "." + string(level)), GW/2, 2);
			}
		}
		else {
			draw_set_valign(fa_middle);
			if (!upgradeconfirm) {
				var _tx = GW/1.53;
				var _ty = GH/1.31;
				draw_sprite_ext(sHudButton, 1, _tx, _ty, 1.5, 1.5, 0, c_white, 1);
				draw_set_halign(fa_center);
				//draw_set_valign(fa_center);
				draw_text_transformed_color(_tx, _ty, "Upgrade", 2,2,0,c_black,c_black,c_black,c_black, 1);
				draw_set_valign(fa_top);
				draw_set_halign(fa_left);
			}
			else{
				var _tx = GW/1.53;
				var _ty = GH/1.29;
				draw_set_halign(fa_center);
				//draw_set_valign(fa_center);
				var _chance = 100;
				var _confirmstring = "UPGRADE";
				if (variable_struct_exists(selectedThing, "bonusLevel")) {
					var _upgradeCoinValue = 0;
					for (var i = 0; i < selectedThing[$ "bonusLevel"]; ++i) {
						_upgradeCoinValue += 50;
						_chance -= 10;
					}
					upgradeCoinValue = _upgradeCoinValue;
					_confirmstring = string("Cost: {0} to UPGRADE", upgradeCoinValue);
				}
				if (_chance < 10) {_chance=10;}
				draw_set_valign(fa_middle);
				draw_text_transformed_color(_tx, _ty - 40, string("Sucess Rate: {0}%", _chance), 2,2,0,c_white,c_white,c_white,c_white, 1);				
				draw_sprite_ext(sHudButton, 1, _tx, _ty, 2, 1.5, 0, c_white, 1);
				draw_text_transformed_color(_tx, _ty, _confirmstring, 2,2,0,c_black,c_black,c_black,c_black, 1);
				draw_set_valign(fa_top);
				draw_set_halign(fa_left);
			}
			level++;
			if (level > maxlevel) {	level -= 1;}
			if (level != maxlevel) {
				if (anvilSelectedCategory == 0 and selectedThing != global.null and selectedThing != global.nullitem) {
					drawDesc(_xx - 290,_yy - 35, lexicon_text("Weapons." + selectedThing[$ "name"] + "." + string(level)), GW/2, 2);
				}	
			}
			else{
				if (anvilSelectedCategory == 0 and selectedThing != global.null and selectedThing != global.nullitem) {
					drawDesc(_xx - 290,_yy - 35, lexicon_text("Anvil.Enhance." + string(oPlayer.blacksmithLevel)), GW/2, 2);
				}	
			}
			if (anvilSelectedCategory == 1 and selectedThing != global.null and selectedThing != global.nullitem) {
				drawDesc(_xx - 290,_yy - 35, lexicon_text("Items." + selectedThing[$ "name"] + "." + string(level)), GW/2, 2);
			}
		}
		#endregion
		draw_set_valign(fa_top);
		draw_set_halign(fa_left);
		drawStats();
		draw_set_valign(fa_top);
		draw_set_halign(fa_left);
	}
	#endregion
	#region Golden Anvil
	if (GoldenANVIL) {
		_x = GW/2;
		_y = GH/2;
		var _down = 150;
		var _distance = 90;
		var _offset = 0;
		var _sprHalf = (sprite_get_width(sItemSquare) * 2 ) / 2;
		for (var i = 1; i < array_length(UPGRADES); ++i) {
			var _isSelected = (anvilSelected == i) ? true : false;
		    draw_sprite_ext(sItemSquare, _isSelected, _x + _offset, _y, 2, 2, 0, c_white, 1);
			var _alpha = (gAnvilWeapon1 == UPGRADES[i] or gAnvilWeapon2 == UPGRADES[i]) ? 0.5 : 1;
		    draw_sprite_ext(UPGRADES[i][$ "thumb"], 0, _x + _offset, _y, 2, 2, 0, c_white, _alpha);
			if (buttonClick([_x - _sprHalf + _offset, _y - _sprHalf, _x + _sprHalf + _offset, _y + _sprHalf], true)) {
				anvilSelected = i;
				if (gAnvilWeapon1 == global.null and gAnvilWeapon2 != UPGRADES[anvilSelected]) {
				    gAnvilWeapon1 = UPGRADES[anvilSelected];
				    gAnvilWeapon1Position = anvilSelected;
					return;
				}
				if (gAnvilWeapon2 == global.null and gAnvilWeapon1 != UPGRADES[anvilSelected]) {
				    gAnvilWeapon2 = UPGRADES[anvilSelected];
					gAnvilWeapon2Position = anvilSelected;
					return;
				}
			}
			if (i == 3) {
				draw_set_hvaling(fa_center, fa_middle);
			    draw_text_transformed(_x + _offset, _y + _down, "+", 4, 4, 0);
				
				draw_sprite_ext(sItemSquare, 0, _x + _offset - _distance, _y + _down, 2, 2, 0, c_white, 1);
				draw_sprite_ext(gAnvilWeapon1[$ "thumb"], 0, _x + _offset - _distance, _y + _down, 2, 2, 0, c_white, 1);
				if (buttonClick([_x - _sprHalf + _offset - _distance, _y - _sprHalf + _down, _x + _sprHalf + _offset - _distance, _y + _sprHalf + _down], true)) {
					gAnvilWeapon1 = global.null;
				}
				
				draw_sprite_ext(sItemSquare, 0, _x + _offset + _distance, _y + _down, 2, 2, 0, c_white, 1);
				draw_sprite_ext(gAnvilWeapon2[$ "thumb"], 0, _x + _offset + _distance, _y + _down, 2, 2, 0, c_white, 1);
				if (buttonClick([_x - _sprHalf + _offset + _distance, _y - _sprHalf + _down, _x + _sprHalf + _offset + _distance, _y + _sprHalf + _down], true)) {
					gAnvilWeapon2 = global.null;
				}
				canCollab = false;
				if (is_array(gAnvilWeapon1[$ "collabWith"])) {
				    if (array_contains(gAnvilWeapon1[$ "collabWith"], gAnvilWeapon2[$ "id"])) {
					    canCollab = true;
					}
				}
				else{
					if (gAnvilWeapon1[$ "collabWith"] == gAnvilWeapon2[$ "id"]) {
					    canCollab = true;
					}
				}
				if (canCollab) {
				    draw_sprite_ext(sHudButton, 1, _x + _offset, _y + (_down + 70), 1, 1.5, 0, c_white, 1);
					draw_text_transformed_color(_x + _offset, _y + (_down + 70), "COLLAB!", 2, 2, 0, c_black, c_black, c_black, c_black, 1);
				}
				
				draw_set_reset();
			}
			_offset += 90;
		}
	}
	#endregion
	#region Prize Box
	DebugManager.debug_add_config("PrizeBox", DebugTypes.Button, undefined, undefined, function(){instance_create_depth(oPlayer.x,oPlayer.y + 20, depth, oChest);});
	if (PrizeBox) {
		#region Debug
		DebugManager.debug_add_config("Restart Box", DebugTypes.Button, undefined, undefined, function(){boxaccept = false; chestresult = false; chesttimer = 0; chestspr = 0; boxoffset = 700;});
		DebugManager.debug_add_config("Animation time", DebugTypes.UpDown, self, "chestmaxtimer");
		DebugManager.debug_add_config("Chest Size", DebugTypes.UpDown, self, "chestsize");
		DebugManager.debug_add_config("Result Size", DebugTypes.UpDown, self, "resultSize");
		DebugManager.debug_add_config("Result Y", DebugTypes.UpDown, self, "resultY");
		DebugManager.debug_add_config("Coins amount", DebugTypes.UpDown, self, "coinsAmount");
		DebugManager.debug_add_config("Item size", DebugTypes.UpDown, self, "itemsize");
		DebugManager.debug_add_config("Upwards speed", DebugTypes.UpDown, self, "upspeed");
		DebugManager.debug_add_config("Distance between items", DebugTypes.UpDown, self, "itemdistance");
		#endregion
		draw_sprite_ext(sMenu, 0, GW/2, GH/2, !multiChest ? 3 : 4, 3, 0, c_white, 1);
		if (!multiChest) {
			draw_sprite_ext(sChest, chestspr, GW/2, GH/2 + 250, chestsize, chestsize, 0, c_white, 1);
		}
		else {
			var _offsetSelected = 0 + multiChestX;
			for (var i = 0; i < 3; ++i) {
				if (currentPrize == i and boxaccept and chestresult) {
					gpu_set_fog(true, c_yellow, 0, 0);
					draw_sprite_ext(sChest, chestspr, GW/2 - _offsetSelected - 0.25, GH/2 + 250 + 3.50, chestsize + 0.05, chestsize + 0.05, 0, c_white, 1);
					gpu_set_fog(false,c_white,0,0);
				}
				draw_sprite_ext(sChest, chestspr, GW/2 - _offsetSelected, GH/2 + 250, chestsize, chestsize, 0, c_white, 1);				
				_offsetSelected -= multiChestX;
			}
		}
		if (!boxaccept) {
			part_emitter_destroy_all(coinsSystem);
		    var w = sprite_get_width(sHudButton) * 0.75;
			var h = sprite_get_height(sHudButton) * 1.50;
			_x = GW/2;
			_y = GH/2 + 275;
			var mouseIn = mouse_on_area([_x - (w/2), _y - (h/2), _x + (w/2), _y + (h/2)], false);
			draw_sprite_ext(sHudButton, mouseIn ? 1 : 0, _x, _y, 0.75, 1.50, 0, c_white, 1);
			draw_set_valign(fa_middle);
			draw_set_halign(fa_center);
			var _color = mouseIn ? c_black : c_white;
			draw_text_transformed_color(_x, _y + 5, lexicon_text("Hud.Button.Accept"), 2, 2, 0, _color, _color, _color, _color, 1);
			draw_set_halign(fa_left);
			draw_set_valign(fa_top);
			if (click_on_area([_x - (w/2), _y - (h/2), _x + (w/2), _y + (h/2)]) or zKey) {
				temp = prize_box_roll();
			    boxaccept = true;
				//feather disable GM2017
				var _pemit1, _pemit2, _pemit3;
				if (!multiChest) {
					boxcoins = irandom_range(72, 103);
					part_system_position(shineSystem, GW/2, GH/2 + resultY);
					_pemit1 = part_emitter_create(coinsSystem);
				    part_emitter_region(coinsSystem, _pemit1, -32, 32, -8, 8, ps_shape_rectangle, ps_distr_linear);
					part_emitter_stream(coinsSystem, _pemit1, _ctype1, coinsAmount);
				}
				else {
					boxcoins = irandom_range(126, 252);
				    rolledPrizes = [prize_box_roll(0), prize_box_roll(1), prize_box_roll(2)];
					currentPrize = 0;
					part_system_position(shineSystem, GW/2 - multiChestX, GH/2 + resultY);
					_pemit1 = part_emitter_create(coinsSystem);
				    part_emitter_region(coinsSystem, _pemit1, -32, 32, -8, 8, ps_shape_rectangle, ps_distr_linear);
					part_emitter_stream(coinsSystem, _pemit1, _ctype1, coinsAmount);
					_pemit2 = part_emitter_create(coinsSystem);
				    part_emitter_region(coinsSystem, _pemit2, -32 + multiChestX, 32 + multiChestX, -8, 8, ps_shape_rectangle, ps_distr_linear);
					part_emitter_stream(coinsSystem, _pemit2, _ctype1, coinsAmount);
					_pemit3 = part_emitter_create(coinsSystem);
				    part_emitter_region(coinsSystem, _pemit3, -32 - multiChestX, 32 - multiChestX, -8, 8, ps_shape_rectangle, ps_distr_linear);
					part_emitter_stream(coinsSystem, _pemit3, _ctype1, coinsAmount);
				}
			}
		}
		else {
			if (chesttimer < chestmaxtimer) {
			    chesttimer += (1/60) * Delta;
			}
			else { chestresult = true; part_emitter_destroy_all(coinsSystem); }
			if (!chestresult) {
			    boxitems(boxoffset);
				if (surface_exists(boxsurface)) {
					if (!multiChest) {
						draw_surface_part(boxsurface, 0, 0, 128, 522, GW/2 - 64, GH/2 - 306);
					}
					else {
						draw_surface_part(boxsurface, 0, 0, 128, 522, GW/2 - 64 - multiChestX, GH/2 - 306);
						draw_surface_part(boxsurface, 0, 0, 128, 522, GW/2 - 64, GH/2 - 306);
						draw_surface_part(boxsurface, 0, 0, 128, 522, GW/2 - 64 + multiChestX, GH/2 - 306);
					}
				}
			}
			else {
				part_system_drawit(shineSystem);
				if (!multiChest) {
				    var _type = temp[0] == Rewards.Weapon ? WEAPONS_LIST[temp[1]][1].thumb : ItemList[temp[1]][1].thumb;
					draw_sprite_ext(_type, 0, GW/2, GH/2 + resultY, resultSize, resultSize, 0, c_white, 1);
				}
				else {
					for (var i = 0; i < array_length(rolledPrizes); ++i) {
					    var _type = rolledPrizes[i][0] == Rewards.Weapon ? WEAPONS_LIST[rolledPrizes[i][1]][1].thumb : ItemList[rolledPrizes[i][1]][1].thumb;
						var _chestoffset = 0;
						switch (i) {
						    case 0:
						        _chestoffset = 0 - multiChestX;
						        break;
						    case 1:
						        _chestoffset = 0;
						        break;
						    case 2:
						        _chestoffset = 0 + multiChestX;
						        break;
						}
						draw_sprite_ext(_type, 0, GW/2 + _chestoffset, GH/2 + resultY, resultSize, resultSize, 0, c_white, 1);
					}
				}
				#region Accept/Refuse
				var w = sprite_get_width(sHudButton) * 0.75;
				var h = sprite_get_height(sHudButton) * 1.50;
				_x = GW/2 + chestAcceptRefuseX;
				_y = GH/2 + 275;
				var mouseIn = mouse_on_area([_x - (w/2), _y - (h/2), _x + (w/2), _y + (h/2)], false);
				draw_sprite_ext(sHudButton, mouseIn ? 1 : 0, _x, _y, 0.75, 1.50, 0, c_white, 1);
				draw_set_valign(fa_middle);
				draw_set_halign(fa_center);
				var _color = mouseIn ? c_black : c_white;
				draw_text_transformed_color(_x, _y + 5, lexicon_text("Hud.Button.Accept"), 2, 2, 0, _color, _color, _color, _color, 1);
				draw_set_halign(fa_left);
				draw_set_valign(fa_top);
				if (click_on_area([_x - (w/2), _y - (h/2), _x + (w/2), _y + (h/2)])) {
					if (!multiChest) {
						acceptPrize(temp);
						PrizeBox = false;
						pause_game();
					}
					else {
						acceptPrize(rolledPrizes[currentPrize]);
						nextPrize();
					}
				}
				//refuse
				_x = GW/2 - chestAcceptRefuseX;
				_y = GH/2 + 275;
				mouseIn = mouse_on_area([_x - (w/2), _y - (h/2), _x + (w/2), _y + (h/2)]);
				draw_sprite_ext(sHudButton, mouseIn ? 1 : 0, _x, _y, 0.75, 1.50, 0, c_white, 1);
				draw_set_valign(fa_middle);
				draw_set_halign(fa_center);
				_color = mouseIn ? c_black : c_white;
				draw_text_transformed_color(_x, _y + 5, lexicon_text("Hud.Button.Refuse"), 2, 2, 0, _color, _color, _color, _color, 1);
				draw_set_halign(fa_left);
				draw_set_valign(fa_top);
				if (click_on_area([_x - (w/2), _y - (h/2), _x + (w/2), _y + (h/2)])) {
					if (!multiChest) {
						PrizeBox = false;
						pause_game();
					}
					else {
						nextPrize();
					}
				}
				#endregion
			}
			part_system_drawit(coinsSystem);
			if (!multiChest) {
				draw_sprite_ext(sChestFront, chestspr, GW/2, GH/2 + 250, chestsize, chestsize, 0, c_white, 1);
			}
			else {
				var _offsetSelected = 0 - multiChestX;
				for (var i = 0; i < 3; ++i) {
				    draw_sprite_ext(sChestFront, chestspr, GW/2 - _offsetSelected, GH/2 + 250, chestsize, chestsize, 0, c_white, 1);
					_offsetSelected += multiChestX
				}
			}
			if (chestspr < 14) { chestspr += sprite_get_speed(sChest) / 60; }
			boxoffset -= upspeed;
			if (boxoffset <  -3000) { boxoffset = 0; }
		}
	}
	#endregion
	#region Timer
	var _seconds = round(Seconds);
	if (_seconds < 10) { _seconds = $"0{_seconds}"; }
	var _time = $"{Minutes}:{_seconds}";
	draw_text_transformed(GW/2 - (string_width(_time)/2), 35, _time, 2, 2, 0);
	#endregion
	#region Buffs //TODO: fix draw
	var _xx = 55;
	var _yy = GH - 55;
	for (var i = 0; i < array_length(Buffs); ++i) {
		if (variable_struct_exists(Buffs[i],"enabled") and Buffs[i].enabled == true) {
			draw_set_alpha(.5);
			draw_rectangle(_xx - 32, _yy - 32, _xx + 32, _yy + 32, false);
			draw_set_alpha(1);
			draw_sprite_stretched(Buffs[i].icon, 0, _xx - sprite_get_width(Buffs[i].icon), _yy - sprite_get_height(Buffs[i].icon), 35, 35);
			draw_set_color(c_blue);
			if (variable_struct_exists(Buffs[i], "cooldown") and !variable_struct_exists(Buffs[i], "permanent")) {
				draw_text(_xx, _yy+10, string(round(Buffs[i].cooldown)));
			}
			if (variable_struct_exists(Buffs[i], "count")) {
				draw_text(_xx - 25, _yy+10, string(round(Buffs[i].count)));
			}					
			draw_set_color(c_white);
			draw_set_alpha(1);
			_xx += 40;
		}
	}
	#endregion
	#region Joystick
	if (os_type == os_android and !global.gamePaused) {
		for (var i = 0; i <= 1; ++i) {
		    if (device_mouse_check_button(i, mb_left)) {
				if (holdPositions[i][0] == 0) {
				    holdPositions[i][0] = device_mouse_x_to_gui(i);
					holdPositions[i][1] = device_mouse_y_to_gui(i);
				}
				holdPositions[i][2] = device_mouse_x_to_gui(i);
				holdPositions[i][3] = device_mouse_y_to_gui(i);
				draw_sprite_ext(sHudJoystick, 0, holdPositions[i][0], holdPositions[i][1], 0.75, 0.75, 0, c_white, 0.75);
				draw_sprite_ext(sHudJoystick, 1, holdPositions[i][2], holdPositions[i][3], 0.75, 0.75, 0, c_white, 0.75);
			}
			else {
				holdPositions[i][0] = 0;
				holdPositions[i][1] = 0;
			}
		}
	}
	#endregion
}
#endregion
#region PauseMenu
if (global.gamePaused and !global.upgrade and !ANVIL and !GoldenANVIL and !PrizeBox and HP > 0 and !instance_exists(oGameOver)) {
	draw_set_halign(fa_left);
	if (instance_exists(oPlayer) and activeMenu == PMenus.Pause) { drawStats(); }
	totalOptions = array_length(pauseMenu[activeMenu][PM.Options]) - 1;
	maxOptions = startOption + 5;
	if (maxOptions > totalOptions) { maxOptions = totalOptions; }	
	draw_sprite_ext(sMenu, 0, GW/2, GH/2, 2.5, 2.5, 0, c_white, 1);
	draw_set_halign(fa_center);
	draw_set_valign(fa_top);
	draw_text_transformed(GW/2, GH/2 - 240, pauseMenu[activeMenu][PM.Title], 4, 4, 0);
	draw_set_valign(fa_middle);
	draw_set_halign(pauseMenu[activeMenu][PM.Align]);
	var _offset = 0;
	if (activeMenu == PMenus.Settings) {
	    pauseMenu[PMenus.Settings][PM.Options] = [
			["Music Volume: " + string(round(global.musicVolume*100)) + "%", PM.Slider, "musicVolume"],
			["Sound Volume: " + string(round(global.soundVolume*100)) + "%", PM.Slider, "soundVolume"],
			["Damage Numbers", PM.Bool, "damageNumbers"],
			["Screen Shake", PM.Bool, "screenShake"],
			["HP UI", PM.Bool, "showhpui"],
		]
	}
	for (var i = startOption; i <= maxOptions; ++i) {
		var _x = GW/2;
		var _y = GH/2 - 145 + _offset;
		var _scale = [selectedOption == i ? 1.35 : 1.25, selectedOption == i ? 1.75 : 1.65]
		var _wh = [(sprite_get_width(sHudButton) * _scale[0]) / 2, (sprite_get_height(sHudButton) * _scale[1]) / 2]
	    draw_sprite_ext(sHudButton, selectedOption == i ? 1 : 0, _x, _y, _scale[0], _scale[1], 0, c_white, 1);
		lastOptionType = pauseMenu[activeMenu][PM.Options][selectedOption][1];
		var _isSelected = selectedOption == i;
		switch (pauseMenu[activeMenu][PM.Options][i][1]) {
			case PM.Slider:
				if (_isSelected) {
					draw_sprite_ext(sMenuArrow, 0, _x - 140, _y, 2, 2, 180, c_white, 1);
					draw_sprite_ext(sMenuArrow, 0, _x + 140, _y, 2, 2, 0, c_white, 1);
				}
			    break;
			case PM.Bool:
				var _sprColor = _isSelected ? 2 : 0;
				var _isEnabled = variable_global_get(pauseMenu[activeMenu][PM.Options][i][2]) ? 1 : 0;
				var _xoff = _isSelected ? 95 : 85
				draw_sprite_ext(sToggleButton, _sprColor + _isEnabled, _x + _xoff, _y, 1.50, 1.50, 0, c_white, 1);
				break;
		}
		if (point_in_rectangle(MX, MY, _x - _wh[0], _y - _wh[1], _x + _wh[0], _y + _wh[1]) and selectedOption == i and mouse_click) { menuClick = true; }
		if (point_in_rectangle(MX, MY, _x - _wh[0], _y - _wh[1], _x + _wh[0], _y + _wh[1])) { selectedOption = i; }
		var _color = selectedOption == i ? c_black : c_white;
		var _selectedOffset = _isSelected ? 115 : 100;
		var _xoff = pauseMenu[activeMenu][PM.Align] == fa_left ? _selectedOffset : 0;
		draw_text_transformed_color(_x - _xoff, _y + 5, pauseMenu[activeMenu][PM.Options][i][0], 2, 2, 0, _color, _color, _color, _color, 1);
		_offset += 69;
	}
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_set_color(c_white);		
	}
#endregion
#region Debug
//DebugManager.debug_add_config("RainbowXP", DebugTypes.Button, self, "", function(){instance_create_depth(oPlayer.x, oPlayer.y + 60, oPlayer.depth, oRainbowXP)});
DebugManager.debug_add_config("Rerrols", DebugTypes.Button, self, "", function(){global.rerolls = 999;});
//DebugManager.debug_add_config("Setweapon", DebugTypes.Button, self, "", function(){ global.upgradeOptions[0] = global.upgradesAvaliable[Weapons.Aik][1]; });
DebugManager.debug_add_config("Special", DebugTypes.Button, self, "", function(){oPlayer.skilltimer = oPlayer.specialcooldown;});
DebugManager.debug_add_config("Levelup", DebugTypes.Button, self, "", function(){global.xp = oPlayer.neededxp;});
DebugManager.debug_add_config("Ghost", DebugTypes.Button, self, "", function(){instance_create_depth(oPlayer.x - 20, oPlayer.y - 20, oPlayer.depth, oMascot);});
//DebugManager.debug_add_config("Minute", DebugTypes.UpDown, self, "minute");
//DebugManager.debug_add_config("Seconds", DebugTypes.UpDown, self, "second");
//DebugManager.debug_add_config("Set time", DebugTypes.Button, self, "", function(){Minutes = minute; Seconds = second});
DebugManager.debug_add_config("a", DebugTypes.UpDown, self, "a");
DebugManager.debug_add_config("b", DebugTypes.UpDown, self, "b");
DebugManager.debug_add_config("c", DebugTypes.UpDown, self, "c");
DebugManager.debug_add_config("d", DebugTypes.UpDown, self, "d");
if (keyboard_check_pressed(ord("M"))) {
	global.debug = !global.debug;
	DebugManager.show = global.debug;
}
//feather enable GM2017
var debugy=170;
offset = 0;
#endregion	
#region Android Buttons
if (os_type == os_android) {
	android_gui_button(zButton);
	android_gui_button(xButton);
	android_gui_button(pButton);
	if (lastOptionType == PM.Slider or selectingOutfit) {
		android_gui_button(plusButton);
		android_gui_button(minusButton);
	}
	if (instance_exists(oHouseManager)) {
		android_gui_button(houseButton);
	}
}
#endregion
#region Info on screen
if (room == rCharacterSelect or room == rInicio) {
	draw_set_halign(fa_right);
	draw_text_transformed(GW - 10, GH/1.05, "CONFIRM: Z | CANCEL: X | Exit: ESC", 2.5, 2.5, 0);
	draw_set_halign(fa_left);
}
#endregion
#region Draw Mouse
var _drawMouse = true;
if (instance_exists(oPlayer) and oPlayer.mouseAim) {
    _drawMouse = false;
	if (global.gamePaused){
		_drawMouse = true;
	}
}
if (_drawMouse and os_type != os_android) {
	cursor_sprite = sMouse;
}
if (!_drawMouse) {
    cursor_sprite = sBlank;
}
if (!centered) {
	centered = true;
    window_center();
}
#endregion