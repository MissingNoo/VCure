/// @globalvar {Any} dbg_slider_int 
/// @globalvar {Any} dbg_same_line 
/// @globalvar {Any} dbg_sprite_button 
/// @globalvar {Any} dbg_view_exists 
/// @globalvar {Any} dbg_view
/// @globalvar {Any} dbg_section
/// @globalvar {Any} dbg_text_input
/// @globalvar {Any} ref_create
/// @globalvar {Any} dbg_checkbox    
/// @globalvar {Any} dbg_view_delete
/// @globalvar {Any} dbg_button 
global.loremIpsum = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer accumsan velit a tellus dignissim condimentum. Nam sed lorem pulvinar, consequat justo nec, eleifend tellus. Donec id tempus arcu. Nam sem nisl, vehicula ut metus ut, efficitur malesuada tellus. Quisque ligula ligula, porttitor quis congue mollis, tempor at libero. Etiam vitae nulla luctus, porttitor augue et, aliquam arcu. Vestibulum vitae luctus metus. Nullam eu scelerisque dui. Praesent iaculis nisl dictum odio dictum, eget euismod tellus volutpat. Maecenas diam nisl, blandit ac elementum vel, sodales ac nulla. Morbi eget leo euismod, dapibus risus at, consequat dui. Donec ac tristique erat. Praesent cursus justo mi, at volutpat purus placerat sed. Integer viverra vitae sem malesuada molestie. Maecenas ornare auctor libero vitae rhoncus"
global.sprites[0]=0;
global.gamePaused = false;
function reset_timer(){
	global.seconds=0;
	global.minutes=0;
	global.hours=0;
	global.minutesPast30 = 0;
	global.hoursPast1= 0;
}
#macro Seconds global.seconds
#macro Minutes global.minutes
#macro Hours global.hours
//#macro Hours global.hours
	
function food_spawn(){
	for (var i = 0; i < array_length(PLAYER_PERKS); ++i) {
	    if (PLAYER_PERKS[i].id == PerkIds.SodaFueled and PLAYER_PERKS[i].level > 0) {
		    var _chance = 33;
			var _rnd = irandom_range(1, 100);
			if (_rnd <= _chance) {
			    instance_change(oSoda, false);
			}
		}
	}	
}
function food_item(_healAmount = 0){
	heal_player(_healAmount);
	#region Food Buffs
	if (player_have_buff(BuffNames.Sake)) {
		if (player_have_buff(BuffNames.SakeFood)) {
			player_buff_add_duration(BuffNames.SakeFood, Buffs[BuffNames.SakeFood][$ "baseCooldown"]);
		}
		else {
			add_buff_to_player(BuffNames.SakeFood);
		}
	}

	if (player_have_buff(BuffNames.MoldySoul)) {
		var _chance = 33;
		var _rnd = irandom_range(1, 100);
		if (_rnd <= _chance) {
			var moldypos = player_get_buff_pos(BuffNames.MoldySoul);
			PlayerBuffs[moldypos][$ "count"] += 1;
		}
	}
	#endregion
	instance_destroy();
}

