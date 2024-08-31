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
function outfit_add(_character, _name, _sprite, _runningSprite, _unlocked)
{
	pos = char_pos(_character, CHARACTERS);
	if (pos == -1) { exit; }
	//if (_unlocked) { UnlockableOutfits[_id] = _unlocked; }
	var _newNumber = array_length(CHARACTERS[pos][? "outfits"]);
	CHARACTERS[pos][? "outfits"][_newNumber] = 
	{
		name : _name,
		sprite : _sprite,
		runningSprite : _runningSprite,
		unlocked : _unlocked,
	}
}

function populate_outfits(){
	outfit_add("Fujikura Uruka","Default", sUrukaIdle,				sUrukaRunning,		true);
	outfit_add("Rinkou Ashelia","Default", sLiaIdle,						sLiaRunningOld,		true);
	outfit_add("Pipkin Pippa",		"Default", sPippaIdle,				sPippaRun,					true);
	outfit_add("Pipkin Pippa",		"Shipkin Shippa", sPippaIdleO2,			sPippaRunO2,			true);
	outfit_add("Tenma Maemi",	"Default", sTenmaIdleNew,	sTenmaRunNew,		true);
	outfit_add("Nephasis",			"Default", sTrickyIdle,				sTrickyRun,					true);
	outfit_add("Amelia Watson","Default", sAmeliaIdle,			sAmeliaRun,				true);
	outfit_add("Aki Rosenthal",	"Default", sAkiIdle,					sAkiRun,						true);
	outfit_add("Aki Rosenthal",	"Default", sAkiO1Idle,				sAkiO1Run,					false);
	outfit_add("Anya Melfissa",	"Default", sAnyaIdle,				sAnyaRun,					true);
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