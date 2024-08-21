#region Lines VFX
draw_set_alpha(0.75);
for (var i = array_length(upglines) - 1; i > 0; i--) {
    upglines[i][1] -= upglines[i][3] * Delta;
    var lx = upglines[i][0];
    var ly = upglines[i][1];
    var ls = upglines[i][2] / 2;
    if (ly + ls < 0) {
        array_delete(upglines, i, 1);
    }
    draw_rectangle_color(lx, ly - ls, lx + 0.50, ly + ls, c_white, c_white, c_aqua, c_aqua, false);
}
draw_set_alpha(1);
#endregion
#region Options
var dm = DebugManager;
offset = 0;
var _xx = GW - 546;
var _yy = 203;
var _xscale = 2.36;
var _yscale = 1.40;
var uptype = "";
var style = "";
var foundup = false;
var foundlv = 0;
draw_sprite_stretched(Sprite520, 0, 0, 0, GW, GH);
for (var i = 0; i < array_length(global.upgradeOptions); i++) {			
    draw_sprite_ext(sUpgradeBackground, 0, _xx, _yy + offset, _xscale, _yscale, 0, c_black, .75);
    draw_rectangle(_xx - 437, _yy + offset - 36, _xx + 437, _yy + offset - 34, false);
    if (mouse_on_button(_xx, _yy + offset, sUpgradeBackground, i, _xscale / 1.32, _yscale / 2.2, "selected", i)) { menuClick = true; }
    if (i == selected) {
        draw_sprite_ext(sUpgradeBackground, 1, _xx, _yy + offset, _xscale, _yscale, 0, c_white, 1);
        draw_sprite_ext(sHoloCursor, holoarrowspr, _xx - 500, _yy + 6 + offset, 2.50, 2.50, 0, c_white, 1);
    }
    switch (global.upgradeOptions[i][$ "style"]) { // type of upgrade
        case ItemTypes.Weapon:
            for (var j = 0; j < array_length(UPGRADES); ++j) {
                if (UPGRADES[j][$ "name"] == global.upgradeOptions[i][$ "name"]) {
                    foundup = true;
                    foundlv = UPGRADES[j][$ "level"] + 1;
                }
            }
            style = " >> Weapon";
            uptype = "Weapons.";
            var _enchantment = WEAPONS_LIST[global.upgradeOptions[i].id][1].enchantment;
            var _isEnchanted = _enchantment != Enchantments.None;
            if (_isEnchanted) {						
                draw_set_color(#add8e6);
                draw_set_halign(fa_right);
                draw_text_transformed(_xx + 365, _yy + 35 + offset, "> " + lexicon_text($"Enchantments.{_enchantment}.desc"), 2, 2, 0);
                draw_set_halign(fa_left);
            }
            break;
        case ItemTypes.Item:
            for (var j = 0; j < array_length(playerItems); ++j) {
                if (playerItems[j][$ "id"] == global.upgradeOptions[i][$ "id"]) {
                    foundup = true;
                    foundlv = playerItems[j][$ "level"] + 1;
                }
            }
            style = " >> Item";
            uptype = "Items.";
            break;
        case ItemTypes.Perk:
            for (var j = 0; j < array_length(PLAYER_PERKS); ++j) {
                if (PLAYER_PERKS[j][$ "id"] == global.upgradeOptions[i][$ "id"]) {
                    foundup = true;
                    foundlv = PLAYER_PERKS[j][$ "level"] + 1;
                }
            }
            style = " >> Skill";
            uptype = "Perks.";
            break;
    }
    var _name = lexicon_text(uptype + string(global.upgradeOptions[i][$ "name"]) + ".name");
    scribble($"[fa_left]{_name}").scale(2.50).draw(_xx - 416, _yy - 64 + offset);
    if (i == heldpos) { 
        draw_circle(_xx - 360, _yy - 57 + offset, 10, false);
    }
    scribble($"[fa_right]{string(style)}").scale(2.5).draw(_xx + 410, _yy - 72 + offset);
    draw_sprite_ext(global.upgradeOptions[i][$ "thumb"],0,_xx - 384, _yy + 16 + offset, 2.25, 2.25, 0, c_white, 1);
    draw_sprite_ext(sItemType, global.upgradeOptions[i][$ "style"], _xx - 384, _yy + 16 + offset, 2.25, 2.25, 0, c_white, 1);
    var desc = "";
    if (foundup) {
        desc = lexicon_text($"{uptype}{global.upgradeOptions[i][$ "name"]}.{foundlv}");
    } else {
        desc = lexicon_text($"{uptype}{global.upgradeOptions[i][$ "name"]}.1");
    }
    scribble(desc).scale(2.50).wrap(753, 90).draw(_xx - 286, _yy - 23 + offset);
    offset += 164;
}//feather disable once GM2017
#region Reroll
if (global.shopUpgrades.Reroll.level > 0) {
    var _rerollX = GW - 695;
    var _rerollY = GH - 42;
    var _sprW = sprite_get_width(sHudButton);
    var _sprH = sprite_get_height(sHudButton);
    lobby_button(_rerollX, _rerollY, $"Reroll ({global.rerolls})", rerollbutton, [1.50, 2.10, 2.50], global.rerolls > 0, selected == 4, function(){ selected = 4; });
}
#endregion
#region Hold
if (global.shopUpgrades.Hold.level > 0) {
    var _holdx = GW/2 + 500;
    var _holdy = GH/1.05;
    lobby_button(_holdx, _holdy, $"Hold ({global.helds})", heldbutton, [1.17, 2, 2.50], !helding, selected == 5, function(){ selected = 5; });
}
#endregion
#endregion
oGui.drawStats();