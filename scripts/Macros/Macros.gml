// Feather disable GM2017
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
#macro DEBUG if (os_get_config() == "Debug" or global.debug) {
#macro ENDDEBUG }
//gml_pragma("ityBuild", "true");