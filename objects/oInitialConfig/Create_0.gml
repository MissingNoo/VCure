#region Lexicon Initialization
lexicon_index_declare_from_json("english.json");
lexicon_index_declare_from_json("ptbr.json");
lexicon_language_set("English");
#endregion
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