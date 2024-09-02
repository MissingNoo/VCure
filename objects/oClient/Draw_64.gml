draw_sprite_ext(sHudAreaNew, 0, GW / 2, GH/2 - infoOffset[0], 8, 6, 0, c_white, 1);
var _statusColor = "c_green";
var _serverOnline = lexicon_text("Network.Online");
if (connected != 0) { 
    _statusColor = "c_red";
    var _serverOnline = lexicon_text("Network.Offline");
}
var _title = lexicon_text("Network.ServerText");
scribble($"[fa_middle][fa_center]{_title}").scale(3).draw(GW/2, GH/2 - infoOffset[0] - 100);
scribble($"[{_statusColor}][sStatusIcon][c_white] {_serverOnline}").scale(3).draw(GW/2 - 170, GH/2 - infoOffset[0] - 70);
//if (room != rInicio) { exit; }
//scribble($"Connected: {connected}\nUsername: {global.username}\nPlayerid: {global.playerid}\nLoggedin: {loggedin}\nReason: {reason}").scale(2).draw(10, 10);