mouseDown = false;
ups = variable_struct_get_names(global.shopUpgrades);
array_sort(ups, true);
isFirstItem = false;
selectingTab = true;
selectedTab = GlobalShopTabs.Enhancements;
enum GlobalShopTabs {
	Enhancements,
	Stats,
	Others
}
selected = -1;
nextItem = function(){
	for (var i = selected + 1; i < array_length(ups); ++i) {
		if (global.shopUpgrades[$ ups[i]].tab == selectedTab) {
			selected = i;
			break;
		}
	}
}
lastItem = function(){
	for (var i = selected - 1; i >= -1; --i) {
		if (i == -1) {
		    isFirstItem = true;
			break;
		}
		if (global.shopUpgrades[$ ups[i]].tab == selectedTab) {
			selected = i;
			break;
		}
	}
}
interacting = false;
interactOption = 0;





/// @description Insert description here
//guiClick = function (_x, _y, spr, xscale, yscale){
//	var result = false;
//	var _w = (sprite_get_width(spr) * xscale) / 2;
//	var _h = (sprite_get_height(spr) * yscale) / 2;
//	if (point_in_rectangle(oGui.x, oGui.y, _x - _w, _y - _h, _x + _w, _y + _h)){
//		result = true;
//		oGui.x = 0;
//		oGui.y = 0;
//	}
//	return result;
//}
//holocoinsubimage = 0;
depth = oGui.depth + 1;
//selected = 0;
//interact = false;
//interactSelected = 0;
//selectedThing = pointer_null;

//menuOptions  = ["Character Gacha", "Buy Upgrades", "Armory", "Quit"];
//optionSelected = 0;

//enum PrizeType {
//	Character
//}

//gachaInteract = false;
//gachaInteractButtons = ["Buy", "Redeem"];
//gachaDebut = false;
//gachaPrize = false;
//isOutfit = false;
//outfitPrizeNumber = 0;
//gotPrize = {};
//prizeIdleAnimation = [0, 0];
//prizeIdleSpeed = 0;
//gachaButton = 0;
//selectedGacha = 0;
//gachas = [
//	{
//		name : "MYTH",
//		sprite : sGachaMyth,
//		cost : 1000,
//		prizes : [
//			{
//				type : PrizeType.Character,
//				character : Characters.Uruka
//			},
//		]
//	}
//];