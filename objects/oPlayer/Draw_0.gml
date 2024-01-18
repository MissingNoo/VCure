//event_inherited();
draw_sprite_ext(sCharShadow, 0, x, y, 1, 1, 0, c_white, 0.8);

#region Have perk
var lickArea = 0;
for (var i = 0; i < array_length(PLAYER_PERKS); ++i) {
	if (PLAYER_PERKS[i].level > 0) {
	    switch (PLAYER_PERKS[i].id) {
		    case PerkIds.Lick:
		        lickArea = PLAYER_PERKS[i].lickArea;
		        break;
		}
	}
}
#endregion
DEBUG
	draw_text(x,y-90, $"healSeconds: {bandageHealSeconds}, haveBandage: {haveBandage}, remaining: {justBandageHealing}");
	draw_text(x,y-70, $"d: {spd * Delta}");
	draw_text(x,y-50, $"X: {x}");
	draw_text(x,y-30, $"Y: {y}");
	draw_text(x,y-100, "Enemy Count: " + string(instance_number(oEnemy)));
	draw_text(x,y-120, "FPS: " + string(oGame.fpsAverage));
	draw_text(x,y-140, "FPSR: " + string(fps_real));
	//draw_text(x,y-160, "Bonus: " + string(Bonuses[BonusType.Critical][ItemIds.MoldySoulBonus]));	
	draw_circle(x,y-16,pickupRadius,true);
ENDDEBUG
draw_self();
if (HP > 0 and HP != MAXHP) {
    draw_healthbar((x - 13), ((y - 16) - 20), (x + 13), ((y - 16) - 23), ((HP / MAXHP) * 100), c_red, c_lime, c_lime, 0, 1, 0);
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
#region Lia
switch (global.player[?"id"]) {
    case Characters.Lia:
        if (lickArea > 0) {
			var _y = y - (sprite_get_height(sprite_index) / 3);
		    draw_circle_color(x, _y, lickArea, c_white, c_white, true);
		}
        break;
    default:
        // code here
        break;
}
#endregion