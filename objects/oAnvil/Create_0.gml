onScreenArrow = sAnvilPointer;
offScreenArrow = sAnvilPointer;
used = false;
upgradeconfirm = false;
anvilSelected = 0;
anvilSelectedCategory = 0;
gAnvilWeapon1 = global.null;
gAnvilWeapon2 = global.null;
gAnvilWeapon1Position = 0;
gAnvilWeapon2Position = 0;
canCollab = false;
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
audio_play_sound(snd_anvildrop,0,0);
if (global.shareAnvils and !dontsend) {
	sendMessage({
		command : Network.SpawnAnvil,
		x, y, 
		anvilid,
		maxuses
	});
}
