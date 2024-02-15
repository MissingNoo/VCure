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
selectedLanguage = [0, array_length(languages) -1];
//room_goto(rInicio);
a = 0;
b = 2;
c = 2;