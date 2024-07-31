enum Rods {
	Beginner
}
function FishData() constructor {
	data = [];
	static addFish = function(name, icon, sprite, value, rod, golden = false) {
        array_push(data, {name, icon, sprite, value, rod, amount : 0, golden});
    }
}
global.fishes = new FishData() ;
#macro Fishes global.fishes
Fishes.addFish("Nothing", sBlank, sBlank, 0, 999);
Fishes.addFish("Shrimp", sFishShrimpIcon, sFishShrimp, 50, Rods.Beginner);
Fishes.addFish("Clownfish", sClownFishIcon, sClownFish, 100, Rods.Beginner);
Fishes.addFish("Golden Shrimp", sFishShrimpIcon, sFishShrimp, 50, Rods.Beginner, true);
Fishes.addFish("Golden Clownfish", sClownFishIcon, sClownFish, 100, Rods.Beginner, true);