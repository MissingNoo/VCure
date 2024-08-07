function Crop(_name, _seed, _sprite, _wsprite, _cost, _sell, _growthtime) constructor {
    name = _name;
    sprite = _sprite;
    seedsprite = _seed;
    worldsprite = _wsprite;
    cost = _cost;
    sell = _sell;
    growthtime = _growthtime;
    seedamount = 1;
    amount = 0;
}
function Plot() constructor {
    planted = false;
    soil = "";
    watered = false;
    wateredcooldown = 0;
    crop = -1;
    growthtimer = 0;
    stage = 0;
    static reset = function() {
        planted = false;
        soil = "";
        watered = false;
        wateredcooldown = 0;
        crop = -1;
        growthtimer = 0;
        stage = 0;
    }
}
function Soil(_name, _subimg, _yield, _rate) constructor {
    name = _name;
    amount = 1;
    subimg = _subimg;
    yield = _yield;
    rate = _rate;
}
global.farmsoils = [new Soil("Standard Soil", 0, 1, 0), new Soil("Enhanced Soil", 1, 3, 0), new Soil("Expedited Soil", 2, 1, 40)];
function Inventory() constructor {
    items = [];
    static addItem = function(item, amount = 1) {
        var found = false;
        for (var i = array_length(items) - 1; i >= 0; i--) {
            if (items[i].name == item.name) {
                if (items[i][$ "amount"] != undefined and items[i].amount > 0) {
                    items[i].amount += amount;
                    found = true;
                }
                break;
            }   
        }
        if (!found) {
            array_push(items, item);
        }
    }
    static delItem = function(name, amount = 1, del = false) {
        for (var i = array_length(items) - 1; i >= 0; i--) {
            if (items[i].name == name) {
                if (items[i][$ "amount"] != undefined and items[i].amount > 0) {
                    items[i].amount -= amount;
                    if (items[i].amount <= 0) {
                        del = true;
                    }
                }
                if (del) {
                    array_delete(items, i, 1);
                }
                break;
            }
        }
    }
    static hasItem = function(name) {
        var result = [false, 0];
        for (var i = array_length(items) - 1; i >= 0; i--) {
            if (items[i].name == name) {
                if (items[i][$ "amount"] != undefined) {
                    result = [true, items[i].amount];
                }
                else {
                    result = [true, 0];
                }
                break;
            }   
        }
        return result;
    }
}
global.crops = [];
array_push(global.crops, 
    new Crop("Wheat", sWheatSeed, sWheatIcon, sCropWheat, 100, 50, [5, 0]),
    new Crop("Tomato", sTomatoSeed, sTomatoIcon, sCropTomato, 150, 100, [6, 0]),
    new Crop("Potato", sPotatoSeed, sPotatoIcon, sCropPotato, 200, 150, [6, 30]),
    new Crop("Rice", sRiceSeed, sRiceIcon, sCropRice, 250, 200, [7, 0]),
    new Crop("Onion", sOnionSeed, sOnionIcon, sCropOnion, 300, 250, [7, 30]),
    new Crop("Carrot", sCarrotSeed, sCarrotIcon, sCropCarrot, 350, 300, [8, 0]),
    new Crop("Green Bean", sGreenBeanSeed, sGreenBeanIcon, sCropGreenBean, 400, 350, [8, 30]),
    new Crop("Pepper", sPepperSeed, sPepperIcon, sCropPepper, 450, 400, [9, 0]),
    new Crop("Strawberry", sStrawberrySeed, sStrawberryIcon, sCropStrawberry, 500, 450, [9, 30]),
    new Crop("Corn", sCornSeed, sCornIcon, sCropCorn, 550, 500, [10, 0]),
    new Crop("Radish", sRadishSeed, sRadishIcon, sCropRadish, 600, 550, [11, 0]),
    new Crop("Garlic", sGarlicSeed, sGarlicIcon, sCropGarlic, 650, 600, [12, 0]),
);
global.farmplots = array_create(8, undefined);
for (var i = 0; i < array_length(global.farmplots); i += 1) {
    global.farmplots[i] = new Plot();
}