function pause_game(){
	if (instance_exists(oGameOver) or room == rCharacterSelect) {
	    exit;
	}
		if (instance_exists(oPlayer)) {
			if (!global.gamePaused) {
			    oPlayer.wasPausedAim = oPlayer.mouseAim; 
				oPlayer.mouseAim = false;
			}
			else {
				oPlayer.mouseAim = oPlayer.wasPausedAim;
			}
		}
		
		oGui.activeMenu=PMenus.Pause;
		oGui.selected=0;
		maxselected = 0;
		//if (instance_exists(oJoystick)) {
		//	if (global.mode == "menu") {
		//	    global.mode = "stage";
		//	}
		//	else{global.mode = "menu";}
		//}
		if (!global.gamePaused) {
		    global.gamePaused = true;
			//mouseAim = false;
		}
		else if (global.gamePaused and !ANVIL and !global.upgrade and !PrizeBox and !GoldenANVIL) {
		    global.gamePaused = false;
			//if (instance_exists(oPlayer)) { oPlayer.mouseAim = oPlayer.wasPausedAim; }
		}
		if (global.singleplayer) {
			if(global.gamePaused)
			{
				with(all)
				{
					if (speed != 0 and image_speed != 0) {
						for (var i = 0; i < 12; i++) {
							if (alarm_get(i) > 0) {
								setalarms[i] = true;
								}
								else {
									setalarms[i] = false;
								}
								alarms[i] = alarm_get(i);
								alarm_set(i,-1);
							}
							pausedSpeed = speed;
							speed = 0;
							gamePausedImageSpeed = image_speed;		
							image_speed=0;
						}
					}
			}
			else
		{
				with(all)
				{	
					for (var i = 0; i < 12; i++)
					{
						if (variable_instance_exists(self, "setalarms") and setalarms[i] == true) {
						    alarm_set(i,alarms[i]);
						}						
					}
					if (variable_instance_exists(self, "pausedSpeed")) {
					    speed=pausedSpeed;
					}
					if (variable_instance_exists(self, "gamePausedImageSpeed")) {
					    image_speed=gamePausedImageSpeed;
					}					
				}
		}
		}
		//if (!global.gamePaused) {
		//	if (variable_global_exists("aim")) {
		//    //global.pad.destroy();
		//	}
		//}
		//else{
		//	if (variable_global_exists("aim")) {
		//		//global.pad.destroy();
		//	}
		//	//global.pad = input_virtual_create();
		//	//global.pad.circle(GW/oGui.a, GH/oGui.b, 60);
		//	//global.pad.follow(false);
		//	//global.pad.release_behavior(INPUT_VIRTUAL_RELEASE.RESET_POSITION);
		//	//global.pad.dpad("", "left", "right", "up", "down");
		//}
}		

enum Patterns{
	Null,
	Cluster,
	Horde,
	Ring,
	WallRight,
	WallLeft,
	WallLeftRight,
	WallTop,
	WallBottom,
	WallTopBottom,
	StampedeRight,
	StampedeLeft,
	StampedeTop,
	StampedeDown,
	Wave,
	Airdrop,
	Fastball,
	Ambush,
	Length
}
global.patternNames = ["Null", "Cluster", "Horde", "Ring", "WallRight", "WallLeft", "WallLeftRight", "WallTop", "WallBottom", "WallTopBottom", "StampedeRight", "StampedeLeft", "StampedeTop", "StampedeDown", "Wave", "Airdrop", "Fastball", "Ambush"];
function spawn_event_new(data = {
	monster : undefined,
	type : undefined,
	customHP : undefined,
	customATK : undefined,
	customSPD : undefined,
	customXP : undefined,
	lifetime : undefined,
	quantity : undefined,
	radius : undefined,
	distanceDie : undefined,
	followPlayer : undefined,
	offset : 2
}) {
	var enemy = global.enemies[data.monster];
	data.enemy = enemy;
	data.enemyheight = sprite_get_height(enemy[?"sprite"]);;
	data.enemywidth = sprite_get_width(enemy[?"sprite"]);;
	data.screen_center_x = view_wport[0] / 2;
	data.screen_center_y = view_hport[0] / 2;
	data.spawn_x = oPlayer.x;
	data.spawn_y = oPlayer.y;
	var spawndata = {
		customSpawn : true,
		selectedEnemy : data.enemy,
		pattern : data.type
	};
	datanames = struct_get_names(data);
	for (var i = 0; i < array_length(datanames); ++i) {
	    if (data[$ datanames[i]] != undefined) {
		    spawndata[$ datanames[i]] = data[$ datanames[i]];
		}
	}
	switch (data.type) {
		case Patterns.WallLeftRight:
			data.quantity = data.quantity / 2;
			event_wall(variable_clone(spawndata), "left");
			event_wall(variable_clone(spawndata), "right");
			break;
		case Patterns.WallTopBottom:
			data.quantity = data.quantity / 2;
			event_wall(variable_clone(spawndata), "up");
			event_wall(variable_clone(spawndata), "down");
			break;
		case Patterns.StampedeDown:
			spawndata.stampede = true;
			event_wall(variable_clone(spawndata), "down");
			break;
		case Patterns.StampedeTop:
			spawndata.stampede = true;
			event_wall(variable_clone(spawndata), "up");
			break;
		case Patterns.StampedeLeft:
			spawndata.stampede = true;
			event_wall(variable_clone(spawndata), "left");
			break;
		case Patterns.StampedeRight:
			spawndata.stampede = true;
			event_wall(variable_clone(spawndata), "right");
			break;
		case Patterns.Ring:
			event_ring(variable_clone(spawndata));
			break;
		default:
			event_default(variable_clone(spawndata));
			break;
		
	}
}

