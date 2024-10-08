//feather disable GM2017
ini_open("Debug.ini");
screenarea = [0, 0, 0, 0];
show = false;
x = 100;
y = 100;
vara = 1;
varb = 1;
maxsize = 0;
maxwidth = 0;
step = 1;
minimized = false;
xx = x;
yy = 0;
checkbox = false;
variables = [];
yyStep = [50, 20, 30];
enum DebugTypes {
	UpDown,
	Checkbox,
	Button
}
page = 0;
pagenames = ["Start"];
function debug_add_config(instance, struct){
	var text = struct[$ "text"];
	var type = struct[$ "type"];
	var variable = struct[$ "variable"];
	var func = struct[$ "func"]; 
	var page = struct[$ "page"];
	for (var i = 0; i < array_length(DebugManager.variables); ++i) {
	    if (DebugManager.variables[i].text == text) {
		    return;
		}
	}
	var _page = array_get_index(DebugManager.pagenames, page);
	if (_page == -1) {
		array_push(DebugManager.pagenames, page);
		_page = array_get_index(DebugManager.pagenames, page);
	}
	array_push(DebugManager.variables, {text, type, instance, variable, func, page : _page});
	//show_message(DebugManager.variables[array_length(DebugManager.variables) - 1]);
}

function same_line(){
	//Feather disable once GM1041
	variables[array_length(variables) - 1][$ "sameLine"] = true
}

