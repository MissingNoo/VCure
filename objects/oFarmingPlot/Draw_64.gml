if (state.get_current_state() != "Main") {
    var offset = 0;
    for (var i = 0; i < array_length(menuoptions); i++) {
        var alpha = 1;
        var _text = menuoptions[i];
        var _lextext = lexicon_text($"MenuOptions.{_text}");
        if ((_text == "Remove Plant" and !plot.planted) or state.get_current_state() != "Menu") { alpha = 0.5; }
        if ((_text == "Water" and plot.watered)) { _lextext += $" ({round(plot.wateredcooldown)})"; alpha = 0.5;}
        draw_sprite_ext(sHudButton, selectedoption == i, 230, 130 + offset, 1.20, 1.80, 0, c_white, alpha);
        scribble($"[fa_center][fa_middle][alpha,{alpha}][{selectedoption == i ? "c_black" : "c_white"}]{_lextext}").scale(2).draw(230, 130 + offset);
        offset += 60;
    }
}
state.draw();