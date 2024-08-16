//global.serverip = "140.238.187.191";
global.serverip = "192.168.0.107";
global.port = 21319;
// Feather disable GM2044
// Feather disable GM2017
enum Network {
	Null,
	Register,
	Login,
	SubmitScore,
	CreateLobby,
	JoinLobby,
	ListLobbies,
	Disconnect,
	UpdatePlayers,
	LeaveLobby,
	SelectCharacter,
	IsHost,
	StartGame,
	MovePlayer,
	SpawnUpgrade,
	SpawnEnemy,
	DestroyInstance,
	GetScores,

	Message,
	Move,
	PlayerMoved,
	PlayerConnect,
	PlayerJoined,
	PlayerDisconnect,
	Spawn,
	
	DestroyUpgrade,
	UpdateUpgrade,
	Destroy,
	HostDisconnected,
	LobbyConnect,	
	CreateRoom,
	ListRooms,
	JoinRoom,
	Connection,
	UpdateRoom,
	KeepAlive,
	UpdateOptions,
	ShareXP,
	ChatMessage,
	SpawnAnvil,
	UpdateAnvil,
	AddItem,
	InfectMob
	
}
function clientReceivedPacket2(_response)
{
	//show_debug_message(string(_response));
	var r = json_parse(_response);
	switch (r[$ "type"]) {
		case Network.Register:
			global.playerid = real(r[$ "id"]);
			ini_open("settings");
			ini_write_real("Settings", "playerid", global.playerid);
			ini_close();
			sendMessageNew(Network.Login, {});
			break;
		case Network.Login:
			if (r[$ "login"]) {
				oClient.loggedin = true;
			}
			else {
				oClient.loggedin = false;
				oClient.reason = r[$ "reason"];
			}
			break;
		case Network.JoinLobby:
			oLobby.fsm.change("OnLobby");
			break;
		case Network.ListLobbies:
			oLobby.rooms = json_parse(r[$ "lobbies"]);
			break;
		case Network.UpdatePlayers:
			oLobby.players = json_parse(r[$ "players"]);
			break;
		case Network.LeaveLobby:
			oLobby.fsm.change("Rooms");
			break;
		case Network.IsHost:
			global.IsHost = r[$ "isHost"];
			break;
		case Network.StartGame:
			oLobby.fsm.change("OnStage");
			room_goto(rStage1);
			break;
		case Network.MovePlayer:
			if (!instance_exists(oSlave)) { break; }
			oSlave.xx = r[$ "x"];
			oSlave.yy = r[$ "y"];
			if (oSlave.character == 0) {
				oSlave.character = r[$ "character"];
				oSlave.spd = global.characters[oSlave.character][? "speed"];
				oSlave.sprite = global.characters[oSlave.character][? "sprite"];
				oSlave.runsprite = global.characters[oSlave.character][? "runningsprite"];
			}
			break;
		case Network.SpawnUpgrade:
			if (!instance_exists(oSlave)) { break; }
			instance_create_depth(oSlave.x, oSlave.y, oSlave.depth, oSlaveUpgrade, {upg : global.upgradesAvaliable[r[$ "id"]][r[$"level"]], owner : oSlave, updata : json_parse(r[$ "updata"])});
			break;
		case Network.SpawnEnemy:
			var info = json_parse(r[$ "enemydata"]);
			var _enemy = instance_create_depth(info.x, info.y, 0, oEnemy, {
				fromnetwork : true, 
				thisEnemy : info.thisEnemy,
				target : info.target,
				enemyID : info.enemyID
			});
			break;
		case Network.DestroyInstance:
			var info = json_parse(r[$ "instancedata"]);
			switch (info.type) {
				case "upg":
					with (oSlaveUpgrade) {
						if (oid == info.id) {
							instance_destroy();
						}
					}
					break;
				case "enemy":
					with (oEnemy) {
						if (enemyID == info.id) {
							hp = -1;
						}
					}
					break;
			}
			break;
		case Network.GetScores:
			show_debug_message(json_stringify(json_parse(r[$ "r0"]), true));
			show_debug_message(json_stringify(json_parse(r[$ "r1"]), true));
			break;
	}
}
		/*
	    case Network.ListRooms:
	        oLobby.rooms = r[$ "rooms"];
			global.socket = r[$ "socket"];
			//show_debug_message(r[$"socket"]);
	        break;
			
		case Network.JoinRoom:{
			//show_debug_message(r);
			oLobby.roomname = r[$ "roomname"];
			oLobby.players = json_parse(r[$ "players"]);
			oLobby.ishost = r[$ "isHost"];
			//show_debug_message(r[$"isHost"]);
			oLobby.joinedRoom = true;
			keyboard_string = "";
			oLobby.chatmessages = [];
			break;
		}
		
		case Network.StartGame:{
			//for (var i = 0; i < array_length(oLobby.options); ++i) {
			//	// Feather disable once GM1044
			//	variable_global_set(oLobby.options[i][1], variable_instance_get(oLobby, oLobby.options[i][1]));
			//}
			room_goto(rStage1);
			break;}
			
		 case Network.PlayerJoined:{
				reset_timer();
				reset_pool();
				with (oEnemy) {
				    instance_destroy();
				}
				var _sockett = r[$ "socket"];
				var _slave = instance_create_layer(playerSpawn[0], playerSpawn[1], "Instances", oSlave);
				ds_map_add(socketToInstanceID, _sockett, _slave.id);
				//show_message(_socket);
				_slave.socket = _sockett;
				break;}
				
		case Network.PlayerMoved:{
			//show_debug_message(r);
			var _s = r[$ "socket"];
			var _x = r[$ "x"];
			var _y = r[$ "y"];
			var _spr = r[$ "sprite"];
			var _scale = r[$ "image_xscale"];
			var _sock = r[$ "socket"];
			var _spd = r[$ "spd"];
			
			if (!instance_exists(oSlave)) {
				instance_create_layer(0,0, "Instances", oSlave,{socket : _sock});
			}
			
			//show_debug_message("S:{0} X: {1} Y:{2}", _s, _x, _y);
			if (instance_exists(oPlayer) and _sock != oClient.connected and instance_exists(oSlave)) {
				oSlave.xx = _x;
				oSlave.yy = _y;
				oSlave.spd = _spd;
				oSlave.sprite_index = _spr;
				oSlave.image_xscale = _scale;
			}
			break;
		}
		
		case Network.SpawnUpgrade:{
			var _upg = instance_create_layer(r[$ "x"], r[$ "y"], "Instances", oSlaveUpgrade);
			_upg.upgID = r[$ "upgID"];
			_upg.sprite_index = r[$ "sprite_index"];
			_upg.direction = r[$ "direction"];
			_upg.image_angle = r[$ "image_angle"];
			//_upg.haveafterimage = r[$ "haveafterimage"];
			_upg.extraInfo= json_parse(r[$ "extraInfo"]);
			_upg.speed = _upg.extraInfo.speed;
			break;
		}
		
		case Network.UpdateUpgrade:{
			var extra = json_parse(r[$ "extraInfo"]);
			with (oSlaveUpgrade) {
			    if (upgID == r[$ "upgID"]) {					
					for (var i = 0, _names = variable_struct_get_names(extra); i < array_length(_names); ++i) {
					    extraInfo[$ _names[i]] = extra[$ _names[i]];
					}
				}
			}
			//var total = instance_number(oSlaveUpgrade);
			//	for (var i = 0; i < total; ++i) {
			//		var ftotal = instance_number(oSlaveUpgrade);
			//		if (ftotal != total) {
			//		    i = 0;
			//			total = ftotal;
			//		}
			//	    var inst = instance_find(oSlaveUpgrade, i);
			//		if (inst.upgID == r[$ "upgID"]) {
			//			var extraInfo = json_parse(r[$ "extraInfo"]);
			//			for (var i = 0, _names = variable_struct_get_names(extraInfo); i < array_length(_names); ++i) {
			//			    inst.extraInfo[$ _names[i]] = extraInfo[$ _names[i]];
			//			}
			//		}
			//	}
			break;
		}
		
		case Network.DestroyUpgrade:{
				var total = instance_number(oSlaveUpgrade);
				for (var i = 0; i < total; ++i) {
					var ftotal = instance_number(oSlaveUpgrade);
					if (ftotal != total) {
					    i = 0;
						total = ftotal;
					}
				    var inst = instance_find(oSlaveUpgrade, i);
					if (inst.upgID == r[$ "upgID"]) { instance_destroy(inst); }
				}
				break;}
				
		 case Network.Spawn:{
				var enemyvars = json_parse(r[$ "sendvars"]);
				var enemyvarnames = variable_struct_get_names(enemyvars);
				var _enemy = instance_create_layer(r[$ "x"], r[$ "y"], "Instances", oEnemy);
				for (var i = 0; i < variable_struct_names_count(enemyvars); ++i) {
				    variable_instance_set(_enemy, enemyvarnames[i], variable_struct_get(enemyvars, enemyvarnames[i]));
				}
				_enemy.target = _enemy.target == oPlayer ? oSlave : oPlayer;
				//if (_enemy.target == oPlayer) {
				    
				//}
				
				//_enemy.target = instance_nearest(x,y,oSlave);
				with (_enemy) {
					try{
						//initiate_enemy(ds_list_find_value(global.enemyPool, variable_struct_get(enemyvars, "enemynum")));
						initiate_enemy(global.enemies[variable_struct_get(enemyvars, "thisEnemy")]);
					}
					catch(error){
						initiate_enemy(ds_list_find_value(global.enemyPool, 0));
					}				
				}
				//}
				break;}
		
		case Network.Destroy:{
			//show_debug_message(string(r[$"owner"]) + ":" + string(oSlave.socket))
			//var candrop = true;
			//if (r[$"owner"] == oSlave.socket and global.shareXP) {
			//    candrop = false;
			//}
			if (instance_exists(oEnemy)) {
			    with (oEnemy) {
				    if (enemyID == r[$ "enemyID"]) {
						deathSent = true;
						if (r[$ "owner"] != oPlayer.socket) {
						    dropxp = false;
						}
					    hp = 0;
					}
				}
			}
			break;
		}
		
		case Network.UpdateRoom:{
			if (instance_exists(oLobby)) {
			    if (r[$ "roomname"] == global.roomname) {
				    oLobby.players = json_parse(r[$ "players"]);
					oLobby.IsHost = r[$ "isHost"];
				}
			}
			break;
		}
		
		case Network.UpdateOptions:{
			if (r[$ "roomname"] == global.roomname) {
				// Feather disable once GM1041
				variable_instance_set(oLobby, r[$ "option"], r[$ "value"]);
			}
			break;
		}
		
		case Network.ShareXP:{
			if (r[$ "roomname"] == global.roomname) {
				global.xp += r[$ "xp"];
			}
			break;
		}
		
		case Network.ChatMessage:{
			var _msg = [r[$ "username"], r[$ "text"]];
			array_push(oLobby.chatmessages, _msg);
			break;
		}
		
		case Network.SpawnAnvil:{
			if (r[$ "owner"] != global.socket) {
			    instance_create_depth(r[$ "x"], r[$ "y"], oPlayer.depth, oAnvil,{anvilid : r[$ "anvilid"], maxuses : r[$ "maxuses"], dontsend : true});
			}			
			break;}
			
		case Network.UpdateAnvil:{
			if (!instance_exists(oAnvil)) { return; }
			with (oAnvil) {
			    if (anvilid == r[$ "anvilid"]) {
				    maxuses = r[$ "maxuses"];
				}
			}
			break;}
			
		case Network.AddItem:{
			if (r[$ "type"] == "weapon") {
			    UPGRADES[r[$ "pos"]] = global.upgradesAvaliable[r[$ "id"]][r[$ "level"]];
			}
			if (r[$ "type"] == "item") {
			    playerItems[r[$ "pos"]] = ItemList[r[$ "id"]][r[$ "level"]];
			}
			break;}
			
		case Network.InfectMob:{
			var _id = r[$ "id"];
			var _target = r[$ "target"];
			var _newtarget = noone;
			with (oEnemy) {
			    if (enemyID == _target) {
				    _newtarget = id;
				}
			}
			with (oEnemy) {
			    if (enemyID == _id) {
				    target = _newtarget;
					infected = true;
					hp = r[$ "hp"];
					baseSPD = r[$ "baseSPD"];
				}
			}			
			break;}
		
	    default:
	        // code here
	        break;
	}
}
*/

function sendMessage(type, data){}
function sendMessageNew(type, data = {}){
	if (oClient.connected != 0) { exit; }
	buffer_seek(oClient.clientBuffer, buffer_seek_start, 0);
	data.playerid = global.playerid;
	data.playername = global.username;
	data.type = type;
	var _json = json_stringify(data);
	//show_debug_message($"Sending data: {json_stringify(data, true)}");
	buffer_write(oClient.clientBuffer, buffer_text, _json);	
	network_send_udp_raw(oClient.client, global.serverip, global.port, oClient.clientBuffer, buffer_tell(oClient.clientBuffer));
}