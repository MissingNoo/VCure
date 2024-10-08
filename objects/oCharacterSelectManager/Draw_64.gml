//feather disable GM2017
var d = DebugManager;
if (keyboard_check(vk_f1)) {
    draw_sprite_stretched(ark, 0, 0, 0, GW, GH);
}
var offset = 0;
NAME = CHARACTERS[selectedCharacter][? "name"];
var _isUnlocked = CharacterData[char_pos(CHARACTERS[selectedCharacter][? "name"], CharacterData)].unlocked;
var _x;
var _y;
var _offset;
var _yy;
var _max;
var charpos = char_pos(CHARACTERS[selectedCharacter][? "name"], CHARACTERS);
var datapos = char_pos(CHARACTERS[selectedCharacter][? "name"], CharacterData);
if (_isUnlocked) {
	scribble(string_replace(string_upper(CHARACTERS[selectedCharacter][? "name"]), " ", "\n")).scale(7, 7).draw(GW/1.48, GH/7.31);
	#region Outfit save/select
	if (CharacterData[datapos][$ "lastOutfit"] != undefined) {
		selectedOutfit = CharacterData[datapos][$ "lastOutfit"];
	}
	var sprdata = array_find_index(CHARACTERS[charpos][? "outfits"], function(e, i) {
		var datapos = char_pos(CHARACTERS[selectedCharacter][? "name"], CharacterData);
		return e[$ "name"] == CharacterData[datapos][$ "outfits"][selectedOutfit];
	});
	var idlesprite = CHARACTERS[selectedCharacter][? "outfits"][sprdata][$ "sprite"];
	var runsprite = CHARACTERS[selectedCharacter][? "outfits"][sprdata][$ "runningSprite"];
	#endregion
	//draw_sprite_ext(sCharShadow, 0, GW/2, GH/1.75, 8, 8, 0, c_white, 0.8);
	draw_sprite_ext(currentSprite == 0 ? idlesprite : runsprite, characterSubImage[0], GW - 460, GH - 280, 5, 5, 0, c_white, 1);
	//draw_sprite_ext(CHARACTERS[selectedCharacter][? "bigArt"], 0, GW/2, GH/2, 56, 56, 0, c_white, 1);
	var _charInfo = CHARACTERS[selectedCharacter];
	var _info = [
		[sHudHPIcon, _charInfo[?"hp"], "", "HP"],
		[sHudAtkIcon, _charInfo[?"atk"], "x", "ATK"], 
		[sHudSpdIcon,_charInfo[?"speed"], "x", "SPD"], 
		[sHudCrtIcon,_charInfo[?"crit"], "%", "CRT"]
	];
	var _yoffset = 0;
	//draw_set_alpha(0.5);
	//select_screen_window(GW/1.53, GH/1.68, GW/1.27, GH/1.07, "Status", 0.15);
	for (var i = 0; i < array_length(_info); ++i) {
		var _val = string($"{_info[i][1]}{_info[i][2]}");
		var sx = GW - 586;
		var sy = GH - 249 + _yoffset;
		draw_sprite_ext(_info[i][0], 0, sx, sy, 3, 3, 0, c_white, 1);
		draw_set_alpha(0.5);
		draw_rectangle_color(sx + 34, sy - 20, sx + 244, sy + 19, c_black, c_black, c_black, c_black, false);
		draw_set_alpha(1);
		draw_rectangle_color(sx + 34, sy - 20, sx + 114, sy + 19, c_white, c_white, c_white, c_white, false);
		scribble($"[#4abef9][fa_middle]{_info[i][3]}").scale(3).draw(sx + 45, sy + 3);
		scribble($"[fa_middle]{_val}").scale(3).draw(sx + 125, sy + 3);
		//scribble($"[{}] {_val}").scale(3).draw(GW/1.48, GH/1.52 + _yoffset);
		_yoffset += 46;
	}
}
#region Fandom
var fandom = [[sFollowingFan, sFollowingFanLocked, 33], [sFollowingOshi, sFollowingOshiLocked, 66], [sFollowingGachikoi, sFollowingGachikoiLocked, 100]];
var fandomlevel = -1;
var fandomxp = CharacterData[char_pos(CHARACTERS[selectedCharacter][? "name"], CharacterData)].fandomxp;
if (fandomxp >= 33) { fandomlevel = 0; }
if (fandomxp >= 66) { fandomlevel = 1; }
if (fandomxp >= 100) { fandomlevel = 2; }
if (fandomlevel != -1) {
    draw_sprite_ext(fandom[fandomlevel][0], fandom_current_frame[fandomlevel][0], GW - 65, GH/2 - 100, 2.50, 2.50, 0, c_white, 1);
}
else {
	draw_sprite_ext(fandom[0][1], 0, GW - 65, GH/2 - 100, 2.50, 2.50, 0, c_white, 1);
}
#endregion
#region GRank
draw_rectangle_color(GW - 232, GH/2 - 2 - 19, GW - 128, GH/2 - 2 + 19, c_white, c_white, c_white, c_white, false);
draw_sprite_ext(sGRankArrow, 0, GW - 266, GH/2 - 8, 2.45, 2.45, 0, c_white, 1);
scribble("[fa_center][fa_middle][c_orange]G. RANK").scale(2.75).draw(GW - 180, GH/2);
draw_rectangle_color(GW - 128, GH/2 - 2 - 19, GW - 30, GH/2 - 2 + 19, c_orange, c_orange, c_orange, c_orange, false);
draw_sprite_ext(sAchFirstback, 0, GW - 266, GH/2 + 55, 2.25, 2.25, 0, c_white, 1);
draw_sprite_ext(sAchFirstWin, 0, GW - 266, GH/2 + 55, 2.25, 2.25, 0, c_white, 1);
scribble($"[fa_middle]{CharacterData[datapos][$ "grank"]}").scale(2.75).draw(GW - 120, GH/2);
#endregion
#region Wins
draw_rectangle_color(GW - 232, GH/2 + 56 - 19, GW - 128, GH/2 + 56 + 19, c_white, c_white, c_white, c_white, false);
scribble("[fa_middle][c_orange]WINS").scale(2.75).draw(GW - 226, GH/2 + 58);
draw_rectangle_color(GW - 128, GH/2 + 56 - 19, GW - 30, GH/2 + 56 + 19, c_orange, c_orange, c_orange, c_orange, false);
scribble("[fa_middle]-1").scale(2.75).draw(GW - 120, GH/2 + 58);
#endregion
#region Special Window
select_screen_window(GW - 155, GH - 196, GW - 30, GH - 57, "Special", 0.5, c_black);
var _speX = GW - 118;
var _speY = GH - 135;
var _speSpr = _isUnlocked ? SPECIAL_LIST[CHARACTERS[selectedCharacter][?"special"]].thumb : sLockIcon;
var _speSprW = sprite_get_width(_speSpr);
var _speSprH = sprite_get_height(_speSpr);
var specialscale = 2.5;
var _specialsUnlocked = global.shopUpgrades[$ "SpecialAtk"][$ "level"] == 1;
draw_sprite_ext(_specialsUnlocked ? _speSpr : sLockIcon, 0, _speX, _speY, specialscale, specialscale, 0, c_white, 1);
#endregion
#region Atk Window
select_screen_window(GW - 289, GH - 196, GW - 164, GH - 57, "Attack", 0.5, c_black);
var _atkSpr = _isUnlocked ? CHARACTERS[selectedCharacter][?"weapon"][1].thumb : sCharacterLockedIcon;
var _atkX = GW - 230;
var _atkY = GH - 110;
var atkscale = 2.50;
var _atkSprW = sprite_get_width(_atkSpr);
var _atkSprH = sprite_get_height(_atkSpr);
draw_sprite_ext(_atkSpr, 0, _atkX, _atkY, atkscale, atkscale, 0, c_white, 1);
#endregion
#region Skills Window
select_screen_window(GW - 289, GH - 336, GW - 28, GH - 212, "Skills", 0.5, c_black);
_offset = 0;
for (var i = 0; i < 3; ++i) {
	var _xx = GW - 230 + _offset;
	_yy = GH - 254;
	var _perk = CHARACTERS[selectedCharacter][? "perks"][i]
	var perkscale = 2.50;
	var _spr = _isUnlocked ? _perk.thumb : sCharacterLockedIcon;
	var _sprW = sprite_get_width(_spr) * perkscale / 2;
	var _sprH = sprite_get_height(_spr) * perkscale / 2;
	draw_sprite_ext(_spr, 0, _xx, _yy, perkscale, perkscale, 0, c_white, 1);
	_offset += 69;
}
_offset = 0;
for (var i = 0; i < 3; ++i) {
	var _xx = GW/1.20 + _offset;
	_yy = GH/1.43;
	var _perk = CHARACTERS[selectedCharacter][? "perks"][i];
	var _spr = _perk.thumb;
	var _sprW = sprite_get_width(_spr) * 3 / 2;
	var _sprH = sprite_get_height(_spr) * 3 / 2;
	//if (!sidebarOpen and point_in_rectangle(MX, MY, _x - _pW + _offset, _y - _pH + _yoffset, _x + _pW + _offset, _y + _yoffset + _pH) and selectedCharacter == i and mouse_click) { menuClick = true; }
	if (_isUnlocked and point_in_rectangle(TouchX1, TouchY1, _xx - _sprW, _yy - _sprH, _xx + _sprW, _yy + _sprH) and mouse_click) {
		infolevel = 1;
		state = "showinfo";
		info = "skills"
	//	select_screen_window(GW/1.43, GH/1.80, GW/1.02-6, GH/1.08, "Skill", 0.75);
	//	draw_sprite_ext(_spr, 0, GW/1.36, GH/1.51, 3, 3, 0, c_white, 1);
	//	scribble(lexicon_text("Perks." + _perk.name + ".name")).scale(2.5).draw(GW/1.29, GH/1.59);
	//	//draw_text_transformed(GW/1.29, GH/1.59, lexicon_text("Perks." + _perk.name + ".name"), 2.5, 2.5, 0);
	//	scribble(lexicon_text("Perks." + _perk.name + ".desc")).scale(2).wrap(190 * global.guiScale).draw(GW/1.40, GH/1.41);
	}
	_offset += 75;
}
#endregion
#region Open Window when mouse over
if (_isUnlocked and point_in_rectangle(TouchX1, TouchY1, _speX, _speY, _speX + (_speSprW*3), _speY + (_speSprH*3)) and global.shopUpgrades[$ "SpecialAtk"][$ "level"] == 1) {
	select_screen_window(GW/1.43, GH/1.80, GW/1.02-6, GH/1.08, "Special", 0.75, c_black);
	draw_sprite_ext(_speSpr, 0, GW/1.36 - _speSprW, GH/1.51 - _speSprH, 3, 3, 0, c_white, 1);
	scribble(lexicon_text("Specials." + SPECIAL_LIST[CHARACTERS[selectedCharacter][?"special"]].name + ".name")).scale(2.5).draw(GW/1.29, GH/1.59);
	//draw_text_transformed(GW/1.29, GH/1.59, lexicon_text("Specials." + SPECIAL_LIST[CHARACTERS[selectedCharacter][?"special"]].name + ".name"), 2.5, 2.5, 0);
	scribble(lexicon_text("Specials." + SPECIAL_LIST[CHARACTERS[selectedCharacter][?"special"]].name + ".desc")).scale(2).wrap(190 * global.guiScale).draw(GW/1.40, GH/1.41);
}
if (_isUnlocked and point_in_rectangle(TouchX1, TouchY1, _atkX - (_atkSprW*atkscale/2), _atkY - (_atkSprH*atkscale/2), _atkX + (_atkSprW*atkscale/2), _atkY + (_atkSprH*atkscale/2)) and mouse_click) {
	infolevel = 1;
	state = "showinfo";
	info = "weapon"
//	select_screen_window(GW/1.43, GH/1.80, GW/1.02-6, GH/1.08, "Attack", 0.75);
//	draw_sprite_ext(_atkSpr, 0, GW/1.36, GH/1.51, 3, 3, 0, c_white, 1);
//	scribble(lexicon_text("Weapons." + CHARACTERS[selectedCharacter][?"weapon"][1].name + ".name")).scale(2.5).draw(GW/1.29, GH/1.59);
//	//draw_text_transformed(GW/1.29, GH/1.59, lexicon_text("Weapons." + CHARACTERS[selectedCharacter][?"weapon"][1].name + ".name"), 2.5, 2.5, 0);
//	scribble(lexicon_text("Weapons." + CHARACTERS[selectedCharacter][?"weapon"][1].name + ".desc")).scale(2).wrap(190 * global.guiScale).draw(GW/1.40, GH/1.41);
}
#endregion

