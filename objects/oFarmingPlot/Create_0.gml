plot = global.farmplots[plotnum];
#region Variables
timer = 0;
menuoptions = ["Plant Seed", "Remove Plant", "Quit", "Grow"];
selectedoption = 0;
soilwindowx = [GW, GW];
selectedsoil = 0;
seedwindowx = [GW, GW];
selectedseed = 0;
recalpha = sine_wave(current_time  / 1250, 1, 0.15, 0.15);
confirm = true;
firstcrop = 0;
lastcrop = 0;
opentimer = 0;
#endregion
state = new SnowState("Main");
state.add("Main",{
    enter: function() {
        oCamWorld.zoom_level = 1;
        oPlayerWorld.canMove = true;
        selectedoption = 0;
    },
    step : function() {
        if (distance_to_object(oPlayerWorld) < 10 and input_check_pressed("accept") and opentimer == 0) {
            state.change("Menu");
        }
    },
    draw : function() {
        
    }
});
state.add("Menu", {
    enter: function() {
        oPlayerWorld.canMove = false;
        oCamWorld.zoom_level = 0.50;
        if (plot.planted) {
            menuoptions[0] = "Water";
            if (plot.growthtimer == 0) {
                menuoptions[0] = "Harvest";
            }
        }
        else {
            menuoptions[0] = "Plant Seed";
        }
    },
    step : function() {
        selectedoption += -input_check_pressed("up") + input_check_pressed("down");
        if (selectedoption < 0) { selectedoption = array_length(menuoptions) - 1; }
        if (selectedoption > array_length(menuoptions) - 1) { selectedoption = 0; }
        if (input_check_pressed("cancel")) { 
            state.change("Main");
        }
        if (input_check_pressed("accept")) { 
            switch (menuoptions[selectedoption]) {
                case "Water":
                    if (plot.wateredcooldown == 0) {
                        plot.watered = true;
                        plot.wateredcooldown = 60;
                        plot.growthtimer -= 60 * 60;
                    }
                    break;
                case "Plant Seed":
                    state.change("Plant");
                    break;
                case "Remove Plant":
                    plot.reset();
                    break;
                case "Quit":
                    state.change("Main");
                    break;
                case "Harvest":
                    var _yield = plot.soil.yield == 3 ? irandom_range(2, 9) : irandom_range(1, 3);
                    for (var i = 0; i < array_length(global.crops); i += 1) {
                        if (global.crops[i].name == plot.crop.name) {
                            global.crops[i].amount += _yield;
                            instance_create_depth(0, 0, oPlayerWorld.depth, oFarmHarvest, {prize : global.crops[i], amount : _yield});
                            plot.reset();
                            state.change("Main", function(){
                                                    oPlayerWorld.canMove = false;
                                                    oCamWorld.zoom_level = 1;
                                                }, function(){});
                            break;
                        }
                    }
                    break;
                case "Grow":
                    plot.growthtimer = 0;
                    break;
            }
        }
    },
    draw : function() {        
    }
});
state.add("Plant", {
    enter: function() {
        soilwindowx = [GW, 380];
        selectedsoil = 0;
    },
    step : function() {
        selectedsoil = clamp(selectedsoil - input_check_pressed("up") + input_check_pressed("down"), 0, array_length(global.farmsoils) - 1);
        soilwindowx[0] = lerp(soilwindowx[0], soilwindowx[1], 0.35);
        if (input_check_pressed("accept") and soilwindowx[0] == soilwindowx[1] and global.farmsoils[selectedsoil].amount > 0) {
            state.change("Seed");
        }
        if (input_check_pressed("cancel")) { 
            state.change("Menu");
        }
    },
    draw : function() {
        var _x = soilwindowx[0];
        var _y = GH/2;
        var _w = (sprite_get_width(sFarmListWindow) * 2.25);
        draw_sprite_ext(sFarmListWindow, 0, _x, _y, 2.25, 2.50, 0, c_white, 1);
        scribble($"[fa_center][fa_top]{lexicon_text("Farm.SoilSelect")}").scale(5).draw(_x + (_w / 2), _y - ((sprite_get_height(sFarmListWindow) * 2.50) / 2) + 30);
        _y -= 200;
        var offset = 0;
        for (var i = 0; i < array_length(global.farmsoils); i++) {
            var alpha = global.farmsoils[i].amount > 0 ? 1 : 0.5;
            if (selectedsoil == i) {
                if (state.get_current_state() == "Plant") {
                    draw_set_alpha(recalpha);
                    _color = c_white;
                }
                else {
                    draw_set_alpha(0.35);
                    _color = c_blue;
                }
                draw_rectangle_color(_x + 20, _y - 26 + offset, _x + _w - 30, _y + 26 + offset, _color, _color, _color, _color, false);
                draw_set_alpha(1);
            }
            draw_sprite_ext(sSoilIcons, global.farmsoils[i].subimg, _x + 50, _y + offset, 2, 2, 0, c_white, alpha);
            var _name = lexicon_text($"Farm.{global.farmsoils[i].name}");
            scribble($"[alpha,{alpha}][fa_middle]{_name}").scale(2.25).draw(_x + 50 + 40, _y + offset);
            scribble($"[alpha,{alpha}][fa_right][fa_middle]x {global.farmsoils[i].amount}").scale(2.25).draw(_x + _w - 50, _y + offset);
            offset += 60;
        }
    }
});
state.add_child("Plant", "Seed", {
    enter: function() {
        seedwindowx = [GW, 850];
        selectedseed = 0;
    },
    step : function() {
        seedwindowx[0] = lerp(seedwindowx[0], seedwindowx[1], 0.35);
        selectedseed = clamp(selectedseed - input_check_pressed("up") + input_check_pressed("down"), 0, array_length(global.crops) - 1);
        if (input_check_pressed("accept") and global.crops[selectedseed].seedamount > 0) { 
            state.change("Confirm");
        }
        if (input_check_pressed("cancel")) { 
            state.change("Plant", function(){}, function(){});
        }
    },
    draw : function() {
        state.inherit();
        var _x = seedwindowx[0];
        var _y = GH/2;
        var _w = (sprite_get_width(sFarmListWindow) * 2.25);
        draw_sprite_ext(sFarmListWindow, 0, _x, _y, 2.25, 2.50, 0, c_white, 1);
        scribble($"[fa_center][fa_top]{lexicon_text("Farm.SeedsSelect")}").scale(5).draw(_x + (_w / 2), _y - ((sprite_get_height(sFarmListWindow) * 2.50) / 2) + 30);
        _y -= 200;
        var offset = 0;
        for (var i = 0; i < array_length(global.crops); i++) {
            var alpha = global.crops[i].seedamount > 0 ? 1 : 0.5;
            if (selectedseed == i) {
                draw_set_alpha(recalpha);
                _color = c_white;
                draw_rectangle_color(_x + 20, _y - 26 + offset, _x + _w - 30, _y + 26 + offset, _color, _color, _color, _color, false);
                draw_set_alpha(1);
            }
            draw_sprite_ext(global.crops[i].seedsprite, 0, _x + 50, _y + offset, 2, 2, 0, c_white, alpha);
            var _name = lexicon_text($"Farm.{global.crops[i].name}");
            scribble($"[alpha,{alpha}][fa_middle]{_name}").scale(2.25).draw(_x + 50 + 40, _y + offset);
            scribble($"[alpha,{alpha}][fa_right][fa_middle]x {global.crops[i].seedamount}").scale(2.25).draw(_x + _w - 50, _y + offset);
            offset += 60;
        }
    }
});
state.add("Confirm", {
    enter: function() {
        confirm = true;
    },
    step : function() {
        if (input_check_pressed("left") or input_check_pressed("right")) {
            confirm = !confirm;
        }
        if (input_check_pressed("cancel")) {
            state.change("Seed", function(){}, function(){});
        }
        if (input_check_pressed("accept")) { 
            switch (confirm) {
                case true:
                    global.farmsoils[selectedsoil].amount--;
                    global.crops[selectedseed].seedamount--;
                    plot.planted = true;                    
                    plot.soil = variable_clone(global.farmsoils[selectedsoil]);
                    plot.crop = variable_clone(global.crops[selectedseed]);
                    var _minutes = plot.crop.growthtime[0] * 60 * 60;
                    var _seconds = plot.crop.growthtime[1] * 60;
                    timer = (_minutes + _seconds) / 4;
                    plot.growthtimer = _minutes + _seconds;
                    show_debug_message($"G:{plot.growthtimer}");
                    plot.growthtimer -= (plot.growthtimer * plot.soil.rate) / 100;
                    show_debug_message($"GE:{plot.growthtimer}");
                    plot.stage = 0;
                    state.change("Main");
                    break;
                case false:
                    state.change("Seed", function(){}, function(){});
                    break;
            }
        }
    },
    draw : function() {
        var dm = DebugManager;
        var _x = GW - 270;
        var _y = GH / 2;
        draw_sprite_ext(sFarmConfirmWindow, 0, _x, _y, 2, 2, 0, c_white, 1);
        scribble($"[fa_center][fa_middle]Planting the following:\n[c_green]{global.crops[selectedseed].name} Seed\n[c_white]and\n[c_green]{global.farmsoils[selectedsoil].name}")
        .scale(2.25)
        .draw(_x + 45, _y - 40);
        draw_sprite_ext(sItemSquare, 0, _x - 130, _y - 70, 2, 2, 0, c_white, 1);
        draw_sprite_ext(global.crops[selectedseed].seedsprite, 0, _x - 130, _y - 70, 2, 2, 0, c_white, 1);
        draw_sprite_ext(sItemSquare, 0, _x - 130, _y, 2, 2, 0, c_white, 1);
        draw_sprite_ext(sSoilIcons ,global.farmsoils[selectedsoil].subimg, _x - 130, _y, 2, 2, 0, c_white, 1);
    }
});
/*if (!plot.planted) {
    plot.planted = true;
    plot.soil = SoilType.Standard;
    plot.crop = variable_clone(global.crops[0]);
    plot.growthtimer = variable_clone(plot.crop.growthtime);
    plot.stage = 0;
}
else {
    plot.watered = true;
    plot.growthtimer[0]--;
    plot.wateredcooldown = 60;
}
*/