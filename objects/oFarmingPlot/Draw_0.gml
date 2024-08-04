draw_sprite_ext(sprite_index, plot.watered, x, y, 1, 1, 0, c_white, 1);
if(plot.planted) {
    var timer = plot.crop.growthtime[0] / 4;
    if (plot.growthtimer[0] < timer * 4) {
        plot.stage = 0;
    }
    if (plot.growthtimer[0] < timer * 3) {
        plot.stage = 1;
    }
    if (plot.growthtimer[0] < timer * 2) {
        plot.stage = 2;
    }
    if (plot.growthtimer[0] < 0) {
        plot.stage = 3;
    }
    draw_sprite_ext(plot.crop.worldsprite, plot.stage, x, y, 1, 1, 0, c_white, 1);
    var _text = $"[fa_bottom][fa_center][{plot.growthtimer}\n";
    _text += $"\nTimer:{timer}\n4:{plot.growthtimer[0] < timer * 4}\n3:{plot.growthtimer[0] < timer * 3}\n2:{plot.growthtimer[0] < timer * 2}\n1:{plot.growthtimer[0] < timer}";
    //scribble(_text).draw(x, y - 30);
}
