if (other.id == target and infectedAttackTimer < 0) {
    other.hp-= atk;
	other.damaged = true;
	infectedAttackTimer = 25;
	if (global.damageNumbers) {
	    var _inst = instance_create_layer(other.x,other.y,"DamageLayer",oDamageText);
		_inst.dmg = round(atk);
		_inst.critical = false;
	}
}
var canCollide = true;
switch (pattern) {
    case Patterns.Cluster:
        canCollide = true;
        break;
    case Patterns.StampedeLeft:
        canCollide = false;
        break;
    case Patterns.StampedeRight:
        canCollide = false;
        break;
    case Patterns.StampedeTop:
        canCollide = false;
        break;
    case Patterns.StampedeDown:
        canCollide = false;
        break;
    case Patterns.WallLeftRight:
        canCollide = false;
        break;
    case Patterns.WallTopBottom:
        canCollide = true;
        break;
    default:
        canCollide = true;
        break;
}
if (thisEnemy == Enemies.SmolAme) {
    canCollide = false;
}
if (boss) {
    canCollide = false;
}
if (!global.gamePaused and canwalk and canCollide and other.pattern == pattern and other.infected == infected) {
	//if (pattern == Patterns.Cluster and other.pattern == Patterns.Cluster or pattern != Patterns.Cluster and other.pattern != Patterns.Cluster ) {
		var _push = .5;

		var _dir = point_direction(other.x, other.y, x, y);
		var _hspd = lengthdir_x(_push, _dir);
		var _vspd = lengthdir_y(_push, _dir);
 
		x+=_hspd;
		y+=_vspd;
	//}
}