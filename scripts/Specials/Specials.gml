#macro SPECIAL_LIST global.specialList
global.specialList=[0];
global.specialBonuses[0] = 0;

#region Special
function Special(_id, _char, _name, _thumb, _cooldown) constructor {
	name = _name;
	thumb = _thumb;
	cooldown = _cooldown;
	sequence = undefined;
	func = undefined;
	var pos = char_pos(_char, CHARACTERS);
	if (pos == -1) { exit; }
	ds_map_add(global.characters[pos], "special", _id);
	static set_function = function (funct) {
		func = funct;
		return self;
	}
	static set_sequence = function (seq) {
		sequence = seq;
		return self;		
	}
	return self;
}
enum SpecialIds {
	Uruka,
	Lia,
	WalmartForm,
	Trickywi,
	BuffDude,
	Shallys,
	BladeForm,
	SlowTime,
	LuminSpecial
}
#endregion
function populate_specials(){
	var sp = new Special(SpecialIds.Lia, "Rinkou Ashelia", "Menhera", sMenhera, 60)
	.set_function(function(){
		oPlayer.menhera = true;
		oPlayer.menheraTimer = 30;
	});
	SPECIAL_LIST[SpecialIds.Lia] = sp;

	sp = new Special(SpecialIds.WalmartForm, "Pipkin Pippa", "WalmartForm", sWalmart, 60)
	.set_function(function(){
		add_buff_to_player(BuffNames.WallmartDefense);
	});
	SPECIAL_LIST[SpecialIds.WalmartForm] = sp;

	sp = new Special(SpecialIds.Trickywi, "Nephasis", "WalmartForm", sWalmart, 60);
	SPECIAL_LIST[SpecialIds.Trickywi] = sp;

	sp = new Special(SpecialIds.BuffDude, "Tenma Maemi", "Buffed Kanpainiki", sWalmart, 60)
	.set_function(function(){
		instance_create_depth(oPlayer.x, oPlayer.y, oPlayer.depth, oTenmaDude);
	});
	SPECIAL_LIST[SpecialIds.BuffDude] = sp;

}

function use_special(_special) {
	/// @localvar {Any} skilltimer
	/// @localvar {Any} x
	/// @localvar {Any} y   
	if (global.screenShake) {
		oGame.shakeMagnitude = 7;
	}
	instance_create_depth(oPlayer.x, oPlayer.y, oPlayer.depth + 1, oVFX, {sprite_index : sUseSpecial});
	skilltimer = 0;
	if (_special[$ "sequence"] != undefined) {
	    global.lastsequence = layer_sequence_create("Specials", x, y, _special[$ "sequence"]);
	}
	if (_special[$ "func"] != undefined) {
	    _special[$ "func"]();
	}	
}