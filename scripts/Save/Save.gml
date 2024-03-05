// Feather disable GM2017
global.Data = [
    "holocoins","musicVolume","soundVolume", "damageNumbers", "shopUpgradesJSON", "showhpui", "gamePad", "houseinventory", "unlockableItems", "unlockableWeapons", "unlockableOutfits", "gRanks", "unlockableCharacters", "unlockableAchievements", "showOtherNames", "initialConfigDone"
    ];

#macro DATA (working_directory + "Save_Data.bin")
#macro Reserve (working_directory + "Reserve_Data.bin")

function Save_Data_Structs () { 
	global.shopUpgradesJSON = json_stringify(global.shopUpgrades);
	var Data = {};
        for(var i = 0; i < array_length(global.Data); i++){
            var Key = global.Data[i];
                if(variable_global_exists(Key)){
                    Data[$ Key] = variable_global_get(Key);}}
                var Map = json_decode(json_stringify(Data));
                ds_map_secure_save(Map, DATA);
                ds_map_destroy(Map);
            };
    
function Load_Data_Structs () {
    if (file_exists(DATA)) {
        var Map = ds_map_secure_load(DATA);
        var Json = json_parse( json_encode(Map) );
            for(var i = 0; i < array_length(global.Data); i++){
                var Key = global.Data[i];
                if(variable_global_exists(Key)){
                    variable_global_set(Key, Json[$ Key] );}}
          ds_map_destroy(Map);} 
		  if (is_string(global.shopUpgradesJSON)) {
		      //global.shopUpgrades = json_parse(global.shopUpgradesJSON);
			  var _json = json_parse(global.shopUpgradesJSON);
			  var _names = struct_get_names(_json);
			  for (var i = 0; i < array_length(_names); ++i) {
			      global.shopUpgrades[$ _names[i]].level = _json[$ _names[i]].level;
			  }
		  }  
		  
		if(array_length(UnlockableItems) < ItemIds.Length) { UnlockableItems[ItemIds.Length] = false; }
		if(array_length(UnlockableWeapons) < Weapons.Length) { UnlockableWeapons[Weapons.Length] = false; }
		if(array_length(UnlockableCharacters) < Characters.Lenght) { UnlockableCharacters[Characters.Lenght] = false; }
		if(array_length(UnlockableAchievements) < AchievementIds.Length) { UnlockableAchievements[AchievementIds.Length] = false; }
		if(array_length(Granks) < Characters.Lenght) { Granks[array_length(Granks)] = 0; }
		if(array_length(UnlockableOutfits) < Outfits.Length) { UnlockableOutfits[Outfits.Length] = false; }
     };
    
function Save_Reserve () { var Data = {};
        for(var i = 0; i < array_length(global.Data); i++){
            var Key = global.Data[i];
                if(variable_global_exists(Key)){
                    Data[$ Key] = variable_global_get(Key);}}
                var Map = json_decode(json_stringify(Data));
                ds_map_secure_save(Map, Reserve);
                ds_map_destroy(Map);
            };
    
function Load_Reserve () {
	if (file_exists(Reserve)) {
		var Map = ds_map_secure_load(Reserve);
		var Json = json_parse( json_encode(Map) );
		for(var i = 0; i < array_length(global.Data); i++){
			var Key = global.Data[i];
			if(variable_global_exists(Key)){
				variable_global_set(Key, Json[$ Key] );
			}
		}
	}
	// Feather disable once GM2043
	ds_map_destroy(Map);
};