if (!instance_exists(oSlave) and !global.gamePaused) {
    //oCam.x += (oPlayer.x - oCam.x) / 16;
	//oCam.y += (oPlayer.y - oCam.y) / 16;
    //oCam.x = round(oPlayer.x);
	//oCam.y = round(oPlayer.y);
}
var _offset = 0;
if (instance_exists(oCamWorld)) {
    oCamWorld.x += (oPlayer.x - oCamWorld.x) / 16;
    oCamWorld.y += ((oPlayer.y - _offset) - oCamWorld.y) / 16;
}
sendpostimer = clamp(sendpostimer - 1, 0, 60);
if(!global.singleplayer and sendpostimer == 0) {
    sendpostimer = 6;
    sendMessageNew(Network.MovePlayer, {x, y});
}