a = ini_read_real("Debug", "a", 1);
b = ini_read_real("Debug", "b", 1);
c = ini_read_real("Debug", "c", 1);
d = ini_read_real("Debug", "d", 1);
e = ini_read_real("Debug", "e", 1);
f = ini_read_real("Debug", "f", 1);
arr = ["a", "b", "c", "d", "e", "f"];
for (var i = 0; i < array_length(arr); ++i) {
    DebugManager.debug_add_config(self, {
	text : arr[i],
	type : DebugTypes.UpDown,
	variable : arr[i],
	//func: function(){},
	page : "2"
});
}
DebugManager.debug_add_config(self, {
	text : "Reset",
	type : DebugTypes.Button,
	//variable : "checkboxtest",
	func: function(){ DebugManager.a = 1; DebugManager.b = 1; DebugManager.c = 1; DebugManager.d = 1; DebugManager.e = 1; },
	page : "2"
});
valuetest = 0;
DebugManager.debug_add_config(self, {
	text : "Value Test",
	type : DebugTypes.UpDown,
	variable : "valuetest",
	//func: function(){},
	page : "Start"
});
checkboxtest = false;
DebugManager.debug_add_config(self, {
	text : "Checkbox Test",
	type : DebugTypes.Checkbox,
	variable : "checkboxtest",
	//func: function(){},
	page : "Start"
});
checkboxtestsameline = false;
DebugManager.debug_add_config(self, {
	text : "Checkbox Test SameLine",
	type : DebugTypes.Checkbox,
	variable : "checkboxtestsameline",
	//func: function(){},
	page : "Start"
});
DebugManager.same_line();
DebugManager.debug_add_config(self, {
	text : "Button Test",
	type : DebugTypes.Button,
	//variable : "checkboxtest",
	func: function(){show_message_async("Button")},
	page : "Start"
});
DebugManager.debug_add_config(self, {
	text : "Button Test SameLine",
	type : DebugTypes.Button,
	//variable : "checkboxtest",
	func: function(){show_message_async("Button 2")},
	page : "Start"
});
DebugManager.same_line();
//Network
DebugManager.debug_add_config(self, {
	text : "Create Lobby",
	type : DebugTypes.Button,
	//variable : "checkboxtest",
	func: function(){sendMessageNew(Network.CreateLobby, {name : "testlobby", password : "idkbro"})},
	page : "Network"
});
DebugManager.debug_add_config(self, {
	text : "Join Lobby",
	type : DebugTypes.Button,
	//variable : "checkboxtest",
	func: function(){sendMessageNew(Network.JoinLobby, {name : "testlobby", password : "idkbro"})},
	page : "Network"
});
DebugManager.debug_add_config(self, {
	text : "Second Login",
	type : DebugTypes.Button,
	//variable : "checkboxtest",
	func: function(){
		global.playerid = 5;
		global.username = "Airg";
		instance_destroy(oClient);
		instance_create_depth(0, 0, 0, oClient);
	},
	page : "Network"
});
//Stage
DebugManager.debug_add_config(self, {
	text : "Anvil",
	type : DebugTypes.Button,
	//variable : "checkboxtest",
	func: function(){instance_create_depth(oPlayer.x, oPlayer.y + 20, oPlayer.depth, oAnvil)},
	page : "Stage"
});
DebugManager.debug_add_config(self, {
	text : "Skill",
	type : DebugTypes.Button,
	//variable : "checkboxtest",
	func: function(){ oPlayer.skilltimer = 999; reset_timer();},
	page : "Stage"
});
DebugManager.debug_add_config(self, {
	text : "spawnTimer",
	type : DebugTypes.Button,
	//variable : "checkboxtest",
	func: function(){ global.spawnTimer = 30; },
	page : "Stage"
});
DebugManager.debug_add_config(self, {
	text : "Kill",
	type : DebugTypes.Button,
	//variable : "checkboxtest",
	func: function(){ HP = 0; },
	page : "Stage"
});
DebugManager.debug_add_config(self, {
	text : "Bubba",
	type : DebugTypes.Button,
	//variable : "checkboxtest",
	func: function(){instance_create_depth(oPlayer.x, oPlayer.y + 50, oPlayer.depth, oBubba)},
	page : "Stage"
});
DebugManager.debug_add_config(self, {
	text : "LevelUP",
	type : DebugTypes.Button,
	//variable : "checkboxtest",
	func: function(){},
	page : "Stage"
});
DebugManager.debug_add_config(self, {
	text : "Rerrol",
	type : DebugTypes.Button,
	//variable : "checkboxtest",
	func: function(){random_upgrades();},
	page : "Stage"
});
ws = 0;
DebugManager.debug_add_config(self, {
	text : "Weapon",
	type : DebugTypes.UpDown,
	variable : "ws",
	//func: function(){},
	page : "Stage"
});
DebugManager.debug_add_config(self, {
	text : $"Level Up",
	type : DebugTypes.Button,
	//variable : "checkboxtest",
	func: function(){
		if (UPGRADES[DebugManager.ws].level < UPGRADES[DebugManager.ws].maxlevel) {
		    UPGRADES[DebugManager.ws] = global.upgradesAvaliable[UPGRADES[DebugManager.ws].id][UPGRADES[DebugManager.ws].level + 1];
			oGui.upgradesSurface();
		}
	},
	page : "Stage"
});
same_line();
DebugManager.debug_add_config(self, {
	text : "Down",
	type : DebugTypes.Button,
	//variable : "checkboxtest",
	func: function(){
		if (UPGRADES[DebugManager.ws].level > 1) {
		    UPGRADES[DebugManager.ws] = global.upgradesAvaliable[UPGRADES[DebugManager.ws].id][UPGRADES[DebugManager.ws].level - 1];
			oGui.upgradesSurface();
		}
	},
	page : "Stage"
});
same_line();
ps = 0;
DebugManager.debug_add_config(self, {
	text : "Perk",
	type : DebugTypes.UpDown,
	variable : "ps",
	//func: function(){},
	page : "Stage"
});
DebugManager.debug_add_config(self, {
	text : $"LVUp",
	type : DebugTypes.Button,
	//variable : "checkboxtest",
	func: function(){
		if (PLAYER_PERKS[DebugManager.ps].level < 3) {
			PLAYER_PERKS[DebugManager.ps] = PERK_LIST[PLAYER_PERKS[DebugManager.ps].id][PLAYER_PERKS[DebugManager.ps].level + 1];
			oGui.upgradesSurface();
		}
	},
	page : "Stage"
});
same_line();
DebugManager.debug_add_config(self, {
	text : "LVDown",
	type : DebugTypes.Button,
	//variable : "checkboxtest",
	func: function(){
		if (PLAYER_PERKS[DebugManager.ps].level > 1) {
			PLAYER_PERKS[DebugManager.ps] = PERK_LIST[PLAYER_PERKS[DebugManager.ps].id][PLAYER_PERKS[DebugManager.ps].level - 1];
			oGui.upgradesSurface();
		}
	},
	page : "Stage"
});
same_line();
DebugManager.debug_add_config(self, {
	text : "CollabTest",
	type : DebugTypes.Button,
	//variable : "checkboxtest",
	func: function(){
		UPGRADES[1] = global.upgradesAvaliable[Weapons.BlBook][7];
		UPGRADES[2] = global.upgradesAvaliable[Weapons.PsychoAxe][7];
	},
	page : "Stage"
});
DebugManager.debug_add_config(self, {
	text : "Minutes",
	type : DebugTypes.Button,
	//variable : "checkboxtest",
	func: function(){
		Minutes = DebugManager.a;
	},
	page : "Stage"
});
//Shop
DebugManager.debug_add_config(self, {
	text : "Money",
	type : DebugTypes.Button,
	//variable : "checkboxtest",
	func: function(){
		global.holocoins = 999999999;
	},
	page : "Shop"
});
//Scores
DebugManager.debug_add_config(self, {
	text : "Load Scores",
	type : DebugTypes.Button,
	//variable : "checkboxtest",
	func: function(){
		sendMessageNew(Network.GetScores, {character : "Amelia Watson", page : 0});
	},
	page : "Shop"
});
ini_close();