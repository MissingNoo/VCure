global.guiSet = false;
global.guiScale = 1.5;
global.defaultAspect = display_get_gui_width() / display_get_gui_height();
global.defaultScreenAspect = display_get_width() / display_get_height();
global.screenH = display_get_gui_height();
global.screenW = display_get_gui_width();

function gui_set() {
	var aspect = global.defaultAspect;
	var screenAspect = global.defaultScreenAspect;
	var h = global.screenH;
	while (aspect < screenAspect) {
		h-=.1;	
		aspect = global.screenW / h;
	}
	display_set_gui_size(global.screenW, h);
	display_set_gui_size(global.screenW/(aspect/global.guiScale), display_get_gui_height()/(aspect/global.guiScale));
	GW = display_get_gui_width();
	GH = display_get_gui_height();
	global.guiSet = true;
}
// Feather disable GM2043
// Feather disable GM1024
// Feather disable GM2017
// Feather disable GM1044
// Feather disable GM1041
/// @globalvar {Any} gw 
/// @globalvar {Any} gh 
#macro GW global.gw

#macro GH global.gh

function drawWindow(x, y, xx, yy, title, titlesize = 25,titlePos = 15, fontsize = 1, backgroundAlpha = .35){
	//background
	draw_set_alpha(backgroundAlpha);
	draw_set_color(c_black);
	draw_rectangle(x,y,xx, yy,false);
	//
	draw_set_alpha(global.debug ? .5 : 1);
	draw_set_color(global.debug ? c_purple : c_white);
	//title
	draw_rectangle(x,y,xx,titlesize,false);
	//window
	draw_rectangle(x,y,xx,yy,true);
	draw_set_color(c_teal);
	draw_set_valign(fa_middle);
	draw_text_transformed(x+10,(y + titlesize) / 2, title, fontsize,fontsize,0);
	draw_set_valign(fa_top);
	draw_set_color(c_white);
}
function gameWindow(){
//window_set_size( 960, 540 );
var base_w = 640;
var base_h = 360;
var max_w = display_get_width();
var max_h = display_get_height();
var aspect = display_get_width() / display_get_height();
if (max_w < max_h){
	// portait
     var VIEW_WIDTH = min(base_w, max_w);
	var VIEW_HEIGHT = VIEW_WIDTH / aspect;
}
else{
	// landscape
	var VIEW_HEIGHT = min(base_h, max_h);
	var VIEW_WIDTH = VIEW_HEIGHT * aspect;
}
camera_set_view_size(view_camera[0], floor(VIEW_WIDTH), floor(VIEW_HEIGHT));
surface_resize(application_surface, view_wport[0], view_hport[0]);
camera_set_view_size(view_camera[0], floor(VIEW_WIDTH + 1), floor(VIEW_HEIGHT + 1));
view_wport[0] = max_w;
view_hport[0] = max_h;

}
function drawDesc(_xx, _yy, _string, maxX, _size = 1){
	_xx = floor(_xx);
	_yy = floor(_yy);
	//_originalSize = font_get_size(global.Font); 
	//if (os_type != os_android) {
	    //draw_set_font(global.Font); //draw_set_font(fnt_font1);
	//}
	/// @localvar {Any} _originalSize 
	_originalSize = font_get_size(draw_get_font()); 	
	draw_set_halign(fa_center);
	var xt=0;
	var yt=0;
	var char = "";
	var newline;
	for (var i = 1; i <= string_length(_string); ++i) {
		newline = false;
		char = string_copy(_string, i, 1);
		if (_xx + xt >= _xx + maxX and char != ".") { // past max x jump line
		    xt = 0;
			yt+=20;
		}
		if (char == " ") { //if word wont fit jump line
			var totalx = 0;
			for (var j = i+1; j <= string_length(_string); ++j) {
				/// @localvar {Any} char2 
				char2 = string_copy(_string, j, 1);
				if (char2 != " ") {
					totalx += 10.5;
				}
				else {
					break;
				}
			}
			if (_xx + xt + totalx + 20 >= _xx + maxX) {
				xt = 0;
				yt+=20;
				continue;
			}
		}
		switch (char) {
		    case "[":
				draw_set_color(c_green);
				i++;
				break;
		    case "]":
				draw_set_color(c_white);
				i++;
				break;
			case ".":
				if (string_copy(_string, i + 1, 1) == " ") {
					newline = true;
				}				
				break;
		}
		char = string_copy(_string, i, 1);
		if (xt == 0 and char == " ") {
		    xt = 0;
			continue;
		}
	    draw_text_transformed(_xx+xt, _yy+yt, char, _size, _size, 0);
		//xt+=10.5;
		var _space = string_copy(_string, i + 1, 1);
		xt+=string_width(_space == " " ? "m" : _space) * _size;
		if (newline) {
		    xt = 0;
			yt+=20;
		}
	}
	draw_set_halign(fa_left);
}
	
/**
 * Function Description
 * @param {real} x Description
 * @param {real} y Description
 * @param {real} xx Description
 * @param {real} yy Description
 * @param {any} [_background]=c_black Description
 * @param {any} [_outline]=c_white Description
 * @param {real} [alpha]=0.35 Description
 */
