// Feather disable GM2016
if (ANVIL) { exit; }
var possible_upgrade = true;
other.alarm[0] = 30;
if (!other.used and possible_upgrade) {
	other.y += 15;
	other.used = true;
	if (global.shareAnvils) {
	    sendMessage(0, {
			command : Network.UpdateAnvil,
			anvilid : other.anvilid,
			maxuses : other.maxuses
		});
	}
	oPlayer.lastanvil = other.id;
	ANVIL = true;
	audio_play_sound(snd_anvil,0,0, global.soundVolume);
	pause_game();
}
