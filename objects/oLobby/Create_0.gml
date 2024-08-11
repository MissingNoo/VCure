#region Basic variables
lobbyname = "";
rooms = [];
sendMessageNew(Network.ListLobbies);
selectedroom = 0;
ishost = 0;
players = undefined;
#endregion

#region Room Options
shareXP = false;
shareItems = false;
shareWeapons = false;
pauseGame = false;
shareAnvils = false;
shareStamps = false;
shareBoxDrops = false;
allowHalu = false;
allowGrank = false;
scaleMobs = false;
options = [
["Share XP", "shareXP"],
["Share Items", "shareItems"],
["Share Weapons", "shareWeapons"],
["Share Anvils", "shareAnvils"],
//["Share Stamps", "shareStamps"],
//["Share Box drops", "shareBoxDrops"],
//["Pause Game", "pauseGame"],
//["Allow Halu", "allowHalu"],
//["Allow Grank", "allowGrank"],
//["Scale Monsters", "scaleMobs"],
]
#endregion

chattext = "";
chatmessages = [];

fsm = new SnowState("Rooms");
fsm.add("Rooms", {
	enter : function() {
		selectedroom = 0;
		reloadcooldown = 60 * 5;
	},
	step : function() {
		reloadcooldown = clamp(reloadcooldown - 1, 0, infinity);
		selectedroom = clamp(selectedroom -input_check_pressed("up") + input_check_pressed("down"), 0, array_length(rooms) - 1);
	},
	draw : function() {
		lobby_button(120, 40, "Create", function(){
			if (fsm.get_current_state() != "CreateLobby") {
				fsm.change("CreateLobby");
			}
		}, [1, 1.50, 2]);
		lobby_button(320, 40, "Join", function(){
			if (fsm.get_current_state() != "JoiningLobby") {
				fsm.change("JoiningLobby");
			}
		}, [1, 1.50, 2]);
		
		lobby_button(520, 40, $"Reload {reloadcooldown > 0 ? "(" + string_char_at(reloadcooldown / 60, 1) + ")" : ""}", function(){
			if (reloadcooldown == 0) {
				reloadcooldown = 60 * 5;
				sendMessageNew(Network.ListLobbies);
			}
		}, [1, 1.50, 2]);
		var offset = 0;
		var dm = DebugManager;
		for (var i = 0; i < array_length(rooms); i++) {
			var color = selectedroom == i ? "c_yellow" : "c_white";
			rooms[1] = rooms[0];
			draw_sprite_ext(sHudAreaNew, 0, GW/2, 110 + offset, 30, 1.25, 0, c_white, 1);
			scribble($"[{color}][fa_middle][fa_left]{rooms[i].name}").scale(3).draw(GW/2 - 700, 110 + offset);
			scribble($"[fa_middle][fa_right][{rooms[i].protected ? sprite_get_name(sLockLobby) : sprite_get_name(sBlank)}] [{color}]{rooms[i].totalplayers}/2").scale(3).draw(GW/2 + 700, 110 + offset);
			offset += 65;
		}
	}
});

