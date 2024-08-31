enum Outfits {
	Uruka,
	Lia,
	Pippa,
	Tenma,
	//TenmaAlternative,
	Trickywi,
	Amelia,
	Aki,
	AkiO1,
	Anya,
	Length
}
//feather disable once GM2017
function outfit_add(_character, _id, _sprite, _runningSprite, _unlocked)
{
	pos = char_pos(_character, CHARACTERS);
	if (pos == -1) { exit; }
	//if (_unlocked) { UnlockableOutfits[_id] = _unlocked; }
	var _newNumber = array_length(CHARACTERS[pos][? "outfits"]);
	CHARACTERS[pos][? "outfits"][_newNumber] = 
	{
		id : _id,
		sprite : _sprite,
		runningSprite : _runningSprite,
		unlocked : _unlocked,
	}
}

function populate_outfits(){
	outfit_add("Fujikura Uruka",		Outfits.Uruka,			sUrukaIdle,				sUrukaRunning,		true);
	outfit_add("Rinkou Ashelia",				Outfits.Lia,					sLiaIdle,					sLiaRunningOld,		true);
	outfit_add("Pipkin Pippa",		Outfits.Pippa,				sPippaIdle,				sPippaRun,					true);
	outfit_add("Pipkin Pippa",		Outfits.Pippa,				sPippaIdle,				sPippaRun,					true);
	//outfit_add("Tenma Maemi",		Outfits.TenmaAlternative,			sTenmaIdle,			sTenmaRun,				true);
	outfit_add("Tenma Maemi",		Outfits.Tenma,			sTenmaIdleNew,			sTenmaRunNew,				true);
	outfit_add("Nephasis",		Outfits.Trickywi,			sTrickyIdle,			sTrickyRun,				true);
	outfit_add("Amelia Watson",		Outfits.Amelia,			sAmeliaIdle,			sAmeliaRun,				true);
	outfit_add("Aki Rosenthal",		Outfits.Aki,			sAkiIdle,			sAkiRun,				true);
	outfit_add("Aki Rosenthal",		Outfits.AkiO1,			sAkiO1Idle,			sAkiO1Run,				false);
	outfit_add("Anya Melfissa",		Outfits.Anya,			sAnyaIdle,			sAnyaRun,				true);
}

function unlocked_outfits_load(){
	//for (var i = 0; i < array_length(UnlockableOutfits); ++i) {
	//    for (var j = 0; j < array_length(CHARACTERS); ++j) {
	//		for (var k = 0; k < array_length(CHARACTERS[j][?"outfits"]); ++k) {
	//		    if (CHARACTERS[j][?"outfits"][k][$ "id"] == i) {
	//			    CHARACTERS[j][?"outfits"][k][$ "unlocked"] = UnlockableOutfits[i];
	//			}
	//		}
	//	}
	//}
}