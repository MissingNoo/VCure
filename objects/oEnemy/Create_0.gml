event_inherited();
depth = layer_get_depth("Enemies");
canattackAlarm = 0;
damagedAlarm = 0;
lifetimeAlarm = 0;
saved = false;
gotknocked = false;
debuffs = [];
damageMultFromDefDown = 1;
spdMult = 1;
atkMult = 1;
damaged = false;
target = oPlayer;
enemynum = 1;
#region fubuzilla
fanbeamAlarm = 0;
fanbeamFiring = 0;
fanbeamCooldown = 350;
warningAlpha = 0;
alphaGoingUp = true;
justSpawned = true;
#endregion
#region Smol Ame
groundPoundTimer = 10;
goingDownTimer = 0;
groundPounding = false;
goingDown = false;
ametp = true;
#endregion
if (room != rInicio) {
	    random_set_seed(current_time);
	if (ds_list_size(global.enemyPool) > 0 ) {
		enemynum = irandom_range(0,ds_list_size(global.enemyPool)-1);
		if (!customSpawn) {
		    initiate_enemy(ds_list_find_value(global.enemyPool, enemynum));
		}else{
			initiate_enemy(selectedEnemy);
			if (customHP != "-") {
				hp = customHP;
			}
			if (customSPD != "-") {
				speed = customSPD;
			}
			if (customXP != "-") {
				xp = customXP;
			}
			switch (pattern) {
			    case Patterns.Horde:
			        direction = point_direction(x,y, oPlayer.x, oPlayer.y);
			        break;
				case Patterns.WallLeftRight:
					    direction = point_direction(x,y, oPlayer.x, y);
					break;
				case Patterns.WallTopBottom:
					    direction = point_direction(x,y, x, oPlayer.y);
					break;
				case Patterns.StampedeRight:
					    direction = point_direction(x,y, x - 20, y);
					break;
				case Patterns.StampedeLeft:
					    direction = point_direction(x,y, x + 20, y);
					break;
				case Patterns.StampedeTop:
					direction = point_direction(x,y, x, y + 10);					
					break;
				case Patterns.StampedeDown:
					direction = point_direction(x,y, x, y - 10);
					break;
			    default:
			        // code here
			        break;
			}
		}
	}
	else {
	    instance_destroy();
	}

	if (boss) {
	    remove_enemy_from_pool(thisEnemy);
	}
	baseATK = atk;
	baseHP = hp;
	//hp = (baseHP + baseHP * 0.05 * global.timeA) * (1 + (global.timeB / 50));
	baseSPD = speed;
	//baseHP = hp;
	hp = (baseHP + (baseHP * 0.05 + global.timeA)) * ( 1 + (global.timeB/50));
	canattack=true;
}
deathSent = false;
enemyID = irandom(99999);
//feather disable once GM2017
if (global.IsHost and !global.singleplayer) {
	var _chance = irandom_range(0, 1);
	target = _chance  == 0 ? oPlayer : oSlave;
	vars = variable_instance_get_names(self);
	savedvars = {};
	for (var i = 0; i < array_length(vars); ++i) {
	    variable_struct_set(savedvars, vars[i], variable_instance_get(self, vars[i]));
	}
	sendvars = json_stringify(savedvars);
	sendMessage(0, {
		command : Network.Spawn,
		socket : oClient.connected,
		x,
		y,
		sendvars
		});
}
dropxp = true;
oImageSpeed = image_speed;
#region Lia
infected = false;
infectedAttackTimer = 10;
lightningMarked = false;
lightningTimer = 10;
#endregion
#region look direction on spawn
firstlook = false;
#endregion
function updatedebuffs(){
	for (var i = 0; i < array_length(debuffs); ++i) {
	    if (variable_struct_exists(debuffs[i], "stat")) {
			//show_debug_message($"original : {variable_instance_get(self, debuffs[i].stat)}");
			var _count = debuffs[i].count;
			var _mult = debuffs[i].statAmount[_count];
			//feather disable once GM1041
			variable_instance_set(self, debuffs[i][$ "stat"], _mult);
			//show_debug_message($"after: {variable_instance_get(self, debuffs[i].stat)}");
		}
	}
}
hittedcooldown = array_create(150, 0);