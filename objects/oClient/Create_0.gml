//global.serverip = "192.168.15.9";
ini_open("settings");
global.playerid = ini_read_real("Settings", "playerid", -1);
global.username = ini_read_string("Settings", "Username", "Player");
ini_close();
if (!global.initialConfigDone) {
    instance_destroy();
}
playerSpawn = [1895, 1880];
if (instance_number(oClient) > 1) {
    instance_destroy();
}

client = network_create_socket(network_socket_udp);
clientBuffer = buffer_create(4098, buffer_fixed, 1);
keepalive = time_source_create(time_source_game, 5, time_source_units_seconds,function(){ sendMessage({command : Network.KeepAlive, roomname : global.roomname})});
try{
	if (!global.singleplayer) {
		connected = network_connect_raw(client, global.serverip, global.port);
		sendMessage({command : Network.Connection, username : global.username});
	}
	else{
		connected = 0;
	}
}
catch(error){
	//i don't care bro
}
//}
//else {
    //connected = network_connect(client, "192.168.15.3", 64198);
//}

//show_message_async("Client: " + string(connected));

if (room == rLobby) {
    instance_create_depth(x,y,depth,oLobby);
}
socketToInstanceID = ds_map_create();
inRoom = room;
