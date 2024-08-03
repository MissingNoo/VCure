enum SoilType {
    Standard,
    Enhanced,
    Expedited
}
function Crop(_name, _sprite, _wsprite, _cost) constructor {
    name = _name;
    sprite = _sprite;
    worldsprite = _wsprite;
    cost = _cost;
}
function Plot(_id) constructor {
    planted = false;
    soil = -1;
    watered = false;
    wateredcooldown = 0;
    crop = -1;
    growthtimer = 0;
}
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