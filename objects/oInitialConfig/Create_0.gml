enum ConfigSteps {
	Language,
	PlayerName,
	ShowNames,
	Anonymous,
	FinalInfo
}
currentStep = ConfigSteps.Language;
languages = lexicon_languages_get_array();
show_message_async(languages);
//selectedLanguage = 
room_goto(rInicio);