function event_wall(data, side = "left") {
	switch (side) {
	    case "left":
	        data.spawn_x -= data.screen_center_x;
			data.spawn_y -= data.enemyheight * (data.quantity / 2);
	        break;
	    case "right":
	        data.spawn_x += data.screen_center_x;
			data.spawn_y -= data.enemyheight * (data.quantity / 2);
	        break;
		case "up":
			data.spawn_y -= data.screen_center_y;
			data.spawn_x -= data.enemywidth * (data.quantity / 2);
			break;
		case "down":
			data.spawn_y += data.screen_center_y;
			data.spawn_x -= data.enemywidth * (data.quantity / 2);
			break;
	}
	if (data[$ "offset"] == 1) {
	    data.spawn_x += data.enemywidth;
		data.spawn_y += data.enemyheight;
	}
	var distance_offset = 1;
	if (data[$ "stampede"] == true) {
	    distance_offset = 2;
	}
	for (var i = 0; i < data.quantity; ++i) {
		instance_create_layer(data.spawn_x, data.spawn_y, "Instances", oEnemy, data);
		if (side == "left" or side == "right") {
		    data.spawn_y += data.enemyheight * distance_offset;
		}
		if (side == "up" or side == "down") {
		    data.spawn_x += data.enemywidth * distance_offset;
		}		
	}
}

function event_ring(data) {
	var circle = irandom_range(0, 360);
	repeat(data.quantity) {
		var _x = oPlayer.x + lengthdir_x(data.radius, circle);
		var _y = oPlayer.y + lengthdir_y(data.radius, circle);
		instance_create_layer(_x, _y, "Instances", oEnemy, data);
		circle += data.quantity / data.offset;
	}
}

function event_default(data) {
	var a = data.spawn_x + choose(-400, 400);
	var b = data.spawn_y + choose(-400, 400);
	for (var i = 0; i < data.quantity; ++i) {
		var aa = a + irandom_range(-16,16);
		var bb = b + irandom_range(-16,16);
		instance_create_layer(aa, bb, "Instances", oEnemy, data);
	}
}

function spawn_event(monster, type, hp, atk, spd, xp, lifetime, quantity, r = 400, distanceDie = "-", followPlayer = false, offset = 2){
	var data = {
		monster : monster,
		type : type,
		customHP : hp,
		customATK : atk,
		customSPD : spd,
		customXP : xp,
		lifetime : lifetime,
		quantity : quantity,
		radius : r,
		distanceDie : distanceDie,
		followPlayer : followPlayer,
		offset : offset
	}
	var datanames = struct_get_names(data);
	for (var i = 0; i < array_length(data); ++i) {
	    if (data[$ datanames[i]] == "-") {
		    data[$ datanames[i]] = undefined;
		}
	}
	show_debug_message("Spawned event");
	spawn_event_new(data);
}



function copy_struct(struct){
    var key, value;
    var newCopy = {};
    var keys = variable_struct_get_names(struct);
    for (var i = array_length(keys)-1; i >= 0; --i) {
            key = keys[i];
            value = struct[$ key];
            //variable_struct_get(struct, key);
            variable_struct_set(newCopy, key, value);
    }
    return newCopy;
}
/// @function heal_player(amount)
/// @description Heals the player.
/// @param {integer} amount The unique instance ID value of the instance to check.
function heal_player(amount){
	if (Bonuses[BonusType.Healing][ItemIds.FullMeal] != 0) {
	    HP += amount * Bonuses[BonusType.Healing][ItemIds.FullMeal];
	}else{
		HP += amount;
	}
}
	
