if (caninteract and distance_to_object(oPlayerWorld) < 10 and input_check_pressed("accept") and !instance_exists(oBloopShop)) {
	caninteract = false;
	instance_create_depth(x, y, depth, oBloopShop);
}