function buff_soda_enter() {
    var percent = 1.03;
    if (PLAYER_PERKS[array_find_index(PLAYER_PERKS, function(e,i) {return e.id == PerkIds.SodaFueled})][$ "level"] >= 3) {
        percent = 1.09;
    }
    Bonuses[BonusType.Speed][ItemIds.Soda] = percent;
    Bonuses[BonusType.Critical][ItemIds.Soda] = percent;
    Bonuses[BonusType.Haste][ItemIds.Soda] = percent;
}

function buff_soda_leave() {
    Bonuses[BonusType.Speed][ItemIds.Soda] = 0;
    Bonuses[BonusType.Critical][ItemIds.Soda] = 0;
    Bonuses[BonusType.Haste][ItemIds.Soda] = 0;
}