if (plot.planted) {
    plot.growthtimer = clamp(plot.growthtimer - (1 * Delta), 0, infinity);
    //if (plot.growthtimer[1] <= 0) {
    //    plot.growthtimer[1] = 60;
    //    plot.growthtimer[0]--;
    //}
    plot.wateredcooldown = clamp(plot.wateredcooldown - ((1/60) * Delta), 0, 60);
    if (plot.wateredcooldown == 0) {
        plot.watered = false;
    }
}
recalpha = sine_wave(current_time  / 1250, 1, 0.10, 0.10);
state.step();