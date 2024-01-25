show = false;
x = 100;
y = 100;
maxsize = 0;
step = 1;
minimized = false;
yy = 0;
screenarea = [x, y, x + 300, minimized ? y + 50 : y + maxsize];
variables = [];
enum DebugTypes {
	UpDown,
	Checkbox,
	Button
}
/**
 * debug_add_config() Add an entry to the debug menu
 * @param {String} text Description
 * @param {Any*} type UpDown/Checkbox/Button
 * @param {Id.Instance} instance Instance wich contains the variable
 * @param {any*} variable Variable wich will be interacted with by the debug menu
 * @param {function} [func]=function(){} Function that will be executed in a debug_text_button when clicked
 */
 //feather disable once GM2017
function debug_add_config(text, type, instance, variable, func = function(){}){
	for (var i = 0; i < array_length(DebugManager.variables); ++i) {
	    if (DebugManager.variables[i].text == text) {
		    return;
		}
	}
	array_push(DebugManager.variables, {text, type, instance, variable, func});
}