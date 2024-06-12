/*
debug_add_config("Button", DebugTypes.Button, undefined, undefined, function(){show_message("Button")});
debug_add_config("ButtonSameLine", DebugTypes.Button, undefined, undefined, function(){show_message("ButtonSameLine")});
same_line();
debug_add_config("Button3", DebugTypes.Button, undefined, undefined, function(){show_message("Button")});
debug_add_config("Checkbox", DebugTypes.Checkbox, self, "BoolVar");
*/


//Feather disable all
if (!show) { exit; }
draw_set_alpha(.50);
if (hold_on_area([x, y, x + 300, y + 45])) {
    x = MX - 150;
	y = MY - 15;
}
depth = -1000;
draw_sprite_stretched(sprite_index, 0, x, y, maxwidth, minimized ? 50 : maxsize);
draw_text(x + 10, y + 10, pagenames[page]);
draw_text(x + 10, y - 30, pagenames);
debug_text_button(x + maxwidth - 45, y + 11, " - ", function(){ minimized = !minimized; });

yy = y + 50;
if (minimized) { yy = 9999; }
button_updown(x + 10, yy, "step", "step", .01);
xx = x + 10;
for (var i = 0; i < array_length(variables); ++i) {
	if (variables[i].page != page) {
	    continue;
	}
	if (variable_struct_exists(variables[i], "sameLine")) {
	    yy -= yyStep[variables[i].type];
		var _xoff = 0;
		switch (variables[i-1].type) {
		    case DebugTypes.Button:
		        _xoff = 1;
		        break;
		    case DebugTypes.Checkbox:
		        _xoff = 1.45;
		        break;
		    case DebugTypes.UpDown:
		        _xoff = 1.50;
		        break;
		}
		xx += (string_width(variables[i-1].text) * _xoff ) + 8;
		if (maxwidth - 10 < xx - x ) {
		    maxwidth = xx - x + string_width(variables[i].text) + 16;
		}
	}
	else { xx = x + 10; }
	if (maxwidth < xx + string_width(variables[i].text) + 16) {
		maxwidth = xx + string_width(variables[i].text) + 16;
	}
	switch (variables[i].type) {
	    case DebugTypes.UpDown:
	        button_updown(xx, yy, variables[i].text, variables[i].variable, step, variables[i].instance);
	        break;
	    case DebugTypes.Checkbox:
	        debug_checkbox(xx, yy, variables[i].variable, variables[i].text, variables[i].instance);
	        break;
	    case DebugTypes.Button:
			debug_text_button(xx, yy, variables[i].text, variables[i].func);
	        break;
	    default:
	        // code here
	        break;
	}
}
maxsize = yy - y + 10;
draw_set_alpha(1);