function prop_draw(){
	if (!instance_exists(oPlayer)) {
	    return;
	}
	var sprw = sprite_width / 2;
	var sprh = sprite_height;
	var alpha = oPlayer.y < y and collision_rectangle(x- sprw,y - sprh, x + sprw, y, oPlayer, false, false) ? 0.75 : 1;
	var _offset = 0;
	switch (sprite_index) {
	    case sTree:
	        _offset = 16;
	        break;
	    default:
	        // code here
	        break;
	}
	
	draw_sprite_ext(sprite_index, 0, x, y + _offset, 1, -0.75, 0, c_black, 0.25);
	draw_sprite_ext(sprite_index, 0, x, y, 1, 1, 0, c_white, alpha);
}

function sine_wave(time, period, amplitude, midpoint) {
	if (variable_instance_exists(self, "sincounter")) {
	    sincounter+=15;
	}
    return sin(time * 2 * pi / period) * amplitude + midpoint;
}

function cose_wave(time, period, amplitude, midpoint) {
    return cos(time * 2 * pi / period) * amplitude + midpoint;
}

function sine_between(time, period, minimum, maximum) {
    var midpoint = mean(minimum, maximum);
    var amplitude = maximum - midpoint;
    return sine_wave(time, period, amplitude, midpoint);
}

/**
 * Function Description
 * @param {real} _sx Description
 * @param {real} _sy Description
 * @param {real} _ex Description
 * @param {real} _ey Description
 * @param {string} _var Description
 * @param {real} _value Description
 */
function open_keyboard(_sx, _sy, _ex, _ey, _var = "nullvar", _value = 0, _varr = ""){
	DEBUG
		draw_set_alpha(.3);
		draw_set_color(c_purple);
	    draw_rectangle(_sx, _sy, _ex, _ey, false);
		draw_set_color(c_white);
		draw_set_alpha(1);
	ENDDEBUG
	if (point_in_rectangle(mouse_x, mouse_y, _sx, _sy, _ex, _ey) and lobbyClick) {
		if (_varr != "") {
		    keyboard_string = variable_instance_get(self, _varr);
		}
		if (_var != "nullvar") {
		    variable_instance_set(self, _var, _value);
		}		
	    keyboard_virtual_show(kbv_type_default, kbv_returnkey_default, kbv_autocapitalize_none, false);
	}
}
function draw_lightning(_x, _y, _x2, _y2, _branches, _color){
//x = x of the bolt's start
//y = y of the bolt's start
//x2 = x of the bolt's end
//y2 = y of the bolt's end
//branches = true or false, if the lightning bolt branches into multiple smaller ones
//colour = colour of the glow
var dir = point_direction(_x,_y,_x2,_y2);
var length = point_distance(_x,_y,_x2,_y2);
var colour = _color;

//make different segments
var i = 0;
var i2 = 1;
var point;
point[0] = 0;
do
    {
    i++;
    if random(1) < .06
        {
        point[i2] = i;
        i2++;
        }
    }
until i >= length
point[i2] = length;
// Feather disable once GM1017
var points = array_length_1d(point);

//draw segments
i = 0;
i2 = 1
var difx = 0;
var difx2 = 0;
var dify = 0;
var dify2 = 0;

do //loop through and draw all the segments
    {
    difx = random_range(-7,7)
    dify = random_range(-7,7)
    
    var xx = _x + lengthdir_x(point[i2 - 1],dir);
    var yy = _y + lengthdir_y(point[i2 - 1],dir);
    var xx2 = _x + lengthdir_x(point[i2],dir);
    var yy2 = _y + lengthdir_y(point[i2],dir);
    
    //create a branch
    if random(1) < .15 && _branches
        {
        var bdir = dir + choose(random_range(-45,-25),random_range(45,25));
        var blength = random_range(5,30);
        draw_lightning(xx + difx2, yy + dify2, xx + difx2 + lengthdir_x(blength,bdir), yy + dify2 + lengthdir_y(blength,bdir), false,colour)
        }
    
    var size = random_range(.1,1);
    //draw the glow of the lightning
    draw_set_alpha(.1)
    draw_line_width_colour(xx + difx2,yy + dify2,xx2 + difx,yy2 + dify, size + 7,colour,colour);
    draw_line_width_colour(xx + difx2,yy + dify2,xx2 + difx,yy2 + dify, size + 5,c_white,c_white);
    draw_line_width_colour(xx + difx2,yy + dify2,xx2 + difx,yy2 + dify, size + 2,c_white,c_white);
    draw_set_alpha(1)
    //draw the white center of the lightning
    draw_line_width_colour(xx + difx2,yy + dify2,xx2 + difx,yy2 + dify, size,c_white,c_white);
    
    i2++;
    difx2 = difx;
    dify2 = dify;
    }
until i2 = points

//draw a glowing circle
if _branches
    {
    var size = random_range(1,2)
    draw_set_alpha(.1)
    draw_circle_colour(_x,_y,size + 2.5,colour,colour,false);
    draw_circle_colour(_x,_y,size + 1.5,colour,colour,false);
    draw_circle_colour(_x,_y,size + .5,colour,colour,false);
    draw_set_alpha(1)
    draw_circle_colour(_x,_y,size,c_white,c_white,false);
    }


}
function afterimage_step(){
	if (!variable_instance_exists(self, "afterimage")) { afterimage = []; }
	if (!variable_instance_exists(self, "afterimagecount")) { afterimagecount = 0; }
	if (afterimagecount < 0.30) {
	    afterimagecount += 1 * Delta;
	}
	else{
		afterimagecount = 0;
		array_push(afterimage[0],x);
		array_push(afterimage[1],y);
		array_push(afterimage[2], round(image_index));
		array_push(afterimage[3], image_angle);
		if (array_length(afterimage[0]) > 4) {
		    array_shift(afterimage[0]);
		    array_shift(afterimage[1]);
		    array_shift(afterimage[2]);
		}
	}
}

