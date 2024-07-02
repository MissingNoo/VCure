
event_inherited();
if (ANVIL) {
		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);
		var _x = GW/1.56;
		var _y = GH/5.30;
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
			if (!anvilconfirm and oGui.buttonClick([GW/2.30 - _sprHalf + xoffset, GH/3 - _sprHalf, GW/2.30 + _sprHalf + xoffset, GH/3 + _sprHalf], true)) {
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
			if (!anvilconfirm and oGui.buttonClick([GW/2.30 - _sprHalf + xoffset, GH/2.30 - _sprHalf, GW/2.30 + _sprHalf + xoffset, GH/2.30 + _sprHalf], true)) {
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
		var str;
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
		oGui.drawStats();
		draw_set_valign(fa_top);
		draw_set_halign(fa_left);
	}
	