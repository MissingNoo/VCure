var arrowdir = angle;
switch (lv) {
	case 1:
	    instance_create_depth(x, y, oGui.depth-1, Object71, {image_angle : arrowdir});
	    break;
	case 2:
		arrowdir = point_direction(x,y, mouse_x, mouse_y);
		var _xx = x + lengthdir_x(64, arrowdir + 90);
		var _yy = y + lengthdir_y(64, arrowdir + 90);
		var _x2 = x + lengthdir_x(256, arrowdir - 0);
		var _y2 = y + lengthdir_y(256, arrowdir + 0);
		var lastdir = point_direction(_xx, _yy, _x2, _y2);
		
		draw_sprite_ext(sHoloCursor, 0, x, y, 1, 1, arrowdir, c_white, 0.5);
		draw_rectangle_color(mouse_x - 2, mouse_y - 2, mouse_x + 2, mouse_y + 2, c_yellow, c_yellow, c_yellow, c_yellow, false);
		
		draw_rectangle_color(_xx - 2, _yy - 2, _xx + 2, _yy + 2, c_red, c_red, c_red, c_red, false);
		draw_rectangle_color(_x2 - 2, _y2 - 2, _x2 + 2, _y2 + 2, c_blue, c_blue, c_blue, c_blue, false);
		draw_sprite_ext(sHoloCursor, 0, _xx, _yy, 1, 1, lastdir, c_white, 0.5);
		draw_line_width_color(_xx, _yy, _x2, _y2, 3, c_blue, c_red);
		
		_xx = x + lengthdir_x(64, arrowdir - 90);
		_yy = y + lengthdir_y(64, arrowdir - 90);
		_x2 = x + lengthdir_x(256, arrowdir - 0);
		_y2 = y + lengthdir_y(256, arrowdir + 0);
		lastdir = point_direction(_xx, _yy, _x2, _y2);
		
		draw_rectangle_color(_xx - 2, _yy - 2, _xx + 2, _yy + 2, c_red, c_red, c_red, c_red, false);
		draw_rectangle_color(_x2 - 2, _y2 - 2, _x2 + 2, _y2 + 2, c_blue, c_blue, c_blue, c_blue, false);
		draw_sprite_ext(sHoloCursor, 0, _xx, _yy, 1, 1, lastdir, c_white, 0.5);
		draw_line_width_color(_xx, _yy, _x2, _y2, 3, c_blue, c_red);
	    break;
}
draw_text(x, y, $"lv:{lv}\nC:{cooldown}\nangle:{angle}");
