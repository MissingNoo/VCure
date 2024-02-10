if (multichest) {
    draw_sprite(sprite_index, 0, x - 5, y -5);
    draw_sprite(sprite_index, 0, x + 5, y -5);
	draw_self();
}
else{
	draw_self();
}