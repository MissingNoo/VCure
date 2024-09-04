/// @instancevar {Any} critical
/// @instancevar {Any} dmg
var scale = 0.50;
draw_set_alpha(image_alpha);
var color = critical ? "c_yellow" : "c_white";
var _str = "";
if (dmg != 0) {
    _str = string(dmg);
}
else{
	color = "c_white";
	_str = "MISS";
}
if (infected) {
	color = "c_purple";
    _str = "INFECTED";
}
if (dmg > 9999) {
    _str = "KO!!!"
    scale = 0.75;
    color = "c_red";
}
//draw_text_transformed(x,y, _str, 1.25, 1.25, 0);
//draw_set_color(c_white);
try{
    scribble($"[fa_center][fa_middle][alpha,{image_alpha}][fDmg][{color}]{_str}").scale(scale).draw(x - (dir == -1 ? 8 : 0), y - 8);
}
catch (err) {
    //sometimes it errors out
}