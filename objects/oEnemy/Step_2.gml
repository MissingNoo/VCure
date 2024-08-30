/// @description Insert description here
helddamagetimer = clamp(helddamagetimer - (1/60), 0, 2);
if (helddamagetimer == 0 and round(helddamage) > 0) {
    hp -= round(helddamage);
    damage_number_spawn(self, round(helddamage), false, false);
    show_debug_message($"Received {round(helddamage)} held damage");
    helddamage = 0;
}