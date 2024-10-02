function eldritch_horror_create (obj) {
	fxfunc = function() {
		var _size = sprite_get_width(sprite_index);
		instance_create_depth(x + irandom_range(-_size, _size), y + irandom_range(-_size, _size), depth - 1, oEldritchFX);
		array_push(dAlarm, [irandom(100), fxfunc]);
	}
	array_push(dAlarm, [irandom(100), fxfunc]);
	x = obj.owner.x + irandom_range(-200, 200);
	y = obj.owner.y + irandom_range(-200, 200);
	ps = part_system_create();
	ps2 = part_system_create();
	part_system_depth(ps, depth-1);
	part_system_depth(ps2, depth-1);
	part_system_color(ps, c_white, .5);
	part_system_color(ps2, c_white, .5);
	part_system_draw_order( ps, false);
	part_system_draw_order( ps2, false);
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

	var pemit1 = part_emitter_create( ps );
	var pemit2 = part_emitter_create( ps2 );
	var _shape = ps_shape_ellipse;
	var _size = sprite_get_width(sEldricthHorrorPool);
	var _number = 1;
	part_emitter_region(ps, pemit1, -_size, _size, -_size, _size, _shape, ps_distr_linear );
	part_emitter_stream(ps, pemit1, ptype1, _number);
	part_emitter_region(ps2, pemit2, -_size, _size, -_size, _size, _shape, ps_distr_linear );
	part_emitter_stream(ps2, pemit2, ptype2, _number);

	part_system_position(ps, x, y);
	part_system_position(ps2, x, y);
}
function x_potato_step (obj) {
    if(obj.sprite_index != sXPotatoExplosion){
        obj.image_angle += 10;
    }
}
function x_potato_outside_view (obj) {
    if (obj.justBounced) { return; }
    if (!obj.justBounced) {
        obj.justBounced = true;
        array_push(obj.dAlarm, [10, ["justBounced", false], "variable"]);
    }
    obj.direction += 180 + random_range(-30, 30);
}
function x_potato_post_draw(obj) {
    //scribble($"[fa_bottom]animate:{obj.animate}\nframe:{obj.current_frame}/{obj.last_frame}").scale(2).draw(obj.x, obj.y - 20);
}
function x_potato_animation_end(obj) {
    if(instance_exists(obj) and obj.sprite_index == sXPotatoExplosion){
        instance_destroy(obj);
    }
    else{
        obj.animate = true;
    }
}