HP = 0;
global.currentFrame = 0;
#region fps mean
numSeconds = 3;
stepsPassed = 0;
fpsAverage = 0;
movingSum = 0;
fpsArraySize = 60 * numSeconds;
fpsArray[fpsArraySize-1] = 0;
for(var i=0;i<fpsArraySize;i++){
    fpsArray[i] = 0;
}
#endregion
//show_debug_overlay(true);
if (os_type != os_android) {
    window_set_size(1280, 720);
}
#region Delta Time initialization
targetDelta = 1 / 60;
actualDelta = 0;
#endregion
#region Locals Initialization
canspawn=true;
#region lines
linespos = -100;
alarm[1] = 1;
linesoff = 0;
#endregion
depth=99;
gamePausedImageSpeed =0;
#region Screen Shake
shakeFx = layer_get_fx("ShakeLayer");
shakeMagnitude = 0;
shakeSpeed = 1;
#endregion
#endregion
#region Globals initialization
global.mouseDown = false;
global.gamePad = false;
global.arrowDir = 0;
global.defeatedEnemies = 0;
global.spawnEnemies = 1;
global.musicPlaying = undefined;
global.debug=false;
global.gamePaused=false;
global.strafe = false;
global.minutesPast30 = 0;
global.hoursPast1= 0 ;
global.arrowDir=0;
#region Multiplayer Globals
global.shareXP = false;
global.shareItems = false;
global.shareWeapons = false;
global.pauseGame = false;
global.shareAnvils = false;
global.shareStamps = false;
global.shareBoxDrops = false;
global.allowHalu = false;
global.allowGrank = false;
global.scaleMobs = false;
global.socket = 0;
global.singleplayer = false;
global.roomname="";
#endregion
#endregion
#region Unused
//if (!variable_global_exists("mode")) {
//	global.mode = "menu";
//}
global.gPnum = 0;
#endregion
#region Stages
enum StageTypes{
	Stage,
	Endless
}
#endregion
#region SaveLoad
var variables = ["musicVolume","soundVolume","damageNumbers","screenShake", "gamePad"];
for (var i = 0; i < array_length(variables); ++i) {
	if (!variable_global_exists(variables[i])) {
		variable_global_set(variables[i], 1);
	}
	if (!variable_global_exists(variables[i]) and variable_global_get(variables[i]) == undefined) {
		variable_global_set(variables[i], 1);
	}
}
#endregion
reset_pool();
reset_timer();
#region Lexicon Initialization
lexicon_index_declare_from_json("english.json");
lexicon_index_declare_from_json("ptbr.json");
ini_open("Settings");
var language = ini_read_string("Settings", "Language", "English");
ini_close();
lexicon_language_set("English");
#endregion