function drawRectangle(x, y, xx, yy, _background = c_black, _outline = c_white, alpha = 0.35){
	draw_set_alpha(alpha);
	draw_rectangle_color(x, y, xx, yy, _background, _background, _background, _background, false);
	draw_set_alpha(1);
	draw_rectangle_color(x, y, xx, yy, _outline, _outline, _outline, _outline, true);
}
	
	
function mouse_on_button(_x, _y, _sprite, _index, _xscale = 1, _yscale = 1, _variable = "selected", _info = -1){
	var _return = false;
	var _w = sprite_get_width(_sprite) * _xscale /2;
	var _h = sprite_get_height(_sprite) * _yscale / 2;
	if (point_in_rectangle(MX, MY, _x - _w, _y - _h, _x + _w, _y + _h) and mouse_click) {
		if (variable_instance_get(self, _variable) == _info) {
		    _return = true;
		}
	}
	if (point_in_rectangle(oGui.x, oGui.y, _x - _w, _y - _h, _x + _w, _y + _h)) {
		variable_instance_set(self, _variable, _index);
	}
	return _return;
}
function mouse_on_button_triangle(_x, _y, _x2, _y2, _x3, _y3, _index, _variable = "selected"){
	if (point_in_triangle(oGui.x, oGui.y, _x, _y, _x2, _y2, _x3, _y3)) {
		variable_instance_set(self, _variable, _index);
	}	
	DEBUG
	    draw_triangle(_x, _y, _x2, _y2, _x3, _y3, true);
	ENDDEBUG
		
}

function draw_set_hvaling(_h, _v){
	draw_set_valign(_v);
	draw_set_halign(_h);
}
function draw_set_reset(){
	draw_set_valign(fa_top);
	draw_set_halign(fa_left);
	draw_set_color(c_white);
	draw_set_alpha(1);
}
	
function select_screen_window(_x, _y, _xx, _yy, _title, _alpha = 0.5, color = c_white){
	draw_set_alpha(_alpha);
	//draw_rectangle_color(_x, _y, _xx, _yy, c_black, c_black, c_black, c_black, false);
	draw_rectangle_color(_x, _y, _xx, _yy, color, color, color, color, false);
	draw_set_alpha(1);
	scribble(string_upper($"[fa_top]{_title}")).scale(2.5).draw(_x + 6, _y + 5);
	//draw_text_transformed(_x + 6, _y + 5, string_upper(_title), 2.5, 2.5, 0);
	draw_rectangle_color(_x + 5, _y + 37, _xx - 5, _y + 38, c_white, c_white, c_white, c_white, false);
}

function slider(icon, iconoffset, x, y, length, height, r, variable, backcolor = c_white, circlecolor = c_gray, multiplier = 100, isglobal = true, instance = noone) {
	draw_set_color(backcolor);
	draw_rectangle(x, y, x + length, y + height, false);
	var value = 0;
	if (isglobal) {
		value = variable_global_get(variable);
	}
	else {
		value = variable_instance_get(instance, variable);
	}
	draw_set_color(circlecolor);
	draw_circle(x + (variable_global_get(variable) * multiplier), y + (height / 2), r, false);
	draw_set_color(c_white);
	draw_sprite_ext(icon, 0, x - iconoffset, y+ (height / 2), 1, 1, 0, c_white, 1);
	if (mouse_hold_left and point_in_rectangle(MX, MY, x, y - 3, x + length, y + height + 3)) {
		var endvalue = (MX - x) / multiplier;
		if (isglobal) {
			variable_global_set(variable, endvalue);
		}
		else {
			variable_instance_set(instance, variable, endvalue);
		}
	}
}

function scribble_outline(text, x, y, outcolor = "c_black", scale = 1) {
    var _off = [[-2, 0], [2, 0], [0, -2], [0, 2]];
    for (var i = array_length(_off) - 1; i >= 0 ; --i) {
        scribble($"[{outcolor}]{text}").scale(scale).draw(x + _off[i][0], y + _off[i][1]);
    }
    scribble(text).scale(scale).draw(x, y);
}
/// @mixin lobby_button
function lobby_button(_x, _y, text, func, scale = [1, 1.50, 2], enabled = true, force_sprite = false, enterfunc = function(){}) {
	alpha = 1;
	var _w = (sprite_get_width(sHudButton) * scale[0]) / 2;
	var _h = (sprite_get_height(sHudButton) * scale[1]) / 2;
	var mouse_on = point_in_rectangle(MX, MY, _x - _w, _y - _h, _x + _w, _y + _h);
	if (mouse_on) { enterfunc(); }
	var spr = mouse_on;
	if (force_sprite) {
		spr = 1;
	}
	if (!enabled) {
		mouse_on = false;
		alpha = 0.5;
	}
	var color = mouse_on or force_sprite ? "c_black" : "c_white";
	draw_sprite_ext(sHudButton, spr, _x, _y, scale[0], scale[1], 0, c_white, alpha);
	scribble($"[alpha,{alpha}][fa_center][fa_middle][{color}]{text}").scale(scale[2]).draw(_x, _y);
	if (enabled and mouse_on and device_mouse_check_button_pressed(0, mb_left)) {
		func();
	}
}