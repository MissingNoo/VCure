splash = false;
splashed = false;
fishingend = false;
combo = 0;
rod = Rods.Beginner;
arrowspeed = 1;
pos = [0, 0];
sprite = [
	[0, sFishingBop, undefined],
	[0, sFishIcon, undefined],
	[0, sFishSplash, function(){if (oPlayerWorld.fishing and fishingend) {oPlayerWorld.fishing = false; splash = false; splashed = true;}}]
];
caught = false;
rhythmsurf = surface_create(sprite_get_width(sRhythmBar), sprite_get_height(sRhythmBar));
keydata = [
	{spr : 0, key : "up" , pos : 0},
	{spr : 1, key : "down" , pos : 0},
	{spr : 2, key : "left" , pos : 0},
	{spr : 3, key : "right" , pos : 0},
	{spr : 4, key : "accept" , pos : 0},
];
keys = [];
scale = 1;
alpha = 0;
xx = 0;
key = 0;