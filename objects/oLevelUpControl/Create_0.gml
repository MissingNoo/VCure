if (global.level >= 50 and !Achievements[AchievementIds.DeckedOut].unlocked) {
    instance_create_layer(0, 0, "Instances", oAchNotify, {ach : AchievementIds.DeckedOut})
}
global.xp -= oPlayer.neededxp;
oPlayer.neededxp += round((4*(global.level + 1)) *2.1) - round((4*global.level)*2.1);
audio_play_sound(snd_lvl_up,0,0, global.soundVolume);
global.upgrade = true;
upglines = [];
holoarrowspr=0;
upgradeconfirm = false;
heldpos = -1;
helding = false;
selected = 0;
random_upgrades();