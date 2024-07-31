event_inherited();
if (variable_global_exists("move")) {
    global.move.destroy();
}
global.move = input_virtual_create();
global.move.rectangle(0, GH/2, GW/2, GH);
global.move.follow(false);
sprite_index = sTenmaIdleNew;
sprite = sTenmaIdleNew;
runningsprite = sTenmaRunNew
in_range = noone;
canMove=true;
moving = false;
lockSprite = false;
spd = 1.40;
if (!instance_exists(oCam)) {
    instance_create_depth(x,y,0,oCamWorld);
}
#region Fishing
fishing = false;
#endregion