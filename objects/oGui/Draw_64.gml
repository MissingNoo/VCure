//feather disable GM1041
draw_set_alpha(1);
DebugManager.debug_add_config("PrizeBox", DebugTypes.Button, undefined, undefined, function(){PrizeBox = !PrizeBox;});
if (PrizeBox) {
	DebugManager.debug_add_config("Restart Box", DebugTypes.Button, undefined, undefined, function(){boxaccept = false; chestresult = false; chesttimer = 0; chestspr = 0; boxoffset = 700;});
	DebugManager.debug_add_config("Animation time", DebugTypes.UpDown, self, "chestmaxtimer");
	DebugManager.debug_add_config("Chest Size", DebugTypes.UpDown, self, "chestsize");
	DebugManager.debug_add_config("Result Size", DebugTypes.UpDown, self, "resultSize");
	DebugManager.debug_add_config("Result Y", DebugTypes.UpDown, self, "resultY");
	DebugManager.debug_add_config("Coins amount", DebugTypes.UpDown, self, "coinsAmount");
	DebugManager.debug_add_config("Item size", DebugTypes.UpDown, self, "itemsize");
	DebugManager.debug_add_config("Upwards speed", DebugTypes.UpDown, self, "upspeed");
	DebugManager.debug_add_config("Distance between items", DebugTypes.UpDown, self, "itemdistance");
	draw_sprite_ext(sMenu, 0, GW/2, GH/2, 3, 3, 0, c_white, 1);
	draw_sprite_ext(sChest, chestspr, GW/2, GH/2 + 250, chestsize, chestsize, 0, c_white, 1);
	if (!boxaccept) {
		part_emitter_destroy_all(coinsSystem);
	    var w = sprite_get_width(sHudButton) * 0.75;
		var h = sprite_get_height(sHudButton) * 1.50;
		var _x = GW/2;
		var _y = GH/2 + 275;
		var mouseIn = mouse_on_area([_x - (w/2), _y - (h/2), _x + (w/2), _y + (h/2)]);
		draw_sprite_ext(sHudButton, mouseIn ? 1 : 0, _x, _y, 0.75, 1.50, 0, c_white, 1);
		draw_set_valign(fa_middle);
		draw_set_halign(fa_center);
		var _color = mouseIn ? c_black : c_white;
		draw_text_transformed_color(_x, _y + 5, lexicon_text("Hud.Button.Accept"), 2, 2, 0, _color, _color, _color, _color, 1);
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
		if (click_on_area([_x - (w/2), _y - (h/2), _x + (w/2), _y + (h/2)])) {
			boxcoins = irandom_range(72, 103);
			temp = irandom(array_length(ItemList) - 1);
		    boxaccept = true;
			_pemit1 = part_emitter_create(coinsSystem);
			part_emitter_region(coinsSystem, _pemit1, -32, 32, -8, 8, ps_shape_rectangle, ps_distr_linear);
			part_emitter_stream(coinsSystem, _pemit1, _ctype1, coinsAmount);
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
			    draw_surface_part(boxsurface, 0, 0, 128, 522, GW/2 - 64, GH/2 - 306);
			}
		}
		else {
			part_system_drawit(shineSystem);
			draw_sprite_ext(ItemList[temp][1].thumb, 0, GW/2, GH/2 + resultY, resultSize, resultSize, 0, c_white, 1);
		}
		part_system_drawit(coinsSystem);
		draw_sprite_ext(sChestFront, chestspr, GW/2, GH/2 + 250, chestsize, chestsize, 0, c_white, 1);
		if (chestspr < 14) { chestspr += sprite_get_speed(sChest) / 60; }
		boxoffset -= upspeed;
		if (boxoffset <  -3000) { boxoffset = 0; }
	}
}
//feather enable GM1041

//draw_text(mouse_x, mouse_y, $"{mousePrevious}")
//var _names = variable_struct_get_names(oGame.importedSave);
//var _str = "";
//for (var i = 0; i < array_length(_names); ++i) {
//    _str = _str + "\n" + _names[i];
//}
//draw_text(mouse_x, mouse_y, _str);
// Feather disable GM1041
DEBUG
    draw_circle(x,y,5,false);
