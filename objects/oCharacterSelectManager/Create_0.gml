quithold = 0;
stagesurf = -1;
stageswiping = false;
swipestartoffset = 0;
swipeoffset = 0;
nextvar = [false, "", false];
stagelerp = [-GW/2.75, -GW/2.75, -GW/2.75];
nextvar = [false, "", false];
sidebarlerp = [-64, 0, -64];
characterlerp = [345, 0, 345];
stageselectlerp = [0, 0];
characteroffsetlerp = [101, 0, 101];
function nextVar(){
	if (!nextvar[0] and nextvar[1] != "") {
		nextvar[0] = true;
		variable_instance_set(self, nextvar[1], nextvar[2]);
	}
}
state = "base";
info = "";
infolevel = 1;
var _x = GW/4;
var _y = GH/2;
triangleR = [[_x + 160, _y - 50], [_x + 160, _y + 50], [_x + 160 + 25, _y]];
triangleL = [[_x - 160, _y - 50], [_x - 160, _y + 50], [_x - 160 - 25, _y]];
triangleSR = [[_x + 160, _y - 50], [_x + 160, _y + 50], [_x + 160 + 25, _y]];
triangleSL = [[_x - 160, _y - 50], [_x - 160, _y + 50], [_x - 160 - 25, _y]];
soundplayedby = -1;
menuClick = false;
#region Selection screen
characterSelected = false;
selectedCharacter = 0;
#region Character Sprite
characterSubImage = [0, 0, 0];
spriteChangeTimer = 3;
currentSprite = 0;
#endregion
#region Outfits
selectingOutfit = false;
selectedOutfit = 0;
global.selectedOutfit = 0;
maxOutfits = 0;
outfitSelected = false;
outfitIdleAnimation = [0, 0];
outfitIdleSpeed = 0;
selected=0;
maxselected = selected;
color=c_white;
#endregion
#region SideBar
sidebarOpen = false;
sidebarOpenByButton = false;
sidebar = [64, 320, 32, 32];
selectedAgency = "All";
selectedAgencyPos = 0;
resetSidebar = function(){
	sidebarOpen = false;
	sidebarOpenByButton = false;
	sidebar = [64, 320, 32, 32];
	selectedAgency = "All";
	selectedAgencyPos = 0;
}
agencies = global.agencies;
selectAgency = function(i){
	selectedCharacter = 0;
	selectedAgency = agencies[i][0];
	selectedAgencyPos = i;
	sidebar[3] = 32 + (60 * i);
	do {
		selectedCharacter += 1;
	} until (CHARACTERS[selectedCharacter][? "agency"] == selectedAgency or selectedAgency == "All");
	NAME=CHARACTERS[selectedCharacter][?"name"];
}
#endregion
#endregion
#region Stages
	stageSelected = false;
	stageModes = [
	{
		name : "STAGE MODE", 
		//desc : "Defeat the last boss to \ncomplete the stage!"
		desc : "Defeat the last boss to complete the stage!"
	},
	{
		name : "ENDLESS MODE", 
		//desc : "Survive for as long as \nyou can and reach the top \nof the leaderboards!"
		desc : "Survive for as long as you can and reach the top of the leaderboards!"
	},
	{
		name : "TIME MODE",
		desc : "Defeat 5000 targets as soon as possible! Shop upgrades are standardized"
		//desc : "Defeat 5000 targets as \nsoon as possible! \nShop upgrades are standardized"
	}];
	stages = StageData;
	selectedStage = 0;
#endregion
resetSidebar();
fandom_current_frame = [];
fandom_current_frame[0][0] = 0;
fandom_current_frame[0][1] = sprite_get_number(sFollowingFan);
fandom_current_frame[1][0] = 0;
fandom_current_frame[1][1] = sprite_get_number(sFollowingOshi);
fandom_current_frame[2][0] = 0;
fandom_current_frame[2][1] = sprite_get_number(sFollowingGachikoi);
fandom_frame_speed = sprite_get_speed(sFollowingFan);
fandom_frame_speed_type = sprite_get_speed_type(sFollowingFan);