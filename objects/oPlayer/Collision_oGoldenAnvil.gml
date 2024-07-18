other.alarm[0] = 30;
if (!other.used) {
	other.y += 15;
	other.used = true;
	other.maxuses -= 1;
	GoldenANVIL = true;
	audio_play_sound(snd_anvil,0,0, global.soundVolume);
	pause_game();
}
