#macro SPECIAL_LIST global.specialList
global.specialList=[0];
global.specialBonuses[0] = 0;

#region Item Functions

	function create_special(_id, _name, _sprite, _cooldown, _character, _sequence)
	{
		SPECIAL_LIST[_id]={};
		var item = SPECIAL_LIST[_id];
		variable_struct_set(item, "id", _id);
		variable_struct_set(item, "name", _name);
		variable_struct_set(item, "thumb", _sprite);
		variable_struct_set(item, "cooldown", _cooldown);
		variable_struct_set(item, "characterid", _character);
		variable_struct_set(item, "seq", _sequence);
		ds_map_add(global.characters[_character], "special", _id);
	}

	enum SpecialIds
	{
		Uruka,
		Lia,
		WalmartForm
	}
#endregion
function populate_specials(){
	create_special(SpecialIds.Uruka, "MONSTER", sUrukaSpecial, 60, Characters.Uruka, undefined);
	create_special(SpecialIds.Lia, "Menhera", sMenhera, 60, Characters.Lia, undefined);
	create_special(SpecialIds.WalmartForm, "Walmart Form", sWalmart, 60, Characters.Pippa, undefined);

	
}

function use_special(_special)
{
	skilltimer = 0;
	if (_special.seq != undefined) {
	    global.lastsequence = layer_sequence_create("Specials", x, y, _special.seq);
	}	
	switch (_special.id) {
	    case SpecialIds.Uruka:
			oPlayer.monsterUsed = true;
			oPlayer.monsterTimer = 10;
			//if (!instance_exists(oEnemy)) { break; }
	        //with (oEnemy) {
			//    // Feather disable once GM1041
			//    array_push(debuffs, copy_struct(Buffs[BuffNames.Slowness]));
			//	//show_message(Buffs[BuffNames.Slowness]);
			//}
	        break;
		case SpecialIds.Lia:{
			oPlayer.menhera = true;
			oPlayer.menheraTimer = 30;
			break;}
		case SpecialIds.WalmartForm:
			oPlayer.wallMart = true;
			oPlayer.wallmartTimer = 10;
			instance_create_depth(x, y, depth, oSpecialEffect);
			break;
	    
	    //case SpecialIds.Gura:
	    //	redgura = true;
	    //	break;
	    default:
	        // code here
	        break;
	}
}