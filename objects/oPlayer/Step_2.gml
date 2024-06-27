if (!instance_exists(oSlave) and !global.gamePaused) {
    //oCam.x += (oPlayer.x - oCam.x) / 16;
	//oCam.y += (oPlayer.y - oCam.y) / 16;
    oCam.x = round(oPlayer.x);
	oCam.y = round(oPlayer.y);
}