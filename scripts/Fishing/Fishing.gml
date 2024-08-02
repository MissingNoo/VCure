enum Rod {
	Beginner,
	DadRod,
	Blacksmith,
	Atlantean,
	Turkey,
	Golden
}
global.roddata = [];
#macro Rods global.roddata
Rods[Rod.Beginner] = {
	name : "Beginner's Rod",
	sprite : sBeginnersRod,
	icon : sBeginnersRod,
	cost : 0,
	owned : true
};
Rods[Rod.DadRod] = {
	name : "Dad's Rod",
	sprite : sDadRod,
	icon : sDadRod,
	cost : 5000,
	owned : false
};
Rods[Rod.Blacksmith] = {
	name : "Blacksmith-Made Rod",
	sprite : sBlacksmithRod,
	icon : sBlacksmithRod,
	cost : 15000,
	owned : false
};
Rods[Rod.Atlantean] = {
	name : "Atlantean Rod",
	sprite : sAtlanticRod,
	icon : sAtlanticRod,
	cost : 50000,
	owned : false
};
Rods[Rod.Turkey] = {
	name : "Turkey Rod",
	sprite : sTurkeyRod,
	icon : sTurkeyRod,
	cost : 250000,
	owned : false
};
Rods[Rod.Golden] = {
	name : "Golden Rod",
	sprite : sGoldenRod,
	icon : sGoldenRod,
	cost : 1000000,
	owned : false
};
function FishData() constructor {
	data = [];
	static addFish = function(name, icon, sprite, cost, rod, golden = false) {
        array_push(data, {name, icon, sprite, cost, rod, amount : 0, golden});
    }
}
global.fishes = new FishData();
#macro Fishes global.fishes
Fishes.addFish("Nothing", sBlank, sBlank, 0, 999);
Fishes.addFish("Shrimp", sFishShrimpIcon, sFishShrimp, 50, Rod.Beginner);
Fishes.addFish("Clownfish", sClownFishIcon, sClownFish, 100, Rod.Beginner);
Fishes.addFish("Tuna", sTunaIcon, sTuna, 150, Rod.Beginner);
Fishes.addFish("Koi Fish", sKoiIcon, sKoi, 200, Rod.DadRod);
Fishes.addFish("Lobster", sLobsterIcon, sLobster, 250, Rod.DadRod);
Fishes.addFish("Eel", sEelIcon, sEel, 300, Rod.DadRod);
Fishes.addFish("Pufferfish", sPufferFishIcon, sPufferFish, 350, Rod.Blacksmith);
Fishes.addFish("Manta Ray", sMantaRayIcon, sMantaRay, 400, Rod.Blacksmith);
Fishes.addFish("Turtle", sTurtleIcon, sTurtle, 450, Rod.Atlantean);
Fishes.addFish("Squid", sSquidIcon, sSquid, 500, Rod.Atlantean);
Fishes.addFish("Shark", sSharkIcon, sShark, 750, Rod.Turkey);
Fishes.addFish("Axolotl", sAxolotlIcon, sAxolotl, 2000, Rod.Turkey);