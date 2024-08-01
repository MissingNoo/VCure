bonusfish = 0;
bars = [0, 0];
prize = 0;
splash = false;
splashed = false;
fishingend = false;
combo = 0;
rod = global.equippedrod;
arrowspeed = 1;
pos = [0, 0];
sprite = [
	[0, sFishingBop, undefined],
	[0, sFishIcon, undefined],
	[0, sFishSplash, function(){
		if (oPlayerWorld.fishing and fishingend) {
			oPlayerWorld.fishing = false;
			splash = false; 
			splashed = true; 
			oCamWorld.zoom_level = 1; 
			for (var i = 0; i < array_length(Fishes.data); ++i) {
			    if (Fishes.data[i].name == prize.name) {
				    Fishes.data[i].amount += 1 + bonusfish;
				}
			}
			instance_create_depth(0, 0, depth, oFishPrize, {prize : prize});
		}}]
];
caught = false;
rhythmsurf = surface_create(sprite_get_width(sRhythmBar) + 100, sprite_get_height(sRhythmBar) + 20);
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
hp = 50;
judgement = 0;
judgepos = 0;
jx = 0;
jalpha = 1;
prizeoffset = 0;
showprize = false;