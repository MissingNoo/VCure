playername = "Player";
showOtherNames = false;
sendMyName = false;
finalAccept = false;
confirmBlink = false;
confirmtimer = time_source_create(time_source_game, 1, time_source_units_seconds,function(){ oInitialConfig.confirmBlink = !oInitialConfig.confirmBlink; }, [], -1);
time_source_start(confirmtimer);
enum ConfigSteps {
	Language,
	PlayerName,
	ShowNames,
	Anonymous,
	FinalInfo
}
currentStep = ConfigSteps.Language;
languages = lexicon_languages_get_array();
//show_message_async(languages);
selectedLanguage = [0, array_length(languages) -1];
//room_goto(rInicio);
a = 0;
b = 2;
c = 2;