function prop_start(){
	var _y = 0;
	switch (sprite_index) {
	    case sFlower1:
	        part = part_system_create(pFlower1);
			_y = sprite_get_height(sprite_index) / 1.3;
	        break;
		case sBush1:
			part = part_system_create(pFlower1);
			break;
		case sBush2:
			part = part_system_create(pFlower1);
			break;
	    default:
	        // code here
	        break;
	}
	part_system_position(part, x, y - _y);
}

function prize_box_roll(boxnumber = 0){
	//There is a 7/10 chance for the reward to be a weapon and 3/10 chance for an item.
	//If the player cannot be offered a weapon (no available slots and fully leveled), the reward will be replaced by an item.
	//If the player cannot be offered an item, the game will attempt to roll again for a weapon, up to 5 times.
	//If the previous attempt fails (or both options are simply unavailable), the player will be rewarded additional HoloCoins instead.
	var _chance = irandom_range(0, 10);
	var _rewardType = _chance < 7 ? Rewards.Weapon : Rewards.Item;
	//var _rewardType = Rewards.Weapon;
	var _result;
	//var _validResult = false;
	if (_rewardType == Rewards.Weapon) {
	    _result = [Rewards.Weapon, prize_box_roll_weapon(boxnumber)];
		if (_result[1] == "item") {
		    _rewardType = Rewards.Item;
		}
	}
	if (_rewardType == Rewards.Item) {
	    _result = [Rewards.Item, prize_box_roll_item(boxnumber)];
		if (_result[1] == "weapon") {
		    repeat (5) {
				_rewardType = Rewards.Weapon;
			    _result = [Rewards.Weapon, prize_box_roll_weapon(boxnumber)];
			}
			if (_result[1] == "item") {
				_rewardType = Rewards.Item;
			    _result = [Rewards.Item, ItemIds.Holocoin];
			}
		}
	}	
	return _result;
}

function remove_ids_in_blacklist(type, options){
	var arr = type == Rewards.Weapon ? 0 : 1;
	var result = [];
	array_copy(result, 0, options, 0, array_length(options))
	for (var i = 0; i < array_length(oGui.chestblacklist[arr]); ++i) {
		for (var j = array_length(result) - 1; j >= 0 ; --j) {
			if (oGui.chestblacklist[arr][i] == result[j]) {
				    array_delete(result, j, 1);
			}
		}
	}
	return result;
}

