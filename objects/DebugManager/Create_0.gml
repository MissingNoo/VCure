//feather disable GM2017
screenarea = [0, 0, 0, 0];
show = false;
x = 100;
y = 100;
vara = 1;
varb = 1;
maxsize = 0;
maxwidth = 0;
step = 0.25;
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

a = 2655;
b = 1;
c = 1;
d = 1;
e = 1;
arr = ["a", "b", "c", "d", "e"];
for (var i = 0; i < array_length(arr); ++i) {
    DebugManager.debug_add_config(self, {
	text : arr[i],
	type : DebugTypes.UpDown,
	variable : arr[i],
	//func: function(){},
	page : "2"
});
}

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
//Stage
DebugManager.debug_add_config(self, {
	text : "Anvil",
	type : DebugTypes.Button,
	//variable : "checkboxtest",
	func: function(){instance_create_depth(oPlayer.x, oPlayer.y + 20, oPlayer.depth, oAnvil)},
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
	func: function(){global.xp = oPlayer.neededxp;},
	page : "Stage"
});