ENDDEBUG
#region Start variables
var _x = 0;
var _y = 0;
draw_set_alpha(1);
draw_set_color(c_white);
var header;
var digit;
#endregion
#region black screen below gui
if (keyboard_check(vk_alt)) {
	
	//feather disable once GM2017
    //draw_sprite_ext(bgtest, 0, 0, 0, 1, 1, 0, c_white, .8);
    draw_sprite_ext(bgtest264, 0, 0, 0, 1, 1, 0, c_white, .8);
}
if (GoldenANVIL or global.upgrade == 1 or global.gamePaused and room != rInicio and HP > 0) {
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
		//mouseOnButton(GW/1.25, GW/6, 55, sHudButton, 1.75, 1.5, menuOptions);
		draw_sprite_ext(sMenuTitle, 0, GW/3.77, GH/8.53, 0.7, 0.7, 0, c_white, 1);
		//draw_sprite_ext(sMenuTalents, 0, GW/3.47, GH/1.94, 0.8, 0.8, 0, c_white, 1);
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
		menuOptions = ["Singleplayer", "Multiplayer", "Armory", "Achievements", "Shop", "Quit"];
		//[[GW/a,GH/b],[GW/c,GH/d],[GW/e,GH/f]]],
		var buttons = [[0, 1.68 + 0.035, 5.15, 7, 2.5, 
									[[GW/1.07,GH/2.70, GW/1.77,GH/6.30],[GW/1.07,GH/10.38],[GW/1.78,GH/2.61]]],
									[0, 1.76 + 0.035, 2.29, 3.5, -0.65,
									[[GW/1.82,GH/2.53, GW/1.41, GH/1.83],[GW/1.41, GH/2.54],[GW/1.82, GH/1.86]]],
									[0, 1.34, 2.39, 4, 0,
									[[GW/1.39,GH/2.54, GW/1.10, GH/1.79],[GW/1.10, GH/2.57],[GW/1.39,GH/1.83]]],
									[0, 1.56, 1.72, 5, -3.95,
									[[GW/1.70, GH/1.79, GW/1.07, GH/1.32],[GW/1.07, GH/1.71],[GW/1.70,GH/1.42]]],
									[0, 1.67, 1.32, 4, -5.60,									
									[[GW/1.77,GH/1.40, GW/1.42, GH/1.12],[GW/1.42, GH/1.36],[GW/1.77,GH/1.17]]],
									[0, 1.32, 1.29, 5, -5.45,
									[[GW/1.40,GH/1.35, GW/1.15, GH/1.07],[GW/1.15, GH/1.30],[GW/1.40,GH/1.12]]]];
		for (var i = 0; i < array_length(menuOptions); i++) {
			//draw_sprite_ext(buttons[i][0], selected == i ? 1 : 0 , 0, 0, 1, 1, 0, c_white, 1);
			var _color = selected == i ? c_black : c_white;
			var _bgcolor = selected == i ? #d2d2d2 : #a9a9a9;
			draw_triangle_color(buttons[i][5][0][0], buttons[i][5][0][1],buttons[i][5][1][0], buttons[i][5][1][1], buttons[i][5][2][0], buttons[i][5][2][1], _bgcolor, _bgcolor, _bgcolor, false);
			draw_triangle_color(buttons[i][5][0][2], buttons[i][5][0][3],buttons[i][5][1][0], buttons[i][5][1][1], buttons[i][5][2][0], buttons[i][5][2][1], _bgcolor, _bgcolor, _bgcolor, false);
			draw_text_transformed_color(floor(GW/buttons[i][1]), floor(GH/buttons[i][2]), menuOptions[i], buttons[i][3], buttons[i][3], buttons[i][4], _color, _color, _color, _color, 1);
			mouse_on_button_triangle(buttons[i][5][0][0], buttons[i][5][0][1],buttons[i][5][1][0], buttons[i][5][1][1], buttons[i][5][2][0], buttons[i][5][2][1], i);
			mouse_on_button_triangle(buttons[i][5][0][2], buttons[i][5][0][3],buttons[i][5][1][0], buttons[i][5][1][1], buttons[i][5][2][0], buttons[i][5][2][1], i);
		}
	}
	#endregion
}
draw_set_font(global.newFont[2]);
#endregion
#region Character Select Room
var str = ""; var offset = 0;
if (room == rCharacterSelect or room == rAchievements) {
	#region Lines
	var linesoff = 0;
	if (alarm_get(0) == -1) {
		alarm[0]=1;
	}
	for (var i = 0; i < 130; ++i) {
		//draw_sprite_ext(sMenuCharselectBar,0,oGame.linespos+linesoff,display_get_gui_height()+60,1.5,2.15,0,c_white,.25);
		linesoff +=16;
	}	
#endregion
}
if (room == rCharacterSelect) {
	//draw_rectangle_color(0, 0, GW, GH, #19181d, #19181d, #19181d, #19181d, false);
	NAME=CHARACTERS[selectedCharacter][?"name"];
	var _isUnlocked = UnlockableCharacters[CHARACTERS[selectedCharacter][?"id"]];
	draw_set_alpha(0.5);
	draw_rectangle_color(0,0, 64, GH, c_black, c_black, c_black, c_black, false);
	draw_set_alpha(1);
	draw_sprite_ext(sPhaseIcon, 0, 32, 32, .35, .35, 0, #add8e6, 1);
	draw_rectangle_color(0,0, 8, 64, #add8e6, #add8e6, #add8e6, #add8e6, false);
	var gens = ["Origins"];
	draw_sprite_ext(sPhaseOrigins, 0, 32, 200, 0.15, 0.15, 0, c_white, 1);
	#region CharacterList
	if (!characterSelected) {
		//str="CHOOSE YOUR IDOL";
		str = CHARACTERS[selectedCharacter][?"chooseText"];
		draw_set_valign(fa_middle);
		draw_set_halign(fa_center);
		draw_text_transformed(GW/4, GH/8, str, 4.30, 4.30, 0);
		draw_set_valign(fa_top);
		draw_set_halign(fa_left);
		draw_set_color(c_white);
		var _offset = 0;
		var _yoffset = 0;
		_x = GW/10;
		_y = GH/4;
		draw_sprite_ext(sWhiteBack, 0, GW/2.30, GH/6, .65, .48, 0, c_white, 1);
		draw_sprite_ext(CHARACTERS[selectedCharacter][?"bigArt"], 0, GW/1.86, GH/2.11, .5, .5, 0, c_white, 1);
		for (var i=1; i < Characters.Lenght; i++) {
			var _pW = sprite_get_width(CHARACTERS[i][?"portrait"]);
			var _pH = sprite_get_height(CHARACTERS[i][?"portrait"]);
			if (point_in_rectangle(x, y, _x - _pW + _offset, _y - _pH + _yoffset, _x + _pW + _offset, _y + _yoffset + _pH)) {
			    selectedCharacter = i;
			}			
			draw_rectangle(_x - _pW - 2 + _offset, _y - _pH - 2, _x + _pW + 2 + _offset, _y + _pH + 2, false);
			if (UnlockableCharacters[CHARACTERS[i][?"id"]]) {
			    draw_sprite_ext(CHARACTERS[i][?"portrait"], 0, _x + _offset, _y + _yoffset, 2, 2, 0, c_white, 1);
			}
			if (selectedCharacter == i) {
				draw_sprite_ext(sMenuCharSelectCursor,-1,_x + _offset, _y + _yoffset, 2, 2, 0, c_white,1);
			}
			_offset += 95;
			if (i == 5) {
			    _yoffset += 10;
				_offset = 0;
			}
		}		
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
		//draw_sprite_ext(sSelectScreenThingy, 0, GW/a, GH/b, e, e, 0, c_white, 1);
		select_screen_window(GW/1.12, GH/1.31, GW/1.02, GH/1.07, "Special");
		var _speX = GW/1.09;
		var _speY = GH/1.21;
		var _speSpr = SPECIAL_LIST[CHARACTERS[selectedCharacter][?"special"]].thumb;
		var _speSprW = sprite_get_width(_speSpr);
		var _speSprH = sprite_get_height(_speSpr);
		draw_sprite_ext(_speSpr, 0, _speX, _speY, 3, 3, 0, c_white, 1);
		select_screen_window(GW/1.26, GH/1.31, GW/1.13, GH/1.07, "Attack");
		var _atkSpr = CHARACTERS[selectedCharacter][?"weapon"][1].thumb;
		var _atkX = GW/1.19;
		var _atkY = GH/1.14;
		var _atkSprW = sprite_get_width(_atkSpr);
		var _atkSprH = sprite_get_height(_atkSpr);
		draw_sprite_ext(_atkSpr, 0, _atkX, _atkY, 3, 3, 0, c_white, 1);
		select_screen_window(GW/1.26, GH/1.68, GW/1.02, GH/1.33, "Skills");
		_offset = 0;
		for (var i = 0; i < 3; ++i) {
			var _xx = GW/1.20 + _offset;
			var _yy = GH/1.43;
			var _perk = global.characterPerks[selectedCharacter][i]
			var _spr = _perk.thumb;
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
			if (point_in_rectangle(TouchX1, TouchY1, _xx - _sprW, _yy - _sprH, _xx + _sprW, _yy + _sprH)) {
			    select_screen_window(GW/1.43, GH/1.80, GW/1.02-6, GH/1.08, "Skill", 0.75);
				draw_sprite_ext(_spr, 0, GW/1.36, GH/1.51, 3, 3, 0, c_white, 1);
				draw_text_transformed(GW/1.29, GH/1.59, lexicon_text("Perks." + _perk.name + ".name"), 2.5, 2.5, 0);
				drawDesc(GW/1.40, GH/1.41, lexicon_text("Perks." + _perk.name + ".desc"), GW/3.90, 2);
			}
			_offset += 75;
		}
		if (point_in_rectangle(TouchX1, TouchY1, _speX, _speY, _speX + (_speSprW*3), _speY + (_speSprH*3))) {
		    select_screen_window(GW/1.43, GH/1.80, GW/1.02-6, GH/1.08, "Special", 0.75);
			draw_sprite_ext(_speSpr, 0, GW/1.36 - _speSprW, GH/1.51 - _speSprH, 3, 3, 0, c_white, 1);
			draw_text_transformed(GW/1.29, GH/1.59, lexicon_text("Specials." + SPECIAL_LIST[CHARACTERS[selectedCharacter][?"special"]].name + ".name"), 2.5, 2.5, 0);
			drawDesc(GW/1.40, GH/1.41, lexicon_text("Specials." + SPECIAL_LIST[CHARACTERS[selectedCharacter][?"special"]].name + ".desc"), GW/3.90, 2);
		}
		if (point_in_rectangle(TouchX1, TouchY1, _atkX - (_atkSprW*3/2), _atkY - (_atkSprH*3/2), _atkX + (_atkSprW*3/2), _atkY + (_atkSprH*3/2))) {
		    select_screen_window(GW/1.43, GH/1.80, GW/1.02-6, GH/1.08, "Attack", 0.75);
			draw_sprite_ext(_atkSpr, 0, GW/1.36, GH/1.51, 3, 3, 0, c_white, 1);
			draw_text_transformed(GW/1.29, GH/1.59, lexicon_text("Weapons." + CHARACTERS[selectedCharacter][?"weapon"][1].name + ".name"), 2.5, 2.5, 0);
			drawDesc(GW/1.40, GH/1.41, lexicon_text("Weapons." + CHARACTERS[selectedCharacter][?"weapon"][1].name + ".desc"), GW/3.90, 2);
		}
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
		str="CHOOSE MODE";
		draw_set_halign(fa_center);
		draw_text_transformed(GW/2,GH/22.50,str, 4.50, 4.50, 0);
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
	#region Weapon window
	//_x = GW / 1.42;
	//_y = GH / 5.95;
	//_xx = GW / 1.02;
	//_yy = GH / 1.88;
	//_titleY = GH/4.22;
	//_titlePos = 18;
	//_fontSize = 2;
	//drawWindow(_x,_y,_xx,_yy,"ATTACK", _titleY, _titlePos, _fontSize);
	//if (_isUnlocked) {
	//	var weaponID = CHARACTERS[selectedCharacter][?"weapon"];
	//	var weaponSprite = weaponID[1][$ "thumb"];
	//	draw_sprite_ext(weaponSprite, 0,GW/1.37, GH/3.52,2,2,0,c_white,1);
	//	draw_set_valign(fa_middle); draw_set_color(c_white);
	//	draw_text_transformed(_x + 66, _y + 77, lexicon_text("Weapons." + weaponID[1][$ "name"] + ".name"), 2.50, 2.50, 0);
	//	//drawDesc(GW/1.39, GH/2.97, weaponID[1][$"desc"], GW/4.10, 2);
	//	drawDesc(_x + 13, _y + 118, lexicon_text("Weapons." + weaponID[1][$ "name"] + ".1") , 350, 2);
	//}
	//draw_set_valign(0);
	#endregion
	#region Special window
	//_x = GW / 1.42;
	//_y = GH / 1.88;
	//_xx = GW / 1.02;
	//_yy = GH / 1.07;
	//_titleY = GH/1.67;
	//_titlePos = 18;
	//_fontSize = 2;
	//drawWindow(_x,_y,_xx,_yy,"SPECIAL", _titleY, _titlePos, _fontSize);
	//_x = GW/1.37;
	//_y = GH/1.55;
	//if (_isUnlocked) {
	//	var specialID = CHARACTERS[selectedCharacter][?"special"];
	//	var specialSprite = SPECIAL_LIST[specialID][$ "thumb"];
	//	var specialName = lexicon_text("Special." + SPECIAL_LIST[specialID][$ "name"] + ".name");
	//	var specialDesc = lexicon_text("Special." + SPECIAL_LIST[specialID][$ "name"] + ".desc");
	//	draw_sprite_ext(specialSprite, 0,_x - 4 - sprite_get_width(specialSprite), _y-sprite_get_height(specialSprite),2,2,0,c_white,1);
	//	draw_set_valign(fa_middle); draw_set_color(c_white);
	//	draw_text_transformed(_x + 38, _y, specialName, 2, 2, 0);
	//	drawDesc(_x - 19, _y + 35, specialDesc, _x + 1, 2);
	//}
	//draw_set_valign(0);
	#endregion
	
}
#endregion
#region Inside Stage
if (instance_exists(oPlayer))
{	
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
	if (global.upgrade == 1) {
		#region UpgradeList
		offset = 0;
		for (var i = 0; i < array_length(global.upgradeOptions); i++) {
			var _xx = round(GW/1.55);
			var _yy = round(GH/4.16);
			var _xscale = 2.06;
			var _yscale = 1.32;
			draw_sprite_ext(sUpgradeBackground, 0, _xx, _yy + offset, _xscale, _yscale, 0, c_black, .75);//upgrade background
			//draw_sprite_ext(sUpgradeBackground, 2, _xx, _yy + 5 + offset, _xscale, _yscale, 0, c_white, .75);//upgrade line for the text
			draw_rectangle(_xx - 365, _yy + offset - 35, _xx + 365, _yy + offset - 34, false);			
			mouse_on_button(_xx, _yy + offset, sUpgradeBackground, i, _xscale / 1.32, _yscale / 2.2);
			if (i == selected) { //if select draw border
				draw_sprite_ext(sUpgradeBackground, 1, _xx, _yy + offset, _xscale, _yscale, 0, c_white, 1);//upgrade background
				draw_sprite_ext(sHoloCursor, holoarrowspr, _xx - 415, _yy + 2 + offset, 2, 2, 0, c_white, 1); 
			} 
			draw_set_halign(fa_left);
		//	offset += 138;
		//}
		//offset = 0;
		//for (var i = 0; i < array_length(global.upgradeOptions); i++) {
			var uptype = "";
			switch (global.upgradeOptions[i][$ "style"]) { // type of upgrade
				case ItemTypes.Weapon:{
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
					uptype = "Items.";
					break;}
				case ItemTypes.Perk:{
					uptype = "Perks.";
					break;}
			}
			var _name = lexicon_text(uptype + string(global.upgradeOptions[i][$ "name"]) + ".name");
			//draw_text_transformed(_xx - 348 + guiOffset, _yy - 64 + offset - androidoffset, _name, 2, 2, 0); // draw the name //UNUSED
			draw_text_transformed(_xx - 348, _yy - 57 + offset, _name, 2, 2, 0); // draw the name
			draw_set_color(c_white);
			var style = ""; 
			switch (global.upgradeOptions[i][$ "style"]) { // type of upgrade
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
			//draw_text_transformed(_xx + 340 - guiOffset, _yy - 64 + offset - androidoffset, string(style), 2, 2, 0);  // draw type of upgrade //UNUSED
			draw_text_transformed(_xx + 340, _yy - 57 + offset, string(style), 2, 2, 0);  // draw type of upgrade 
			draw_set_halign(fa_left);
			draw_sprite_ext(global.upgradeOptions[i][$ "thumb"],0,_xx - 322, _yy + 8 + offset,2, 2,0,c_white,1); // item thumb			
			draw_sprite_ext(sItemType, global.upgradeOptions[i][$ "style"], _xx - 322, _yy + 8 + offset,2, 2,0,c_white,1); // item thumb type
			var foundup = false;
			var foundlv = 0;
			switch (global.upgradeOptions[i][$ "style"]) { // type of upgrade
				case ItemTypes.Item:{
					for (var j = 0; j < array_length(playerItems); ++j) {
						if (playerItems[j][$ "id"] == global.upgradeOptions[i][$ "id"]) {
							foundup = true;
							foundlv = playerItems[j][$ "level"] + 1;
						}
					}	
					break;}
				case ItemTypes.Perk:{
					for (var j = 0; j < array_length(PLAYER_PERKS); ++j) {
						if (PLAYER_PERKS[j][$ "id"] == global.upgradeOptions[i][$ "id"]) {
							foundup = true;
							foundlv = PLAYER_PERKS[j][$ "level"] + 1;
						}
					}	
					break;}
				case ItemTypes.Weapon:{
					for (var j = 0; j < array_length(UPGRADES); ++j) {
						if (UPGRADES[j][$ "name"] == global.upgradeOptions[i][$ "name"]) {
							foundup = true;
							foundlv = UPGRADES[j][$ "level"] + 1;
						}
					}	
					break;}
			}		
			var maxx = 600;
			//if (os_type == os_android) {
			//	maxx = GW/2.50;
			//}else{
			//	maxx = GW/2.07;
			//}	
			var desc = "";
			if (foundup) {
				var idd = global.upgradeOptions[i][$ "id"];
				desc = lexicon_text(uptype + global.upgradeOptions[i][$ "name"] + "." + string(foundlv));
				//draw_text_ext_transformed(GW/2.20+(guiOffset/2) + 5,GH/5.5+offset, lexicon_text(uptype + global.upgradeOptions[i][$"name"] + "." + string(foundlv)), string_width("W"), 327.5, 2,2,0);
			}
			else{
				desc = lexicon_text(uptype + global.upgradeOptions[i][$ "name"] + ".1");
				//draw_text_ext_transformed(GW/2.20+(guiOffset/2) + 5,GH/5.5+offset, lexicon_text(uptype + global.upgradeOptions[i][$"name"] + ".1"), string_width("W"), 327.5, 2,2,0);
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
			if (buttonClick([_rerollX - _sprW, _rerollY - _sprH, _rerollX + _sprW, _rerollY + _sprH])) {
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
			//if (!anvilconfirm) { mouseOnButton(GW/2.30, GH/3, GW/12, sItemSquare, 2, 2, UPGRADES, "anvilSelected", "horizontal");}
			if (anvilSelectedCategory == 0 and i == anvilSelected){
				anvilIsSelected = 1;
			}else{
				anvilIsSelected = 0;
			}
			draw_sprite_ext(sItemSquare, anvilIsSelected, GW/2.30 + xoffset, GH/3, 2, 2, 0, c_white, 1);
			var _sprHalf = (sprite_get_width(sItemSquare) * 2 ) / 2;
			if (buttonClick([GW/2.30 - _sprHalf + xoffset, GH/3 - _sprHalf, GW/2.30 + _sprHalf + xoffset, GH/3 + _sprHalf])) {
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
			if (buttonClick([GW/2.30 - _sprHalf + xoffset, GH/2.30 - _sprHalf, GW/2.30 + _sprHalf + xoffset, GH/2.30 + _sprHalf])) {
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
				var _coinValue = 0;
				if (variable_struct_exists(selectedThing, "bonusLevel")) {
					for (var i = 0; i < selectedThing[$ "bonusLevel"]; ++i) {
						_coinValue += 50;
						_chance -= 10;
					}
				}
				if (_chance < 10) {_chance=10;}
				draw_set_valign(fa_middle);
				draw_text_transformed_color(_tx, _ty - 40, string("Sucess Rate: {0}%", _chance), 2,2,0,c_white,c_white,c_white,c_white, 1);
				var _confirmstring = string("Cost: {0} to UPGRADE", _coinValue);
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
			if (buttonClick([_x - _sprHalf + _offset, _y - _sprHalf, _x + _sprHalf + _offset, _y + _sprHalf])) {
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
				if (buttonClick([_x - _sprHalf + _offset - _distance, _y - _sprHalf + _down, _x + _sprHalf + _offset - _distance, _y + _sprHalf + _down])) {
					gAnvilWeapon1 = global.null;
				}
				
				draw_sprite_ext(sItemSquare, 0, _x + _offset + _distance, _y + _down, 2, 2, 0, c_white, 1);
				draw_sprite_ext(gAnvilWeapon2[$ "thumb"], 0, _x + _offset + _distance, _y + _down, 2, 2, 0, c_white, 1);
				if (buttonClick([_x - _sprHalf + _offset + _distance, _y - _sprHalf + _down, _x + _sprHalf + _offset + _distance, _y + _sprHalf + _down])) {
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
	#region Timer
	var time = string(global.minutes) + ":" + string(string_format(global.seconds,2,0));
	draw_text_transformed(GW/2-(string_width(time)/2),35,time,1,1,0);
	#endregion
	#region Buffs
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
}
#endregion
#region PauseMenu
if (global.gamePaused and !global.upgrade and !ANVIL and !GoldenANVIL and HP > 0 and !instance_exists(oGameOver)) {
	draw_set_halign(fa_left);
	if (instance_exists(oPlayer) and activeMenu == PMenus.Pause) { drawStats(); }
	var startOption = 0;
	var totaloptions = array_length(pauseMenu[activeMenu][PM.Options]);
	var _scaleoff = 0;
	if (totaloptions > 6) {
		_scaleoff = 3;
	}
	draw_sprite_ext(sMenu, 0, GW/2, GH/2, pauseMenu[activeMenu][PM.XScale] + _scaleoff, pauseMenu[activeMenu][PM.YScale], 0,c_white,1);
	draw_set_halign(fa_center);
	draw_set_valign(fa_top);		
	draw_text_transformed(GW/2, 
	(GH/2 - (sprite_get_height(sMenu) * pauseMenu[activeMenu][PM.YScale])/2) + 20,
	pauseMenu[activeMenu][PM.Title], 
	3, 3, 0);
	var mOffset = 0;
	draw_set_valign(fa_middle);
	//if (global.debug) {
	//	draw_text(300, 200,
	//	"totaloptions = " + string(array_length(pauseMenu[activeMenu][PM.Options])) +
	//	" \n totalOptionsNow= " + string(totaloptions) +
	//	" \n startOption= " + string(startOption) +
	//	" \n selected= " + string(selected) +
	//	" \n t-s= " + string(totaloptions - startOption) +
	//	" \n totaloptions = " + string("a")	
	//	);
	//}
	var bigString = 0;
	for (var i = 0; i < array_length(pauseMenu[activeMenu][PM.Options]); ++i) {
		if (string_length(pauseMenu[activeMenu][PM.Options][i])/11 > bigString) {
			bigString = string_length(pauseMenu[activeMenu][PM.Options][i])/11;
		}
	}
	//mouseOnButton(GW/2, (GH/2 - (sprite_get_height(sMenu) * pauseMenu[activeMenu][PM.YScale])/2) + 90, 45, sHudButton, bigString, 1, array_create(array_length(pauseMenu[activeMenu][PM.Options]),0), "selected");
	for (var i = startOption; i < totaloptions; ++i) {
		var _xoff = 0;
		if (totaloptions > 6) {
			if (i <= 5) {
				_xoff = sprite_get_width(sHudButton) * -1;
			}
			else{
				_xoff = sprite_get_width(sHudButton);
			}
		}
		var spr = (selected == i) ? 1 : 0;
		var _ox = GW/2 + _xoff;
		var _oy = (GH/2 - (sprite_get_height(sMenu) * pauseMenu[activeMenu][PM.YScale])/2) + 90 + mOffset;
		draw_sprite_ext(sHudButton, spr, _ox, _oy, bigString, 1.35,0,c_white,1);	
		mouse_on_button(_ox, _oy, sHudButton, i, bigString, 1.35);
		var _arrowoff = 160;
		if (editOption and selected == i) {
			draw_sprite_ext(sMenuArrow, 0, GW/2 + _xoff - _arrowoff,
			(GH/2 - (sprite_get_height(sMenu) * pauseMenu[activeMenu][PM.YScale])/2) + 90 + mOffset,
			2,
			2,180,c_white,1);
			draw_sprite_ext(sMenuArrow, 0, GW/2 + _xoff + _arrowoff,
			(GH/2 - (sprite_get_height(sMenu) * pauseMenu[activeMenu][PM.YScale])/2) + 90 + mOffset,
			2,
			2,0,c_white,1);
		}
		draw_set_color(selected == i ? c_black : c_white);
		draw_text_transformed(GW/2 + _xoff,
		(GH/2 - (sprite_get_height(sMenu) * pauseMenu[activeMenu][PM.YScale])/2) + 90 + mOffset,
		pauseMenu[activeMenu][PM.Options][i], 1.5, 1.5, 0);	
		if (activeMenu == PMenus.Settings  and pauseMenu[activeMenu][PM.Bool][i] == true) {
			var boolselected = (selected == i) ? 2 : 0;
			var boolv = (pauseMenu[activeMenu][PM.BoolValue][i]) ? 1 : 0;
			draw_sprite_ext(sToggleButton, boolselected + boolv, GW/1.72 + _xoff, 
			(GH/2 - (sprite_get_height(sMenu) * pauseMenu[activeMenu][PM.YScale])/2) + 90 + mOffset,
			1, 1,0,c_white,1);
		}
		if (i == 5) {
			mOffset=-45;
		}
		mOffset+=45;
	}
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_set_color(c_white);		
	}
#endregion
#region Debug
if (keyboard_check_pressed(ord("M"))) {
	if (global.debug) {
		global.debug = false;
	}
	else global.debug=true;
	DebugManager.show = global.debug;
}
//draw_text(10,10,global.debug);
var debugy=170;
offset = 0;
#endregion	
#region Android Buttons
if (os_type == os_android) 
{
	android_gui_button(zButton);
	android_gui_button(xButton);
	android_gui_button(pButton);
	if (editOption or selectingOutfit) {
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
	draw_text_transformed(GW/1, GH/1.05, "CONFIRM: Z | CANCEL: X / ESC", 2.5, 2.5, 0);
	draw_set_halign(fa_left);
}
#endregion
//x = 0;
//y = 0;
var _drawMouse = true;
if (instance_exists(oPlayer) and oPlayer.mouseAim) {
    _drawMouse = false;
	if (ANVIL or GoldenANVIL or global.upgrade){
		_drawMouse = true;
	}
}
if (_drawMouse and os_type != os_android) {
	cursor_sprite = sMouse;
	//draw_sprite_ext(sMouse, 0, device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), 2, 2, 0, c_white, 1);
}
if (!_drawMouse) {
    cursor_sprite = sBlank;
}