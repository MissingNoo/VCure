enum Outfits {
	Uruka,
	Lia,
	Pippa,
	Tenma,
	//TenmaAlternative,
	Length
}
UnlockableOutfits = array_create(Outfits.Length, false);
//feather disable once GM2017
function outfit_add(_character, _id, _sprite, _runningSprite, _unlocked)
{
	if (_unlocked) { UnlockableOutfits[_id] = _unlocked; }
	var _newNumber = array_length(CHARACTERS[_character][?"outfits"]);
	CHARACTERS[_character][?"outfits"][_newNumber] = 
	{
		id : _id,
		sprite : _sprite,
		runningSprite : _runningSprite,
		unlocked : _unlocked,
	}
}

function populate_outfits(){
	outfit_add(Characters.Uruka,		Outfits.Uruka,			sUrukaIdle,				sUrukaRunning,		true);
	outfit_add(Characters.Lia,				Outfits.Lia,					sLiaIdle,					sLiaRunningOld,		true);
	outfit_add(Characters.Pippa,		Outfits.Pippa,				sPippaIdle,				sPippaRun,					true);
	//outfit_add(Characters.Tenma,		Outfits.TenmaAlternative,			sTenmaIdle,			sTenmaRun,				true);
	outfit_add(Characters.Tenma,		Outfits.Tenma,			sTenmaIdle2,			sTenmaRun2,				true);
}

function unlocked_outfits_load(){
	for (var i = 0; i < array_length(UnlockableOutfits); ++i) {
	    for (var j = 0; j < array_length(CHARACTERS); ++j) {
			for (var k = 0; k < array_length(CHARACTERS[j][?"outfits"]); ++k) {
			    if (CHARACTERS[j][?"outfits"][k][$ "id"] == i) {
				    CHARACTERS[j][?"outfits"][k][$ "unlocked"] = UnlockableOutfits[i];
				}
			}
		}
	}
}