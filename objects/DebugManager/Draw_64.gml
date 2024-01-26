//Feather disable all
if (!show) { exit; }
if (hold_on_area([x, y, x + 300, y + 45])) {
    x = MX - 150;
	y = MY - 15;
}
depth = -1000;
screenarea = [x, y, x + 300, minimized ? y + 50 : y + maxsize]
draw_sprite_stretched(sprite_index, 0, x, y, 300, minimized ? 50 : maxsize);
if (debug_text_button(x + 257, y + 11, " - ")) { minimized = !minimized; }
yy = y + 50;
if (minimized) { yy = 9999; }
button_updown(x + 10, yy, "step", "step", .01);
for (var i = 0; i < array_length(variables); ++i) {
	switch (variables[i].type) {
	    case DebugTypes.UpDown:
	        button_updown(x + 10, yy, variables[i].text, variables[i].variable, step, variables[i].instance);
	        break;
	    case DebugTypes.Checkbox:
	        debug_checkbox(x + 10, yy, variables[i].variable, variables[i].text, variables[i].instance);
	        break;
	    case DebugTypes.Button:
			debug_text_button(x + 10, yy, variables[i].text, variables[i].func);
	        break;
	    default:
	        // code here
	        break;
	}    
}
if (instance_exists(oPlayer) and debug_checkbox(x + 10, yy, "immortal", "immortal")) {
    HP = MAXHP;
}
maxsize = yy - y + 10;