#region CharacterList
if (!characterSelected) {
	//Feather disable once GM1041
	var _yoffset = 0 - characterlerp[0];	
	scribble("[white][fa_middle][fa_center]CHOOSE YOUR VTUBER").scale(5).draw(410, 82 + _yoffset);
	_offset = 0;
	_x = 190;
	_y = 216;
	var pscale = 2.30;
	//draw_sprite_ext(sWhiteBack, 0, GW/2.30, GH/6, .65, .48, 0, c_white, 1);
	//if (_isUnlocked) {
	//	draw_sprite_ext(CHARACTERS[selectedCharacter][?"bigArt"], 0, GW/1.86, GH/2.11, .5, .5, 0, c_white, 1);
	//}
	for (var i = 0; i < array_length(CHARACTERS); i++) {
		if (CHARACTERS[i][?"agency"] != selectedAgency and selectedAgency != "All") {
			continue;
		}
		var _pW = (sprite_get_width(CHARACTERS[i][?"portrait"]) * pscale) / 2;
		var _pH = (sprite_get_height(CHARACTERS[i][?"portrait"]) * pscale) / 2;
		if (!sidebarOpen and point_in_rectangle(MX, MY, _x - _pW + _offset, _y - _pH + _yoffset, _x + _pW + _offset, _y + _yoffset + _pH) and selectedCharacter == i and mouse_click) { menuClick = true; }
		if (!sidebarOpen and point_in_rectangle(MX, MY, _x - _pW + _offset, _y - _pH + _yoffset, _x + _pW + _offset, _y + _yoffset + _pH) and state == "base") {
			selectedCharacter = i;
			if (soundplayedby != i) {
				soundplayedby = i;
				audio_play_sound(snd_char_select_woosh,0,0, global.soundVolume);
			}
		}
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
		draw_sprite_ext(CharacterData[char_pos(CHARACTERS[i][? "name"], CharacterData)].unlocked ? CHARACTERS[i][?"portrait"] : sCharacterLockedIcon, 0, _x + _offset, _y + _yoffset, pscale, pscale, 0, c_white, 1);
		if (selectedCharacter == i) {
			draw_sprite_ext(sMenuCharSelectCursor,-1,_x + _offset, _y + _yoffset, pscale, pscale, 0, c_white,1);
		}
		if (i == 4) {
			_yoffset += 101 - characteroffsetlerp[0];
			_offset = 0;
		}
		else {
			_offset += 110;
		}
	}
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
draw_rectangle_color(0,0, 64 + sidebarlerp[0], GH, c_black, c_black, c_black, c_black, false);
draw_rectangle_color(64 + sidebarlerp[0],0, sidebar[0] + sidebarlerp[0], GH, c_black, c_black, c_black, c_black, false);
draw_set_alpha(1);
draw_surface_part(_surf, 0, 0, sidebar[0], GH, 0 + sidebarlerp[0], 0);
surface_free(_surf);
//draw_circle(MX, MY, 32, false);
if (state == "base" and point_in_rectangle(TouchX1, TouchY1, 0, 0, 64 + (sidebar[0] > 64 ? sidebar[0] - 64 : sidebar[0]), GH) or sidebarOpenByButton) {
	sidebarOpen = true;
}
else {
	sidebarOpen = false;
}
#endregion

switch (state) {
    case "base":
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
        break;
    case "showinfo":
        //scribble($"{state},{info},{infolevel}").scale(2).draw(MX, MY + 10);
		draw_set_alpha(0.5);
		draw_rectangle_color(0, 0, GW, GH, #19181D, #19181D, #19181D, #19181D, false);
		draw_set_alpha(0.75);
		_x = GW/4;
		_y = GH/2;
		draw_rectangle_color(_x - 150, _y - 150, _x + 150, _y + 150, c_black, c_black, c_black, c_black, false);
		draw_set_alpha(1);
		scribble("[fa_center][fa_middle]LEVEL").scale(9).draw(_x, _y - 90);
		scribble($"[fa_center][fa_middle]{infolevel}").scale(20).draw(_x, _y + 50);
		switch (info) {
			case "weapon":
			    _max = CHARACTERS[selectedCharacter][?"weapon"][1][$ "maxlevel"];
			    break;
			case "skills":
			    _max = 3;
			    break;
		}
		if (infolevel < _max) {
		    draw_triangle_color(triangleR[0][0], triangleR[0][1], triangleR[1][0], triangleR[1][1], triangleR[2][0], triangleR[2][1], c_white, c_white, c_white, false);
		}
		if (infolevel > 1) {
		    draw_triangle_color(triangleL[0][0], triangleL[0][1], triangleL[1][0], triangleL[1][1], triangleL[2][0], triangleL[2][1], c_white, c_white, c_white, false);
		}
		_x  = GW/1.60;
		var _xscale = 2.20;
		var _yscale = 1.40;
		_y  = GH/2;
		switch (info) {
		    case "weapon":
				var _weapon = CHARACTERS[selectedCharacter][?"weapon"][1];
		        draw_sprite_ext(sUpgradeBackground, 0, _x + 40, _y, _xscale, _yscale, 0, c_black, .75);
				draw_rectangle(_x - 365, _y - 35, _x + 440, _y - 34, false);
				scribble(lexicon_text($"Weapons.{_weapon[$ "name"]}.name")).scale(2).draw(_x - 348, _y - 57);
				scribble("[fa_right]>> Weapon").scale(2).draw(_x + 440, _y - 57);
				draw_sprite_ext(_weapon[$ "thumb"],0,_x - 322, _y + 8, 2, 2, 0, c_white, 1);
				draw_sprite_ext(sItemType, _weapon[$ "style"], _x - 322, _y + 8, 2, 2,0,c_white,1);
				drawDesc(_x- 230, _y - 28, lexicon_text($"Weapons.{_weapon[$ "name"]}.{infolevel}"), 700, 2);
		        break;
		    case "skills":
				_y = _y - 175
				for (var i = 0; i < 3; ++i) {
					var _perk = CHARACTERS[selectedCharacter][? "perks"][i];
			        draw_sprite_ext(sUpgradeBackground, 0, _x + 40, _y, _xscale, _yscale, 0, c_black, .75);
					draw_rectangle(_x - 365, _y - 35, _x + 440, _y - 34, false);
					scribble(lexicon_text($"Perks.{_perk[$ "name"]}.name")).scale(2).draw(_x - 348, _y - 57);
					scribble("[fa_right]>> Skill").scale(2).draw(_x + 440, _y - 57);
					draw_sprite_ext(_perk[$ "thumb"],0,_x - 322, _y + 8, 2, 2, 0, c_white, 1);
					draw_sprite_ext(sItemType, _perk[$ "style"], _x - 322, _y + 8, 2, 2,0,c_white,1);
					drawDesc(_x- 230, _y - 28, lexicon_text($"Perks.{_perk[$ "name"]}.{infolevel}"), 700, 2);
					_y += 175;
				}
				break;
		}
        break;
	case "stage":
		draw_set_alpha(0.5);
		draw_rectangle_color(0, 0, GW/2.75 + stagelerp[0], GH, c_black, c_black, c_black, c_black, false);
		draw_set_alpha(1);
		_x = GW/5.60 + stagelerp[0];
		_y = round(GH/3.14);
		switch (stageSelected) {
		    case true:
				gpu_set_blendmode(bm_max);
				//draw_set_alpha(0.75);
				//draw_rectangle_color(GW/30, GH/5.50, GW/3.05, GH, c_white, c_white, c_black, c_black, false);
				//draw_set_alpha(1);
				gpu_set_blendmode(bm_normal);
		        scribble("[fa_center][fa_middle]CHOOSE STAGE").scale(4.50).draw(_x, GH/8);
				_yy = GH/2.50;
				var _pw = sprite_get_width(stages[selectedStage].port) / 2 * 3.25;
				var _ph = sprite_get_height(stages[selectedStage].port) / 2 * 3.25;
				draw_rectangle_color(_x - _pw, _yy - _ph, _x + _pw - 2, _yy + _ph - 1, c_black, c_black, c_black, c_black, false);
				var _sx = _pw;
				var _sy = 300;
				if (point_in_rectangle(MX, MY, _x - _pw, _yy - _ph, _x + _pw, _yy + _ph) and device_mouse_check_button_pressed(0, mb_left)) {
					stageswiping = true;
					swipestartoffset = MX;
				}
				if (stageswiping) {
				    swipeoffset = clamp(MX - swipestartoffset, -175, 175);
				}
				if (surface_exists(stagesurf)) {
					surface_set_target(stagesurf);
					draw_clear_alpha(c_black, 0);
					var _soffset = 0
					for (var i = 0; i < array_length(stages); ++i) {
						draw_sprite_ext(stages[i].port, 0, _sx + stageselectlerp[0] + swipeoffset + _soffset, _sy, 3.25, 3.25, 0 ,c_white, 0.85);
						draw_sprite_ext(stages[i].back, 0, _sx + stageselectlerp[0] + swipeoffset + _soffset, _sy, 1.25, 1.25, 0 ,c_white, 0.80);
						scribble_outline($"[fa_center][fa_middle]{stages[i].name}", _sx + stageselectlerp[0] + swipeoffset  + _soffset, _sy, "c_black", 8);
						_soffset += 490;
					}
					surface_reset_target();
				}
				else {
					stagesurf = surface_create(sprite_get_width(stages[selectedStage].port) * 3.25, 600);
				}
				draw_surface(stagesurf, _x-_sx, _yy-_sy);
				var _xoff = _pw + 15;
				triangleSR = [[_x + _xoff, _yy - 40], [_x + _xoff, _yy + 40], [_x + _xoff + 20, _yy]];
				triangleSL = [[_x - _xoff, _yy - 40], [_x - _xoff, _yy + 40], [_x - _xoff - 20, _yy]];
				_max = array_length(stages) - 1;
				if (selectedStage < _max) {
				    draw_triangle_color(triangleSR[0][0], triangleSR[0][1], triangleSR[1][0], triangleSR[1][1], triangleSR[2][0], triangleSR[2][1], c_white, c_white, c_white, false);
				}
				if (selectedStage > 0) {
				    draw_triangle_color(triangleSL[0][0], triangleSL[0][1], triangleSL[1][0], triangleSL[1][1], triangleSL[2][0], triangleSL[2][1], c_white, c_white, c_white, false);
				}
				draw_sprite_ext(sHudButton, 1, _x, GH/1.40, 1, 2, 0, c_white, 1);
				scribble("[c_black][fa_center][fa_middle]GO!").scale(2).draw(_x, GH/1.40);
		        break;
		    case false:
		        scribble("[fa_center][fa_middle]CHOOSE MODE").scale(4.50).draw(_x, GH/8);
				offset = 0;
				for (var i = 0; i < array_length(stageModes); ++i) {
					draw_sprite_ext(sUpgradeBackground, 0, _x, _y + offset, 1.495, 1.35, 0, c_black, .75);
					draw_sprite_ext(sUpgradeBackground, 2, _x, _y - 19 + offset, 1.47, 1, 0, c_white, .75);
					scribble($"[fa_center]{stageModes[i][$ "name"]}").scale(2.50).draw(_x, _y - 63 + offset);
					scribble($"[fa_center]{stageModes[i][$ "desc"]}").scale(2.50).wrap(180 * global.guiScale).draw(_x, _y - 33 + offset);
					var _sprW = sprite_get_width(sUpgradeBackgroundWH);
					var _sprH = sprite_get_height(sUpgradeBackgroundWH);
					DEBUG
						draw_rectangle(_x - _sprW, _y + offset - _sprH, _x + _sprW, _y + offset + _sprH, true);
					ENDDEBUG
					if (point_in_rectangle(MX, MY, _x - _sprW, _y + offset - _sprH, _x + _sprW, _y + offset + _sprH)) {
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
		        break;
		}
		break;
}
if (quithold > 10) {
    draw_healthbar(GW/2 - 30, GH/2 - 10, GW/2 + 30, GH/2 + 10, ((quithold / 100) * 100), c_black, c_aqua, c_aqua, 0, 1, 1);
}