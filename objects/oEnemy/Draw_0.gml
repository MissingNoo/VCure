/// @description Insert description here
// You can write your code in this editor                         
if (fanbeamFiring > 0) {
	if (alphaGoingUp) {
		if (warningAlpha < .25) {
		    warningAlpha += .005;
		}
		else{
			alphaGoingUp = false;
		}	    
	}
	if (!alphaGoingUp) {
		if (warningAlpha > .05) {
		    warningAlpha -= .005;
		}
		else{
			alphaGoingUp = true;
		}	    
	}
	draw_set_alpha(warningAlpha);
    draw_rectangle_color(x + (37 * image_xscale), y - 12, x + (view_wport[0] * image_xscale), y-98, c_red, c_red, c_red, c_red, false);
	draw_set_alpha(1);
    draw_rectangle_color(x + (35 * image_xscale), y - 10, x + (view_wport[0] * image_xscale), y-100, c_white, c_white, c_white, c_white, true);	
}

switch (thisEnemy) {
	    case Enemies.SmolAme:
			if (groundPounding and image_index > 17 and !ametp and sprite_index != sSmolAme) {
				draw_set_alpha(.25);
				draw_set_color(c_black);
			    draw_circle(x,y, 80, false);
				draw_set_color(c_white);
				draw_set_alpha(1);
			}
			draw_self();
	        break;
}
if (damaged and thisEnemy != Enemies.SmolAme) {
	gpu_set_fog(true,c_white,0,0);
	draw_self();    
	gpu_set_fog(false,c_white,0,0);
}
else if (thisEnemy != Enemies.SmolAme){
	//draw_self();
	draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, 0, infected == false ? c_white : c_purple, image_alpha);
	//var _tgtc = target == oPlayer ? c_blue : c_red;
	//var _tgt = target == oPlayer ? "host" : "client";
	//draw_text_color(x, y-16, _tgt, _tgtc, _tgtc, _tgtc, _tgtc, 1);
	if (infected and hp > 0) {
		draw_healthbar((x - 13), ((y - 16) - 20), (x + 13), ((y - 16) - 23), ((hp / baseHP) * 100), c_red, c_lime, c_lime, 0, 1, 0);
	}
	if (carryingBomb) {
	    draw_sprite(sImDie, 0, x, y - (sprite_get_height(sprite_index) / 2));
	}
}
var _vars = ["speed", "atk", "hp", "image_xscale", "infected", "target"];
DEBUG
if (distance_to_point(mouse_x, mouse_y) < 10) {
	if (instance_exists(target)) {
	    draw_line(x,y,target.x, target.y);
	}
	for (var i = 0; i < array_length(_vars); ++i) {
		if (variable_instance_exists(self, _vars[i])) {
		    draw_text(x - 20, y - 30 + (i * 10),_vars[i] + ": " +  string(variable_instance_get(self, _vars[i])));
		}	    
	}
}
ENDDEBUG
//draw_text(x,y-32,string(atk));
var offset = 0;
for (var i = 0; i < array_length(debuffs); ++i) {
	if (debuffs[i][$ "draw"] != undefined) {
		debuffs[i][$ "draw"](x, y);
	}
	var iconsize = sprite_get_width(debuffs[i].icon);
    draw_sprite(debuffs[i].icon,0,x+offset,y+30);
	if (variable_struct_exists(debuffs[i], "marks")) {
	    draw_text(x+offset, y+35, debuffs[i].marks);
	}
	if (variable_struct_exists(debuffs[i], "count")) {
	    draw_text(x+offset, y+35, debuffs[i].count);
	}
	offset += iconsize + 5;
}
if (oPlayer.spaghettiEaten) {
	draw_sprite(sSpaghettiEffect, 0, x, y);
}
