add_buff_to_player(BuffNames.Soda);
if (PLAYER_PERKS[array_find_index(PLAYER_PERKS, function(e,i) {return e.id == PerkIds.SodaFueled})][$ "level"] >= 2) {
    var sodapos = player_get_buff_pos(BuffNames.Soda);
    PlayerBuffs[sodapos][$ "cooldown"] = PlayerBuffs[sodapos][$ "baseCooldown"] * 3;
}
food_item(3);