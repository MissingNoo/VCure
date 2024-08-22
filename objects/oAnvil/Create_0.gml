/// @instancevar {Any} dontsend
onScreenArrow = sAnvilPointer;
offScreenArrow = sAnvilPointer;
used = false;
upgradeconfirm = false;
anvilSelected = 0;
anvilSelectedCategory = 0;
anvilconfirm = false;
upgradeCoinValue = 0;
if (!dontsend) {
	maxuses = 1;
    anvilid = irandom(9999);
	for (var i = 0; i < array_length(playerItems); ++i) {
	    if (playerItems[i][$ "id"] == ItemIds.BlacksmithsGear) {
		    maxuses = 2;
		}
	}
}
maxuses = 1;
if (array_find_index(playerItems, function(element, index) {
	return element.id == ItemIds.BlacksmithsGear;
}) != -1) {
	maxuses = 2;
}
show_message($"uses:{maxuses}");
audio_play_sound(snd_anvildrop,0,0, global.soundVolume);
if (global.shareAnvils and !dontsend) {
	sendMessage(0, {
		command : Network.SpawnAnvil,
		x, y, 
		anvilid,
		maxuses
	});
}
