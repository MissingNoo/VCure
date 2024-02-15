/// @description Insert description here
// You can write your code in this editor
//var color = c_white;
//var img = 0;
if (xp > 11 and xp < 19) {sprite_index = sXP2;}
if (xp > 20 and xp < 49) {sprite_index = sXP3;}
if (xp > 50 and xp < 99) {sprite_index = sXP4;}
if (xp > 100 and xp < 199) {sprite_index = sXP5;}
if (xp > 200) {sprite_index = sXP6;}
//draw_sprite_ext(sXP, img, x,y,1,1,0,color,1);
draw_self();
DEBUG
	draw_text(x,y-20, string(xp));
    draw_circle(x,y,30,true);
ENDDEBUG