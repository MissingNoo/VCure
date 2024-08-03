if (!place_meeting(x, y, oPlayerWorld)) {exit;}
var _combolen = string_length(string(combo));
comboval = 0;
if (_combolen == 2) {
	comboval = real(string_char_at(string(combo), 1));
	if (comboval > 7) { comboval = 7; }
}
if (_combolen > 2) {
	comboval = 7;
}
combo += -mouse_wheel_up() + mouse_wheel_down();
queueTime = clamp(queueTime, 60, 9999);
rod = global.equippedrod;
var canget = [];
for (var i = array_length(sprite) - 1; i >= 0; --i) {
    sprite[i][0] += (1/60 * sprite_get_speed(sprite[i][1])) * Delta;
	if (sprite[i][0] > sprite_get_number(sprite[i][1])) {
	    sprite[i][0] = 0;
		if (sprite[i][2] != undefined) {
		    sprite[i][2]();
		}
	}
}
if (!oPlayerWorld.fishing and !instance_exists(oFishPrize) and !showprize and input_check_pressed("accept")) {
	for (var i = 0; i < array_length(Fishes.data); ++i) {
	    if (Fishes.data[i].rod <= rod and !Fishes.data[i].golden) {
		    array_push(canget, Fishes.data[i]);
		}
	}
	prize = variable_clone(canget[irandom(array_length(canget) - 1)]);
	var shinyChance = clamp((rod == Rod.Golden ? 561 : 701) - (5 * combo), 21, 999);
	var shinyRoll = irandom(shinyChance);
	bonusYield = (combo div 10);
	difficultyUp = min(35, ((combo div 10) * 5));
	GetFishDifficulty(prize.name);
	if (shinyRoll == 1) {
		prize.name = $"Golden {prize.name}";
		prize.golden = true;
		bonusFish = 0;
		bonusYield = 0;
	}
	oCamWorld.zoom_level = 0.60;
	fishingend = false;
	hp = 65;
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
	repeat (200) {
	    array_push(keys,variable_clone(keydata[irandom(array_length(keydata) - 1)]));
		keys[array_length(keys) - 1].pos = _offset;
		_offset -= queueTime;
	}
	if (alarm[2] == -1) {
	    alarm[2] = (45 + bpm);
	}
}
if (caught) {
	bars[1] = 135;
	jx += 2;
	//hp = clamp(hp - 0.20, 0, 100);
	if (hp <= 0) {
		combo = 0;
		keys = [];
		prize = Fishes.data[0];
	}
	var _spd = clamp(bpm / (successAmount - comboval), 2, 7);
	//_spd = clamp(_spd + (_comboval / 2), 2, 7);
	//_spd += ;
    for (var i = array_length(keys) - 1; i >= 0; --i) {
		keys[i].pos += _spd * Delta;
		if (keys[i].pos > sprite_get_width(sRhythmBar)) {
			judgement = 0;
			jx = keys[i].pos - 22;
			jalpha = 1;
			hp -= failAmount;
		    array_delete(keys, i, 1);
		}
	}
	var lastpress = input_check_press_most_recent();
	if (lastpress != undefined and array_length(keys) > 0 and keys[0].pos > 130 and canpress) {
		canpress = false;
		alarm[3] = bpm / 1.5;
	    if (lastpress == keys[0].key) {
			if (keys[0].pos < 195) {
			    judgement = 2;
			}
			if (keys[0].pos < 160) { // 140
			    judgement = 1;
			}
			if (keys[0].pos > 195) {
			    judgement = 0;
			}
			jx = keys[0].pos;
			jalpha = 1;
			xx = keys[0].pos;
			scale = 1;
			alpha = 1;
			key = keys[0].spr;
			hp += successAmount * (queueTime / 70);
			array_shift(keys);
			if (hp > 100) {
			    keys = [];
				combo++;
			}
		}
		else {
			judgement = 0;
			jx = keys[0].pos;
			jalpha = 1;
			hp -= failAmount;
			array_shift(keys);
		}
	}
	if (array_length(keys) == 0) {
		bars[1] = 0;
		sprite[2][0] = 0;
		caught = false;
		splash = true;
		fishingend = true;
	}
}
if (!splash and splashed) {
	fishingend = true;
}
prizeoffset = lerp(prizeoffset, 70, 0.1);
bars[0] = lerp(bars[0], bars[1], 0.5);