infoOffset[0] = lerp(infoOffset[0], infoOffset[1], 0.25);
if (keyboard_check_pressed(vk_f4)) {
	showinfo = !showinfo;
	if (showinfo) {
		infoOffset[1] = 0;
	}
	else {
		infoOffset[1] = GH/2 + 200;
	}
}
if (!global.singleplayer and time_source_exists(keepalive)) {
	var _timestate = time_source_get_state(keepalive);
	if(_timestate == time_source_state_initial or _timestate == time_source_state_stopped){
		time_source_start(keepalive);
	}
}

if (!instance_exists(oPlayer) and room == rStage1) {
	instance_create_layer(playerSpawn[0], playerSpawn[1], "Instances", oPlayer, {socket : oClient.connected});
}
if (!instance_exists(oSlave) and room == rStage1) {
	instance_create_layer(playerSpawn[0], playerSpawn[1], "Instances", oSlave, {socket : oClient.connected});
}
if (!instance_exists(oLobby) and room == rLobby) {
	instance_create_depth(0, 0, 0, oLobby);
}
/*
if (inRoom != room and room == rStage1) {
	inRoom = room;
	sendMessage(0, {command : Network.PlayerConnect});	
	//show_message("test");
	if (!instance_exists(oPlayer) and instance_exists(oClient)) {
	    instance_create_layer(playerSpawn[0], playerSpawn[1], "Instances", oPlayer,{socket : oClient.connected});
	}
	
	//with (player) {
	//    socket = oClient.connected;
	//}
}