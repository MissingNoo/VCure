plot = global.farmplots[plotnum];
#region Variables
menuoptions = ["Plant Seed", "Remove Plant", "Quit"];
selectedoption = 0;
soilwindowx = [GW, GW];
seedwindowx = [GW, GW];
#endregion
state = new SnowState("Main");
state.add("Main",{
    enter: function() {
        oPlayerWorld.canMove = true;
    },
    step : function() {
        if (distance_to_object(oPlayerWorld) < 10 and input_check_pressed("accept")) {
            state.change("Menu");
        }
    },
    draw : function() {
        
    }
});
state.add("Menu", {
    enter: function() {
        oPlayerWorld.canMove = false;
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
                case "Plant Seed":
                    state.change("Plant");
                    break;
                case "Remove Plant":
                    break;
                case "Quit":
                    state.change("Main");
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
    },
    step : function() {
        soilwindowx[0] = lerp(soilwindowx[0], soilwindowx[1], 0.35);
        if (input_check_pressed("accept") and seedwindowx[0] == seedwindowx[1]) {
            state.change("Seed");
        }
        if (input_check_pressed("cancel")) { 
            state.change("Menu");
        }
    },
    draw : function() {
        draw_sprite_ext(sFarmListWindow, 0, soilwindowx[0], GH/2, 2.25, 2.50, 0, c_white, 1);
    }
});
state.add_child("Plant", "Seed", {
    enter: function() {
        seedwindowx = [GW, 850];
    },
    step : function() {
        seedwindowx[0] = lerp(seedwindowx[0], seedwindowx[1], 0.35);
        if (input_check_pressed("cancel")) { 
            state.change("Plant", function(){}, function(){});
        }
    },
    draw : function() {
        state.inherit();
        draw_sprite_ext(sFarmListWindow, 0, seedwindowx[0], GH/2, 2.25, 2.50, 0, c_white, 1);
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