can_collab(); // TODO: move to when get weapon
if (!instance_exists(oSlave)) {
    oCam.x += (oPlayer.x - oCam.x) / 16;
	oCam.y += (oPlayer.y - oCam.y) / 16;
}