//event_inherited();
//draw_text(x, y - 30, global.updatenow);
//if (instance_exists(global.updatenow)) {
//    draw_line(x, y, global.updatenow.x, global.updatenow.y);
//}

draw_sprite_ext(sCharShadow, 0, x, y, 1, 1, 0, c_white, 0.8);
DEBUG
    draw_circle(x, y, pickupRadius, true);
ENDDEBUG
draw_self();
#region Have perk
for (var i = 0; i < array_length(PLAYER_PERKS); ++i) {
	if (PLAYER_PERKS[i].level > 0 and variable_struct_exists(PLAYER_PERKS[i], "draw")) {
	    PLAYER_PERKS[i][$ "draw"]({perk : PLAYER_PERKS[i]});
	}
}
#endregion
#region Specials
#region Anya
if (bladeForm) {
	var _alpha = 0.25;
    for (var i = 0; i < array_length(bladeFormAfterImages); ++i) {
	    draw_sprite_ext(sprite_index, 0, x, y, image_xscale, image_yscale, bladeFormAfterImages[i], c_yellow, _alpha);
		_alpha+=0.25;
	}
}
#endregion
#endregion
if (HP > 0 and HP < MAXHP) {
    draw_healthbar((x - 13), ((y - characterHeight) - 3), (x + 13), ((y - characterHeight) - 6), ((HP / MAXHP) * 100), c_red, c_lime, c_lime, 0, 1, 0);
}
if (Shield > 0 and HP > 0) {
    draw_healthbar((x - 13), ((y - 19) - 20), (x + 13), ((y - 19) - 23), ((Shield / MaxShield) * 100), c_red, c_blue, c_blue, 0, 1, 0);
}
var strafing = global.strafe ? 1 : 0;
var _color = c_white;
if (mouseAim) {
    _color = c_purple;
	draw_sprite_ext(sMouseAim, 0, mouse_x, mouse_y, 1, 1, 0, c_white, 1);
}
draw_sprite_ext(sArrow,strafing,x,y-16,1,1,global.arrowDir, _color, 1);