fsm.add_child("Rooms", "CreateLobby", {
	enter : function() {
		wl = [-750, 0, -751];
		lobbyname = "";
		lobbypass = "";
		keyboard_string = "";
		editing = 0;
	},
	step : function() {
		if (input_check_pressed("pause")) {
			wl[1] = wl[2];
		}
		wl[0] = lerp(wl[0], wl[1], 0.25);
		if (wl[0] == wl[2]) {
			fsm.change("Rooms");
		}
		if(string_length(keyboard_string) > 10) {
			keyboard_string = string_copy(keyboard_string, 1, 10);
		}
		switch (editing) {
			case 0:
				lobbyname = keyboard_string;
				break;
			case 1:
				lobbypass = keyboard_string;
				break;
		}
		
	},
	draw : function() {
		fsm.inherit();
		var _x = GW/2;
		var _y = GH/2 + wl[0];
		var _w = (sprite_get_width(sHudAreaNew) * 7) / 2;
		var _rw = _w - 50;
		var _rh = 20;
		draw_sprite_ext(sHudAreaNew, 0, _x, _y, 7, 8, 0, c_white, 1);

		_y -= 145;
		scribble("[fa_top][fa_center]Create").scale(3).draw(_x, _y);

		_y += 65;
		scribble("[fa_center][fa_middle]Name").scale(2.5).draw(_x, _y);
		_y += 40;
		var color = editing == 0 ? c_purple : c_white;
		draw_roundrect_color_ext(_x - _rw, _y - _rh, _x + _rw, _y + _rh, 5, 5, color, color, true);
		scribble($"[fa_center][fa_middle]{lobbyname}").scale(2.5).draw(_x, _y);
		if(point_in_rectangle(MX, MY, _x - _rw, _y - _rh, _x + _rw, _y + _rh) and device_mouse_check_button_pressed(0, mb_left)) {
			editing = 0;
			keyboard_string = lobbyname;
		}

		_y += 50;
		scribble("[fa_center][fa_middle]Password").scale(2.5).draw(_x, _y);
		_y += 40;
		color = editing == 1 ? c_purple : c_white;
		draw_roundrect_color_ext(_x - _rw, _y - _rh, _x + _rw, _y + _rh, 5, 5, color, color, true);
		scribble($"[fa_center][fa_middle]{lobbypass}").scale(2.5).draw(_x, _y);
		if(point_in_rectangle(MX, MY, _x - _rw, _y - _rh, _x + _rw, _y + _rh) and device_mouse_check_button_pressed(0, mb_left)) {
			editing = 1;
			keyboard_string = lobbypass;
		}

		_y += 60;
		lobby_button(_x + 63, _y, "Create", function(){
			sendMessageNew(Network.CreateLobby, {name : lobbyname, password : lobbypass});
		}, [0.65, 1.50, 2]);
		lobby_button(_x - 63, _y, "Cancel", function(){
			wl[1] = wl[2];
		}, [0.65, 1.50, 2]);
	}
});

fsm.add_child("Rooms", "JoiningLobby", {
	enter : function() {
		wl = [-750, 0, -751];
		lobbyname = rooms[selectedroom].name;
		lobbypass = "";
		keyboard_string = "";
		editing = 1;
	},
	step : function() {
		if (input_check_pressed("pause")) {
			wl[1] = wl[2];
		}
		wl[0] = lerp(wl[0], wl[1], 0.25);
		if (wl[0] == wl[2]) {
			fsm.change("Rooms");
		}
		if(string_length(keyboard_string) > 10) {
			keyboard_string = string_copy(keyboard_string, 1, 10);
		}
		switch (editing) {
			case 0:
				lobbyname = keyboard_string;
				break;
			case 1:
				lobbypass = keyboard_string;
				break;
		}
		
	},
	draw : function() {
		fsm.inherit();
		var _x = GW/2;
		var _y = GH/2 + wl[0];
		var _w = (sprite_get_width(sHudAreaNew) * 7) / 2;
		var _rw = _w - 50;
		var _rh = 20;
		var dm = DebugManager;
		draw_sprite_ext(sHudAreaNew, 0, _x, _y, 7, 5.50, 0, c_white, 1);
		
		_y -= 100;
		scribble("[fa_top][fa_center]Create").scale(3).draw(_x, _y);

		_y += 65;
		scribble("[fa_center][fa_middle]Password").scale(2.5).draw(_x, _y);
		_y += 40;
		color = editing == 1 ? c_purple : c_white;
		draw_roundrect_color_ext(_x - _rw, _y - _rh, _x + _rw, _y + _rh, 5, 5, color, color, true);
		scribble($"[fa_center][fa_middle]{lobbypass}").scale(2.5).draw(_x, _y);
		if(point_in_rectangle(MX, MY, _x - _rw, _y - _rh, _x + _rw, _y + _rh) and device_mouse_check_button_pressed(0, mb_left)) {
			editing = 1;
			keyboard_string = lobbypass;
		}

		_y += 60;
		lobby_button(_x + 63, _y, "Join", function(){
			sendMessageNew(Network.JoinLobby, {name : lobbyname, password : lobbypass});
		}, [0.65, 1.50, 2]);
		lobby_button(_x - 63, _y, "Cancel", function(){
			wl[1] = wl[2];
		}, [0.65, 1.50, 2]);
	}
});

fsm.add("OnLobby", {
	enter : function() {
		sendMessageNew(Network.UpdatePlayers, {});
	},
	step : function() {
	},
	draw : function() {
		var _text = string_replace(players, "[", "[[");
		scribble(_text).scale(2).draw(10, 10);
	}
})

/*
fsm.add_child("Rooms", "CreateLobby", {
	enter : function() {
	},
	step : function() {
	},
	draw : function() {
	}
}) */