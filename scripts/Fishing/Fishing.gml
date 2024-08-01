enum Rod {
	Beginner,
	DadRod,
	Blacksmith
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
Fishes.addFish("Tuna", sFishShrimpIcon, sFishShrimp, 150, Rod.Beginner, true);
Fishes.addFish("Koi Fish", sClownFishIcon, sClownFish, 200, Rod.DadRod, true);
Fishes.addFish("Lobster", sClownFishIcon, sClownFish, 250, Rod.DadRod, true);
Fishes.addFish("Eel", sClownFishIcon, sClownFish, 300, Rod.DadRod, true);
Fishes.addFish("Pufferfish", sClownFishIcon, sClownFish, 350, Rod.Beginner, true);//TODO: varas
Fishes.addFish("Manta Ray", sClownFishIcon, sClownFish, 400, Rod.Beginner, true);
Fishes.addFish("Turtle", sClownFishIcon, sClownFish, 450, Rod.Beginner, true);
Fishes.addFish("Squid", sClownFishIcon, sClownFish, 500, Rod.Beginner, true);
Fishes.addFish("Shark", sClownFishIcon, sClownFish, 750, Rod.Beginner, true);
Fishes.addFish("Axolotl", sClownFishIcon, sClownFish, 2000, Rod.Beginner, true);