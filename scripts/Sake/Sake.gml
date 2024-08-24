function sake_tick(){
    if (!variable_instance_exists(oPlayer, "sakeLevel")) { oPlayer.sakeLevel = 0; }
    var sakepos = array_find_index(playerItems, function(e, i){ return e.id == ItemIds.Sake;});
    add_buff_to_player(BuffNames.Sake);
    var sakebuffpos = array_find_index(PlayerBuffs, function(e, i){ return e.id == BuffNames.Sake;});
    if (oPlayer.sakeLevel < playerItems[sakepos][$ "level"]) {
        oPlayer.sakeLevel = playerItems[sakepos][$ "level"];
        PlayerBuffs[sakebuffpos][$ "maxCount"] = playerItems[sakepos][$ "bonus"];
    }
}

function sake_buff_tick(i) {
    if (PlayerBuffs[i][$ "count"] < PlayerBuffs[i][$ "maxCount"]) {
        PlayerBuffs[i][$ "count"] += 1;
    }
    var _amount = (PlayerBuffs[BuffNames.Sake][$ "count"] < 10) ? "1.0{0}" : "1.{0}";
    Bonuses[BonusType.Critical][ItemIds.Sake][0] = real(string(_amount, PlayerBuffs[BuffNames.Sake][$ "count"]));
}

function sakefood_buff_enter(i) {
    Bonuses[BonusType.Critical][ItemIds.Sake][1] = 1.05;
}

function sakefood_buff_end(i) {
    Bonuses[BonusType.Critical][ItemIds.Sake][1] = 0;
}