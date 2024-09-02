if (!justopened) {
    justopened = true;
    exit;
}
#region Lines VFX
if (array_length(upglines) < 50) {
    array_push(upglines, 
        [
            irandom(GW),
            irandom_range(0, GH + irandom(300)),
            irandom_range(30, 220),
            irandom_range(5, 15)
        ]
    );
}
#endregion
if (holoarrowspr <= 8) { holoarrowspr+=.25; } else { holoarrowspr=0; }
var sprev = selected;
var up = input_check_pressed("up");
var down = input_check_pressed("down");
selected = clamp(selected - up + down, 0, 5);
if (sprev != selected and selected == 4 and global.rerolls == 0) {
    if (down) {
        selected = 5; 
    }
    else if (up) {
        selected = 3;
    }
}
if (sprev != selected and selected == 5 and global.helds == 0) { 
    if (down) {
        selected = 0;
    }
    else if (up) {
        selected = 4;
    }
}
if (input_check_pressed("accept")) {
    switch (selected) {
        case 4:
            rerollbutton();
            exit;
        case 5:
            heldbutton();
            exit;
    }
    if (helding) {
        heldpos = selected;
        helding = false;
        global.held_item = {
            item : global.upgradeOptions[heldpos],
            position : heldpos,
        }
        exit;
    }
    for (var i = 0; i < 6; i++) {
        if (helding) { break; }
        if (global.upgradeOptions[selected][$ "name"] == "null") { break; }
        if (global.upgradeOptions[selected][$ "id"] == ItemIds.Holocoin) {
            var coins = 50;//feather disable once GM2017
            for (var j = 1; j < global.shopUpgrades.MoneyGain.level; ++j) {
                coins = coins + ((coins * 20) / 100);
            }
            global.newcoins += coins;
            break; 
        }
        if (global.upgradeOptions[selected][$ "id"] == ItemIds.Hamburguer){ heal_player(10); break; }
        if (global.upgradeOptions[selected][$ "style"] == ItemTypes.Weapon) {
            #region Upgrade existing weapon
            if (UPGRADES[i][$ "name"] == global.upgradeOptions[selected][$ "name"] ) {
                var newlevel = UPGRADES[i][$ "level"] + 1;
                UPGRADES[i] = global.upgradesAvaliable[UPGRADES[i].id][newlevel];
                //share_weapon(i);
                break;
            }			
            #endregion
            #region new weapon
            if (UPGRADES[i][$ "name"] == "null") {
                for (var j = 0; j < array_length(global.upgradesAvaliable); j++) {
                    if (global.upgradesAvaliable[j][1][$ "name"] == global.upgradeOptions[selected][$ "name"]) {
                        UPGRADES[i]=global.upgradesAvaliable[j][1];
                        //share_weapon(i);
                    }
                }
                break;
            }
            #endregion
        }
        else if (global.upgradeOptions[selected][$ "style"] == ItemTypes.Item) {
            #region Upgrade existing item
            if (playerItems[i][$ "name"] == global.upgradeOptions[selected][$ "name"] ) {
                var newlevel = playerItems[i][$ "level"] + 1;
                playerItems[i] = ItemList[playerItems[i][$ "id"]][newlevel];
                //share_item(i);
                break;
            }
            #endregion
        
            #region new item
            if (playerItems[i][$ "name"] == "") {
                for (var j=0; j<array_length(ItemList); j++) {
                    if (ItemList[j][1][$ "name"] == global.upgradeOptions[selected][$ "name"]) {
                        playerItems[i] = ItemList[j][1];
                        //share_item(i);
                    }
                }
                break;
            }
            #endregion
        }
        else if (global.upgradeOptions[selected][$ "style"] == ItemTypes.Perk) {
            #region Upgrade existing item
            if (PLAYER_PERKS[i][$ "name"] == global.upgradeOptions[selected][$ "name"] ) {
                var newlevel = PLAYER_PERKS[i][$ "level"]+1;
                PLAYER_PERKS[i] = PERK_LIST[PLAYER_PERKS[i][$ "id"]][newlevel];
                break;
            }
            #endregion
        }
    }
    oGui.upgradesSurface();
    instance_destroy();
}