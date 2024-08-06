function Crop(_name, _seed, _sprite, _wsprite, _cost, _sell, _growthtime) constructor {
    name = _name;
    sprite = _sprite;
    seedsprite = _seed;
    worldsprite = _wsprite;
    cost = _cost;
    sell = _sell;
    growthtime = _growthtime;
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
}
function Soil(_name, _subimg, _yield, _rate) constructor {
    name = _name;
    amount = 0;
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
array_push(global.crops, new Crop("Wheat", sWheatSeed, sWheatIcon, sCropWheat, 100, 50, [5, 0]));
array_push(global.crops, new Crop("Tomato", sTomatoSeed, sTomatoIcon, sCropTomato, 150, 100, [6, 0]));
global.farmplots = array_create(8, undefined);
for (var i = 0; i < array_length(global.farmplots); i += 1) {
    global.farmplots[i] = new Plot();
}