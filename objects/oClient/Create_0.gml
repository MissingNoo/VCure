if (instance_number(oClient) > 1) { instance_destroy(); }
ini_open("settings");
global.playerid = ini_read_real("Settings", "playerid", -1);
global.username = ini_read_string("Settings", "Username", "Player");
ini_close();

playerSpawn = [1895, 1880];
showinfo = false;
infoOffset = [1000, 1000];
loggedin = false;
reason = "";

client = network_create_socket(network_socket_tcp);
clientBuffer = buffer_create(4098, buffer_fixed, 1);
keepalive = time_source_create(time_source_game, 5, time_source_units_seconds,function(){ 
				//sendMessage(0, {command : Network.KeepAlive, roomname : global.roomname})
			});

connected = -1;
try {
	connected = network_connect_raw(client, global.serverip, global.port);
	if (connected >= 0) {
		sendMessageNew(Network.Login, {});
	}
	else {
		reason = lexicon_text("Network.Unreachable");
	}
}
catch(error){
	reason = lexicon_text("Network.Unreachable");
	//show_message_async(error);
}

//if (room == rLobby) { instance_create_depth(x,y,depth,oLobby); }
//socketToInstanceID = ds_map_create();
//inRoom = room;
