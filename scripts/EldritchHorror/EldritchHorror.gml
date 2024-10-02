function eldritch_horror_create(obj) {
	//fxfunc = function() {
	//	var _size = sprite_get_width(obj.sprite_index);
	//	instance_create_depth(obj.x + irandom_range(-_size, _size), obj.y + irandom_range(-_size, _size), obj.depth - 1, oEldritchFX);
	//	array_push(obj.dAlarm, [irandom(100), fxfunc]);
	//}
	//array_push(obj.dAlarm, [irandom(100), fxfunc]);
	//obj.x = obj.owner.x + irandom_range(-200, 200);
	//obj.y = obj.owner.y + irandom_range(-200, 200);
	obj.ps = part_system_create();
	obj.ps2 = part_system_create();
	part_system_depth(obj.ps, obj.depth-1);
	part_system_depth(obj.ps2, obj.depth-1);
	part_system_color(obj.ps, c_white, .5);
	part_system_color(obj.ps2, c_white, .5);
	part_system_draw_order( obj.ps, false);
	part_system_draw_order( obj.ps2, false);
	var _scale = 0.75;
	var _speed = 1;
	var ptype1 = part_type_create();
	part_type_sprite( ptype1, sEldricthHorrorSmoke, true, true, false);
	part_type_size( ptype1, 1, 1, 0, 0 );
	part_type_scale( ptype1, _scale, _scale);
	part_type_speed( ptype1, _speed, _speed, 0, 0);
	part_type_direction( ptype1, 180, 0, 0, 0);
	part_type_gravity( ptype1, 0, 270);
	part_type_orientation( ptype1, 0, 0, 0, 0, false);
	part_type_colour3( ptype1, $FFFFFF, $FFFFFF, $FFFFFF );
	part_type_alpha3( ptype1, 1, 1, 1);
	part_type_blend( ptype1, false);
	part_type_life( ptype1, 80, 80);
	var ptype2 = part_type_create();
	part_type_sprite( ptype2, sEldricthHorrorSmoke, true, true, false);
	part_type_size( ptype2, 1, 1, 0, 0 );
	part_type_scale( ptype2, _scale, _scale);
	part_type_speed( ptype2, _speed, _speed, 0, 0);
	part_type_direction( ptype2, 0, 0, 0, 0);
	part_type_gravity( ptype2, 0, 270);
	part_type_orientation( ptype2, 0, 0, 0, 0, false);
	part_type_colour3( ptype2, $FFFFFF, $FFFFFF, $FFFFFF );
	part_type_alpha3( ptype2, 1, 1, 1);
	part_type_blend( ptype2, false);
	part_type_life( ptype2, 80, 80);

	var pemit1 = part_emitter_create( obj.ps );
	var pemit2 = part_emitter_create( obj.ps2 );
	var _shape = ps_shape_ellipse;
	var _size = sprite_get_width(sEldricthHorrorPool);
	var _number = 1;
	part_emitter_region(obj.ps, pemit1, -_size, _size, -_size, _size, _shape, ps_distr_linear );
	part_emitter_stream(obj.ps, pemit1, ptype1, _number);
	part_emitter_region(obj.ps2, pemit2, -_size, _size, -_size, _size, _shape, ps_distr_linear );
	part_emitter_stream(obj.ps2, pemit2, ptype2, _number);

	part_system_position(obj.ps, obj.x, obj.y);
	part_system_position(obj.ps2, obj.x, obj.y);
}