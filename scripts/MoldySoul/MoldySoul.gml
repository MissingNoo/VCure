function moldy_soul(data = {level : 0, upg : -1, enemy : noone}){
        add_buff_to_player(BuffNames.MoldySoul);    
}
function moldy_soul_on_crit(data = {level : 0, upg : -1, enemy : noone}) {
    if (data.level >= 2) {
        var _rnd = irandom_range(1, 100);
        var _chance = 33;
        if (_rnd <= _chance) {
            instance_create_layer(data.enemy.x, data.enemy.y - 8,"Upgrades",oUpgradeNew,{upg : global.upgradesAvaliable[Weapons.Mold][1]});
        }
    }
}

function mold_create(obj){
    obj.mindmg = (UPGRADES[0].mindmg*33)/100;
    obj.maxdmg = (UPGRADES[0].maxdmg*33)/100;
}
function mold_animation_end(obj) {
    if (instance_exists(obj)) { instance_destroy(obj); }
}