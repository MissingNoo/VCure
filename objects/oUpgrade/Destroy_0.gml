/// @description Insert description here
// You can write your code in this editor
if (lowest < 0) {
    show_debug_message($"lowest: {lowest}");
}

sendMessage(0, {
	command: Network.DestroyUpgrade,
	upgID,	
});
if (ps != undefined) {
    part_system_destroy(ps);
    part_system_destroy(ps2);
}
switch (upg[$ "id"]) {
    case Weapons.EldritchHorror:
        instance_destroy(oEldritchFX);
        break;
	//case Weapons.BoneBros:
	//show_message(slashTimer);
	//break;
    default:
        // code here
        break;
}