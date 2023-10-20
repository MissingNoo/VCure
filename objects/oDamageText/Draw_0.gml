//if (os_type != os_android) {
    //draw_set_font(global.Font); //draw_set_font(fnt_font1);
//}
draw_set_alpha(image_alpha);
draw_set_color(critical ? c_yellow : c_white);
var _str = "";
if (dmg != 0) {
    _str = string(dmg);
}
else{
	draw_set_color(c_white);
	_str = "MISS";
}
if (infected) {
	draw_set_color(c_red);
    _str = "INFECTED";
}
draw_text_transformed(x,y, _str, 1.25, 1.25, 0);
draw_set_color(c_white);