function prize_box_roll_weapon(boxnumber){
	var _existing;
	var _possibleWeapons = [];
	for (var i = 0; i < array_length(UPGRADES); ++i) {
		if (UPGRADES[i][$ "level"] == UPGRADES[i][$ "maxlevel"]) {
			array_push(oGui.chestblacklist[0], UPGRADES[i][$ "id"]);
		}
	}
	for (var i = 0; i < array_length(WEAPONS_LIST); ++i) {
		var _weapon = WEAPONS_LIST[i][1];
		if (_weapon[$ "collab"] == true or (_weapon[$ "perk"] and _weapon[$ "characterid"] != global.player[? "name"]) or (_weapon[$ "unlocked"] != undefined and !_weapon[$ "unlocked"])) {
			continue;
		}
		else{
			var _haveWeapon = false;
			for (var j = 0; j < array_length(UPGRADES); ++j) {
			    if (UPGRADES[j][$ "id"] == i) {
				    _haveWeapon = true;
				}
			}
			if (_haveWeapon) {
			    repeat(10) {
					array_push(_possibleWeapons, i);
				}
			}
			else {
				array_push(_possibleWeapons, i);
			}
		}
	}
	var _weapon;
	var _emptySlots = 0;
	for (var i = 0; i < array_length(UPGRADES); ++i) {
	    if (UPGRADES[i] == global.null) {
		    _emptySlots++;
		}
	}
	var _canGiveNew = true;
	if ((boxnumber == 1 and _emptySlots == 1) or (boxnumber == 2 and _emptySlots < 2)) {
	    _canGiveNew = false;
		show_debug_message($"cant give new weapon box{boxnumber} slots {_emptySlots}");
	}
	if (UPGRADES[array_length(UPGRADES) - 1] == global.null and _canGiveNew) {
		_possibleWeapons = remove_ids_in_blacklist(Rewards.Weapon, _possibleWeapons);
		_weapon = _possibleWeapons[irandom(array_length(_possibleWeapons)- 1)];
		DEBUG
		show_debug_message("Weapon slot free:");
		show_debug_message($"	Rolled: {WEAPONS_LIST[_weapon][1][$ "name"]}");
		ENDDEBUG
	}
	else{
		_possibleWeapons = [];
		for (var i = 0; i < array_length(UPGRADES); ++i) {
		    if (UPGRADES[i][$ "level"] < UPGRADES[i][$ "maxlevel"]) {
			    array_push(_possibleWeapons, UPGRADES[i][$ "id"]);
			}
		}
		_possibleWeapons = remove_ids_in_blacklist(Rewards.Weapon, _possibleWeapons);
		if (array_length(_possibleWeapons) > 0) {
		    _weapon = _possibleWeapons[irandom(array_length(_possibleWeapons) - 1)];
			DEBUG
			show_debug_message("Rolling an existing Weapon:");
			show_debug_message($"	Rolled: {WEAPONS_LIST[_weapon][1][$ "name"]}");
			ENDDEBUG
		}
		else{
			_weapon = "item";
		}
	}
	array_push(oGui.chestblacklist[0], _weapon);
	return _weapon;
}

