//grid = ds_grid_create(10, 10);
//ds_grid_clear(grid, -1);
//ds_grid_destroy(grid);
//ds_grid_clear(grid, -1);
comboval = 0;
canpress = true;
queueTime = 1;
currentDifficulty = 1;
fishSize = 0;
minFish = 0;
fishSize = 1;
fishDepleteRate = 10;
alarm[2] = fishDepleteRate;
failAmount = 0;
successAmount = 0;
bonusYield = 0;
#region Function
function GetFishDifficulty(name) {
	roll = irandom(99);
	switch (string_lower(string_replace_all(name, " ", ""))){
        case "shrimp":
            fishSize = 1;
			if ((roll > 40)) {
                minFish = 1;
                bonusFish = 1;
                SetDifficulty(0);
            }
            else {
                minFish = 2;
                bonusFish = 4;
                SetDifficulty(1);
            }
            break;
        case "clownfish":
            fishSize = 1;
            if ((roll > 30)) {
                minFish = 1;
                bonusFish = 2;
                SetDifficulty(0);
            }
            else {
                minFish = 2;
                bonusFish = 3;
                SetDifficulty(1);
            }
            break;
        case "tuna":
            fishSize = 1.2;
            if ((roll > 20)) {
                minFish = 1;
                bonusFish = 1;
                SetDifficulty(1);
            }
            else {
                minFish = 2;
                bonusFish = 3;
                SetDifficulty(2);
            }
            break;
        case "koifish":
            fishSize = 1.2;
            if ((roll > 20)) {
                minFish = 1;
                bonusFish = 1;
                SetDifficulty(2);
            }
            else {
                minFish = 2;
                bonusFish = 3;
                SetDifficulty(3);
            }
            break;
        case "lobster":
            fishSize = 1.4;
            if ((roll > 20)) {
                minFish = 1;
                bonusFish = 1;
                SetDifficulty(2);
            }
            else {
                minFish = 2;
                bonusFish = 2;
                SetDifficulty(3);
            }
            break;
        case "eel":
            fishSize = 1.5;
            if ((roll > 20)) {
                minFish = 1;
                bonusFish = 1;
                SetDifficulty(2);
            }
            else {
                minFish = 2;
                bonusFish = 1;
                SetDifficulty(3);
            }
            break;
        case "pufferfish":
            fishSize = 1.75;
            if ((roll > 20)) {
                minFish = 1;
                bonusFish = 1;
                SetDifficulty(2);
            }
            else {
                minFish = 2;
                bonusFish = 1;
                SetDifficulty(3);
            }
            break;
        case "mantaray":
            fishSize = 2;
            if ((roll > 20)) {
                minFish = 1;
                bonusFish = 1;
                SetDifficulty(3);
            }
            else {
                minFish = 2;
                bonusFish = 1;
                SetDifficulty(4);
            }
            break;
        case "turtle":
            fishSize = 2;
            if ((roll > 20)) {
                minFish = 1;
                bonusFish = 1;
                SetDifficulty(3);
            }
            else {
                minFish = 2;
                bonusFish = 1;
                SetDifficulty(4);
            }
            break;
        case "squid":
            fishSize = 2.5;
            if ((roll > 20)) {
                minFish = 1;
                bonusFish = 1;
                SetDifficulty(3);
            }
            else {
                minFish = 2;
                bonusFish = 1;
                SetDifficulty(4);
            }
            break;
        case "shark":
            fishSize = 3;
            if ((roll > 20)) {
                minFish = 1;
                bonusFish = 2;
                SetDifficulty(4);
            }
            else {
                minFish = 2;
                bonusFish = 1;
                SetDifficulty(5);
            }
            break;
        case "axolotl":
            fishSize = 3;
            if ((roll > 20)) {
                minFish = 1;
                bonusFish = 1;
                SetDifficulty(5);
            }
            else {
                minFish = 2;
                bonusFish = 1;
                SetDifficulty(5);
            }
            break;
    }
}
function SetDifficulty(int) {
    currentDifficulty = int;
    switch (int) {
        case 0:
            var proficiency = global.equippedrod * 0.2;
            bpm = (45 - min(5, (difficultyUp / 5)));
            queueTime = max(35, (90 - difficultyUp));
            fishDepleteRate = 10;
            failAmount = max(5, (10 * (1 - proficiency)));
            successAmount = (15 * (1 + proficiency));
            break;
        case 1:
            proficiency = global.equippedrod * 0.2;
            bpm = (30 - min(5, (difficultyUp / 5)));
            queueTime = max(35, (90 - difficultyUp));
            fishDepleteRate = 10;
            failAmount = max(5, (15 * (1 - proficiency)));
            successAmount = (15 * (1 + proficiency));
            break;
        case 2:
            proficiency = (global.equippedrod - 1) * 0.2;
            bpm = (30 - min(5, (difficultyUp / 5)));
            queueTime = max(35, (80 - difficultyUp));
            fishDepleteRate = 7;
            failAmount = max(5, (20 * (1 - proficiency)));
            successAmount = (10 * (1 + proficiency));
            break
        case 3:
            proficiency = (global.equippedrod - 2) * 0.2;
            bpm = (25 - min(5, (difficultyUp / 5)));
            queueTime = max(35, (80 - difficultyUp));
            fishDepleteRate = 5;
            failAmount = max(5, (25 * (1 - proficiency)));
            successAmount = (10 * (1 + proficiency));
            break;
        case 4:
            proficiency = (global.equippedrod - 3) * 0.2;
            bpm = (25 - min(5, (difficultyUp / 5)));
            queueTime = max(35, (75 - difficultyUp));
            fishDepleteRate = 3;
            failAmount = max(5, (25 * (1 - proficiency)));
            successAmount = (10 * (1 + proficiency));
            break;
        case 5:
            proficiency = (global.equippedrod - 4) * 0.2;
            bpm = (25 - min(5, (difficultyUp / 5)));
            queueTime = max(35, (70 - difficultyUp));
            fishDepleteRate = 3;
            failAmount = max(5, (30 * (1 - proficiency)));
            successAmount = (10 * (1 + proficiency));
            break;
    }
}
#endregion
bpm = 35;
difficultyUp = 0;
bonusFish = 0;
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
			var prizeamount = minFish + irandom(bonusFish) + bonusYield;
			for (var i = 0; i < array_length(Fishes.data); ++i) {
			    if (Fishes.data[i].name == prize.name) {
				    Fishes.data[i].amount += prize.golden ? 1 : prizeamount;
				}
			}
			instance_create_depth(0, 0, depth, oFishPrize, {prize : prize, amount : prizeamount});
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