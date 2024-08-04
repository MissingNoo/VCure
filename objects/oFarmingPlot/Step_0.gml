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
state.step();