function prize_box_roll_item(boxnumber){
	var _possibleItems= [];
	for (var i = 0; i < array_length(playerItems); ++i) {
		if (playerItems[i][$ "level"] == playerItems[i][$ "maxlevel"]) {
			array_push(oGui.chestblacklist[1], playerItems[i][$ "id"]);
		}
	}
	for (var i = 0; i < array_length(ItemList); ++i) {
		var _item = ItemList[i][1];
		if ((_item[$ "perk"] != undefined and _item[$ "perk"]) and (_item[$ "unlocked"] != undefined and !_item[$ "unlocked"])) {
			continue;
		}
		else{
			var _haveItem= false;
			for (var j = 0; j < array_length(playerItems); ++j) {
			    if (playerItems[j][$ "id"] == i) {
				    _haveItem= true;
				}
			}
			if (_haveItem) {
			    repeat(10) {
					array_push(_possibleItems, i);
				}
			}
			else {
				array_push(_possibleItems, i);
			}
		}
	}
	var _item;
	var _emptySlots = 0;
	for (var i = 0; i < array_length(playerItems); ++i) {
	    if (playerItems[i] == global.nullitem) {
		    _emptySlots++;
		}
	}
	var _canGiveNew = true;
	if ((boxnumber == 1 and _emptySlots == 1) or (boxnumber == 2 and _emptySlots < 2)) {
	    _canGiveNew = false;
		show_debug_message($"cant give new item box{boxnumber} slots {_emptySlots}");
	}
	if (playerItems[array_length(playerItems) - 1] == global.nullitem and _canGiveNew) {
		_possibleItems = remove_ids_in_blacklist(Rewards.Item, _possibleItems);
		_item = _possibleItems[irandom(array_length(_possibleItems)- 1)];
		DEBUG
		show_debug_message("Item slot free:");
		show_debug_message($"	Rolled: {ItemList[_item][1][$ "name"]}");
		ENDDEBUG
	}
	else{
		_possibleItems= [];
		for (var i = 0; i < array_length(playerItems); ++i) {
		    if (playerItems[i][$ "level"] < playerItems[i][$ "maxlevel"]) {
			    array_push(_possibleItems, playerItems[i][$ "id"]);
			}
		}
		_possibleItems = remove_ids_in_blacklist(Rewards.Item, _possibleItems);
		if (array_length(_possibleItems) > 0) {
		    _item = _possibleItems[irandom(array_length(_possibleItems) - 1)];
			DEBUG
			show_debug_message("Rolling an existing Item:");
			show_debug_message($"	Rolled: {ItemList[_item][1][$ "name"]}");
			ENDDEBUG
		}
		else{
			_item = "weapon";
		}
	}
	array_push(oGui.chestblacklist[1], _item);
	return _item;
}

function damage_number_spawn(instance, damage, critical, infected = false, heal = false){
	if (global.damageNumbers and instance_number(oDamageText) < 50) {
		var _inst = instance_create_layer(instance.x, instance.y, "DamageLayer", oDamageText);
		_inst.dmg = round(damage);
		_inst.critical = critical;
		_inst.infected = infected;
		_inst.heal = heal;
	}
}

function add_xp(inst) {
	var newxp = inst.xp;
	audio_play_sound(snd_get_exp,0,0, global.soundVolume);
	instance_destroy(inst);
	for (var i = 0; i < array_length(Bonuses[BonusType.XPBonus]); ++i) {
		if (Bonuses[BonusType.XPBonus][i] != 0) {
			//show_message("old:" + string(newxp) + " new:" + string(newxp * Bonuses[BonusType.XPBonus][i]));
			newxp = newxp * Bonuses[BonusType.XPBonus][i];
		}
	}
	//feather disable once GM2017
	for (var i = 0; i < global.shopUpgrades[$ "ExpGain"][$ "level"]; ++i) {
		newxp = newxp + ((newxp * 4) / 100);
	}
	
	/*if (!global.singleplayer and global.shareXP) {
		//sendMessage(0, {command : Network.ShareXP, xp : newxp / 2});
		global.xp += newxp / 2;
	}
	else{
		
	}*/
	global.xp += newxp;
}

function get_bonus_percent(bonustype, shopname = "", shop_percent = 0) {
	var percent = 0;
	for (var i = 0; i < array_length(Bonuses[bonustype]); ++i) {
		if (!is_array(Bonuses[bonustype][i])) {
				percent += Bonuses[bonustype][i];
		}
		else{
			for (var j = 0; j < array_length(Bonuses[bonustype][i]); ++j) {
				percent += Bonuses[bonustype][i][j];
			}
		}
	}
	for (var i = 0; i < array_length(PerkBonuses[bonustype]); ++i) {
		percent += PerkBonuses[bonustype][i];
	}
	if (shopname != "") {
		for (var i = 0; i < global.shopUpgrades[$ shopname][$ "level"]; ++i) {
			percent += shop_percent;
		}
	}
	return percent;
}

global.credits = @"Thanks to these awesome people
Kay Yu: original Holocure.
Naisho14: Character selection concept images.
Ajmoment: Uruka / Lia sprites and icons.
Cursed: Tenma character sprites.
SymbolsWriter: Pippa and Tenma character sprites and icons.
Agnosia0: original Pippa mod.
LostWolfCat: Pippa second outfit sprites.
Fans on the Phase discord for ideas.
Airgeadlamh: Trickywi sprites.
JujuAdams: Input library.
TabularElf: Lexicon library.";