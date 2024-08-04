if (plot.planted) {
    plot.growthtimer[1] -= (1/60) * Delta;
    if (plot.growthtimer[1] <= 0) {
        plot.growthtimer[1] = 60;
        plot.growthtimer[0]--;
    }
    plot.wateredcooldown = clamp(plot.wateredcooldown - ((1/60) * Delta), 0, 60);
    if (plot.wateredcooldown == 0) {
        plot.watered = false;
    }
}
if (distance_to_object(oPlayerWorld) < 20 and input_check_pressed("accept")) {
    if (!plot.planted) {
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
}