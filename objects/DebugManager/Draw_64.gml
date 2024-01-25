//Feather disable all
draw_set_alpha(1);
depth = -1000;
if (!show) { exit; }
if (hold_on_area([x, y, x + 300, y + 45])) {
    x = floor(MX - 150);
	y = floor(MY - 15);
}
screenarea = [x, y, x + 300, minimized ? y + 50 : y + maxsize]
draw_sprite_stretched(sprite_index, 0, x, y, 300, minimized ? 50 : maxsize);
if (debug_text_button(x + 257, y + 11, " - ")) { minimized = !minimized; }
yy = y + 50;
if (minimized) { yy = 9999; }
button_updown(x + 10, yy, $"step: {step}", "step", .01);
var vars = ["a", "b", "c", "d", "e", "f"];
for (var i = 0; i < array_length(vars); ++i) {
    button_updown(x + 10, yy, $"{vars[i]}: {variable_instance_get(self, vars[i])}", vars[i], step);
}
if (instance_exists(oPlayer) and debug_checkbox(x + 10, yy, "immortal", "immortal")) {
    HP = MAXHP;
}
if (debug_text_button(x + 10, yy, "box")) {
    PrizeBox = !PrizeBox;
}
if (debug_text_button(x + 10, yy, "reset box")) {
	oGui.boxaccept = false;
    oGui.boxoffset = 700;
	oGui.chestspr = 0;	
}
maxsize = minimized ? y + 50 : yy - y + 10;