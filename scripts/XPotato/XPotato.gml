function x_potato_create (obj) {
    obj.direction = obj.arrowDir;
    obj.image_angle = obj.arrowDir;
    obj.justBounced = false;
    obj.dAlarm[0][1] = function(){};
    array_push(obj.dAlarm, [obj.upg.duration, ["sprite_index", sXPotatoExplosion], "variable"]);
    array_push(obj.dAlarm, [obj.upg.duration, ["speed", 0], "variable"]);
    array_push(obj.dAlarm, [obj.upg.duration, ["hits", 999], "variable"]);
    array_push(obj.dAlarm, [obj.upg.duration, ["image_angle", 0], "variable"]);
    //array_push(obj.dAlarm, [obj.upg.duration, ["animate", true], "variable"]);
    array_push(obj.dAlarm, [obj.upg.duration, [update_sprite_info, obj], "ex_func"]);
    array_push(obj.dAlarm, [obj.upg.duration, ["current_frame", 0], "variable"]);
    array_push(obj.dAlarm, [obj.upg.duration, ["mindmg", obj.upg.mindmgExplosion], "variable"]);
    array_push(obj.dAlarm, [obj.upg.duration, ["maxdmg", obj.upg.maxdmgExplosion], "variable"]);
    array_push(obj.dAlarm, [obj.upg.duration, ["image_xscale", obj.upg.explosionSize], "variable"]);
    array_push(obj.dAlarm, [obj.upg.duration, ["image_yscale", obj.upg.explosionSize], "variable"]);
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