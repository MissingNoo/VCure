/// @instancevar {Any} dontsend
/// @instancevar {Any} dbg_view_exists
/// @instancevar dbg_view
/// @instancevar dbg_section
/// @instancevar {Any} dbg_text_input
/// @instancevar {Any} ref_create
/// @instancevar {Any} dbg_checkbox    
/// @instancevar {Any} dbg_view_delete 
anvilid = irandom(9999);
inspector = -1;
if (!dbg_view_exists(inspector)) {
	inspector = dbg_view($"Anvil:{anvilid}", false);
	dbg_section("Vars");
	dbg_text_input(ref_create(self.id, "maxuses"), "MaxUses:", "r");
	//dbg_checkbox(ref_create(self.top, "top"), "Top:");
}
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
