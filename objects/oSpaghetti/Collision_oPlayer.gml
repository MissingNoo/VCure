Buffs[BuffNames.Spaghetti].cooldown = Buffs[BuffNames.Spaghetti].baseCooldown;
Buffs[BuffNames.Spaghetti].enabled = true;
heal_player(3);
if (Buffs[BuffNames.Sake][$ "enabled"]) {
    Buffs[BuffNames.SakeFood][$ "enabled"] = true;
    Buffs[BuffNames.SakeFood][$ "cooldown"] = Buffs[BuffNames.SakeFood][$ "baseCooldown"];
}
instance_destroy();