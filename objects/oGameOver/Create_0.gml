cansubmit = oClient.connected == 0; //TODO: false if not connected
image_alpha = 0;
selectedOption = 0;
options = ["Retry", "Character Select", "Submit Highscore", "Main Menu"];
mousein = false;
if (!variable_global_exists("newcoins")) { variable_global_set("newcoins", 0); }