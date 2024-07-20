angle = point_direction(x,y, mouse_x, mouse_y);
lv += - keyboard_check_pressed(vk_pageup) + keyboard_check_pressed(vk_pagedown);
if (instance_exists(oPlayer)) {
    x = oPlayer.x;
	y = oPlayer.y - 8;
	angle = global.arrowDir;
	lv = UPGRADES[0].level;
}