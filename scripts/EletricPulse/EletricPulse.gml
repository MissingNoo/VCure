function perk_eletric_pulse_on_cooldown(data = {level : 0, upg : -1, enemy : noone}) {
	instance_create_depth(oPlayer.x, oPlayer.y, oPlayer.depth, oUpgradeNew, {upg : global.upgradesAvaliable[Weapons.ElectricPulse][1]});
}
function eletric_pulse_step(obj) { 
	obj.x = obj.owner.x;
	obj.y = obj.owner.y;
}