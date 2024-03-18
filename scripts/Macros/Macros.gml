// Feather disable GM2017
#region Specials
#region Anya
#macro BLADE_FORM_ACCELERATION 0.1
#macro BLADE_FORM_CHANGE_FORM  20
#macro BLADE_FORM_MAX_ACCELERATION  30
#macro BLADE_FORM_AFTERIMAGE_COOLDOWN 0.05
#macro BLADE_FORM_HIT_COOLDOWN 10
#endregion
#endregion
#macro WEAPONS_LIST global.upgradesAvaliable
#macro u global.upgradesAvaliable
#macro Shield global.shield
#macro MaxShield global.maxshield
#macro Bonuses global.bonuses
#macro PerkBonuses global.perkBonuses
global.anvil = false;
global.goldenAnvil = false;
global.prizebox = false;
#macro ANVIL global.anvil
#macro PrizeBox global.prizebox
#macro GoldenANVIL global.goldenAnvil
#macro Buffs global.buffs
#macro Delta global.deltaTime
#macro RELEASE os_get_config() == "Release"
#macro DEBUG if (os_get_config() == "Debug" or global.debug) {
#macro ENDDEBUG }
//gml_pragma("ityBuild", "true");