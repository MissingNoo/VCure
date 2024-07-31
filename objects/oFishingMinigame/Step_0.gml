if (!place_meeting(x, y, oPlayerWorld)) {exit;}
for (var i = array_length(sprite) - 1; i >= 0; --i) {
    sprite[i][0] += (1/60 * sprite_get_speed(sprite[i][1])) * Delta;
	if (sprite[i][0] > sprite_get_number(sprite[i][1])) {
	    sprite[i][0] = 0;
		if (sprite[i][2] != undefined) {
		    sprite[i][2]();
		}
	}
}
if (!oPlayerWorld.fishing and input_check_pressed("accept")) {
	fishingend = false;
	splashed = false;
	splash = false;
    oPlayerWorld.fishing = true;
	if (oPlayerWorld.x > x) {
	    oPlayerWorld.image_xscale = -1;
	}
	else {
		oPlayerWorld.image_xscale = 1;
	}
	pos[0] = oPlayerWorld.x + (sprite_get_width(sFishingRod)  * oPlayerWorld.image_xscale) + irandom_range(-10, 10);
	pos[1] = oPlayerWorld.y + irandom_range(-5, 5);
	sprite[0][0] = 0;
	alarm[0] = irandom_range(20, 100);
	keys = [];
	var _offset = 0;
	repeat (7) {
	    array_push(keys,variable_clone(keydata[irandom(array_length(keydata) - 1)]));
		keys[array_length(keys) - 1].pos = _offset;
		_offset -= 80;
	}
}
if (caught) {
    for (var i = array_length(keys) - 1; i >= 0; --i) {
		keys[i].pos += 2;
		if (keys[i].pos > sprite_get_width(sRhythmBar)) {
		    array_delete(keys, i, 1);
		}
	}
	var lastpress = input_check_press_most_recent();
	if (lastpress != undefined and array_length(keys) > 0 and keys[0].pos > 140) {
	    if (lastpress == keys[0].key) {
			xx = keys[0].pos;
			scale = 1;
			alpha = 1;
			key = keys[0].spr;
			array_shift(keys);
		}
	}
	if (array_length(keys) == 0) {
		caught = false;
		splash = true;
		fishingend = true;
	}
}
if (!splash and splashed) {
	fishingend = true;
	surface_set_target(rhythmsurf);
	draw_clear_alpha(c_black, 0);
	surface_reset_target();
}