draw_sprite_ext(sprite_index, plot.watered, x, y, 1, 1, 0, c_white, 1);
if(plot.planted) {
    if (plot.growthtimer < timer * 4) {
        plot.stage = 0;
    }
    if (plot.growthtimer < timer * 3) {
        plot.stage = 1;
    }
    if (plot.growthtimer < timer * 2) {
        plot.stage = 2;
    }
    if (plot.growthtimer <= 0) {
        plot.stage = 3;
    }
    draw_sprite_ext(plot.crop.worldsprite, plot.stage, x, y, 1, 1, 0, c_white, 1);
    var offset = 0;
    for (var i = 2; i <= 4; i += 1) {
        scribble($"[fa_bottom][fa_center]{i}:{plot.growthtimer < timer * i}").draw(x, y - 40 - offset);
        offset += 10;
    }
    var _text2 = $"[fa_bottom][fa_center]G {plot.growthtimer} T {timer} S {plot.stage}";
    scribble(_text2).draw(x, y - 20);
}