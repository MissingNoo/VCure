/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if (GoldenANVIL) {
		var _x = GW/2;
		var _y = GH/2;
		var _down = 150;
		var _distance = 90;
		var _offset = 0;
		var _sprHalf = (sprite_get_width(sItemSquare) * 2 ) / 2;
		for (var i = 1; i < array_length(UPGRADES); ++i) {
			var _isSelected = (anvilSelected == i) ? true : false;
		    draw_sprite_ext(sItemSquare, _isSelected, _x + _offset, _y, 2, 2, 0, c_white, 1);
			var _alpha = (gAnvilWeapon1 == UPGRADES[i] or gAnvilWeapon2 == UPGRADES[i]) ? 0.5 : 1;
		    draw_sprite_ext(UPGRADES[i][$ "thumb"], 0, _x + _offset, _y, 2, 2, 0, c_white, _alpha);
			if (oGui.buttonClick([_x - _sprHalf + _offset, _y - _sprHalf, _x + _sprHalf + _offset, _y + _sprHalf], true)) {
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
				if (oGui.buttonClick([_x - _sprHalf + _offset - _distance, _y - _sprHalf + _down, _x + _sprHalf + _offset - _distance, _y + _sprHalf + _down], true)) {
					gAnvilWeapon1 = global.null;
				}
				
				draw_sprite_ext(sItemSquare, 0, _x + _offset + _distance, _y + _down, 2, 2, 0, c_white, 1);
				draw_sprite_ext(gAnvilWeapon2[$ "thumb"], 0, _x + _offset + _distance, _y + _down, 2, 2, 0, c_white, 1);
				if (oGui.buttonClick([_x - _sprHalf + _offset + _distance, _y - _sprHalf + _down, _x + _sprHalf + _offset + _distance, _y + _sprHalf + _down], true)) {
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