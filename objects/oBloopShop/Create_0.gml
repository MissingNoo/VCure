a = DebugManager.a;
b = DebugManager.b;
c = DebugManager.c;
d = DebugManager.d;
e = DebugManager.e;
shopname = "Bloop's Fish Shop";
options = ["Buy", "Sell", "Exchange", "Talk", "Quit"];
menuoption = 0;
itemoption = 0;
firstitem = 0;
lastitem = 2;
buying = false;
buyoption = true;
buylist = Rods;
selling = false;
selllist = [];
for (var i = 1; i < array_length(Fishes.data); i++) {
	if (Fishes.data[i].amount > 0) {
		array_push(selllist, Fishes.data[i]);
	}
}
sellamount = array_create(array_length(selllist), 0);
whitebg = 1;
state = new SnowState("Menu");
state.add("Menu", {
	enter: function() {
		itemoption = 0;
		firstitem = 0;
		lastitem = 2;
	},
	step: function() {
		menuoption = clamp(menuoption - input_check_pressed("up") + input_check_pressed("down"), 0, array_length(options) - 1);
		if (input_check_pressed("cancel")) {
			oBloop.alarm[0] = 60;
		    instance_destroy();
		}
		if (input_check_pressed("accept")) {
			switch (options[menuoption]) {
			    case "Buy":
			        state.change("Buy");
			        break;
			    case "Sell":
			        state.change("Sell");
			        break;
				case "Quit":
					oBloop.alarm[0] = 60;
					instance_destroy();
			}
		}
    },
    draw: function() {
      
    }
});

state.add("Buy", {
	enter: function() {
		itemoption = 0;
		firstitem = 0;
		lastitem = 2;
	},
	step: function() {
		#region Item Selection
		if (input_check_pressed("cancel")) {
			if (buying) {
			    buying = false;
				exit;
			}
			if (!buying) {
				state.change("Menu");
			    exit;
			}
		}
		if (input_check_pressed("accept")) {
		    if (!buying) {
				if (buylist[itemoption].owned) {
				    global.equippedrod = itemoption;
				    oFishingMinigame.rod = itemoption;
					oFishingMinigame.combo = 0;
				}
				else {
					buying = true;
				}
				exit;
			}
			if (buying) {
				switch (buyoption) {
					case true:
						if (global.sand >= buylist[itemoption].cost) {
							buying = false;
							buylist[itemoption].owned = true;
							global.sand -= buylist[itemoption].cost;
						}
					    break;
					case false:
					    buying = false;
					    break;
				}
			    exit;
			}
		}
		if (!buying) {
		    itemoption += -input_check_pressed("up") + input_check_pressed("down");
		}
		if (itemoption > array_length(buylist) - 1) {
		    itemoption = 0;
			firstitem = 0;
			lastitem = 2;
		}
		if (itemoption < 0) {
		    itemoption = array_length(buylist) - 1;
			firstitem = array_length(buylist) - 3;
			lastitem = array_length(buylist) - 1;
		}
		if (itemoption > lastitem) {
			firstitem++;
		    lastitem++;
		}
		if (itemoption < firstitem) {
			firstitem--;
		    lastitem--;
		}
		#endregion
		#region Buying
		if (buying and (input_check_pressed("left") or input_check_pressed("right"))) {
		    buyoption = !buyoption;
		}
		#endregion
		whitebg = sine_wave(current_time  / 1250, 1, 0.15, 0.15);
    },
    draw: function() {
	    draw_sprite_ext(sHudShopNew, 0, GW - 50, 100, 45, 36, 0, c_white, 1);
		scribble($"[fa_middle][fa_center]{shopname}").scale(4).draw(GW - 50 - (sprite_get_width(sHudShopNew) * 45 / 2), 140);
		var _x = GW - 50 - (sprite_get_width(sHudShopNew) * 45 / 2);
		var _y = 220;
		var _offset = 0;
		var _currentbuying = false;
		for (var i = firstitem; i <= lastitem; ++i) {
			if (itemoption == i) {
				draw_set_alpha(whitebg);
			    draw_rectangle(_x - 460, _y - 42 + _offset, _x + 505, _y + 125 + _offset, false);
				draw_set_alpha(1);
				if (buying) {
				    var opt = ["Back", "Buy"];
					var _bboffset = 142;
					scribble($"[fa_center][fa_middle][c_yellow]{lexicon_text("ShopOptions.Sure")}").scale(2).draw(_x, _y + 30 + _offset);
					draw_sprite_ext(sHudButton, buyoption == 0 ? 1 : 0, _x + _bboffset, _y + 65 + _offset, 1.25, 1.50, 0, c_white, 1);
					scribble($"[fa_center][fa_middle][{buyoption == 0 ? "c_black" : "c_white"}]{lexicon_text("ShopOptions.Back")}").scale(2).draw(_x + _bboffset, _y + 67 + _offset);
					draw_sprite_ext(sHudButton, buyoption == 1 ? 1 : 0, _x - _bboffset, _y + 65 + _offset, 1.25, 1.50, 0, c_white, 1);
					scribble($"[fa_center][fa_middle][{buyoption == 1 ? "c_black" : "c_white"}]{lexicon_text("ShopOptions.Buy")}").scale(2).draw(_x - _bboffset, _y + 67 + _offset);
					var _currentbuying = true;
				}
			}
			draw_sprite_ext(sItemSquare, 0, _x - 420, _y + _offset, 2, 2, 0, c_white, 1);
			draw_sprite_ext(buylist[i].icon, 0, _x - 420, _y + _offset, 2, 2, 0, c_white, 1);
			scribble($"[c_yellow]{buylist[i].name} {oFishingMinigame.rod == i ? "[[EQUIPPED]" : ""}\n[c_white]{!_currentbuying ? lexicon_text("Rods." + buylist[i].name) + ".desc" : ""}").scale(2).wrap(880).draw(_x - 376, _y - 32 + _offset);
			scribble($"[fa_right][c_yellow]{buylist[i].owned ? "BOUGHT" : "Cost: [c_white][sSand][c_yellow] " + string(buylist[i].cost)}").scale(2).draw(_x + 500, _y - 32 + _offset);
			_offset += 215;
			_currentbuying = false;
		}
    }
});

state.add("Sell", {
	enter: function() {
		itemoption = 0;
		firstitem = 0;
		lastitem = 7;
	},
	step: function() {
		#region Item Selection
		if (input_check_pressed("cancel")) {
			if (selling) {
			    selling = false;
				exit;
			}
			if (!selling) {
				state.change("Menu");
			    exit;
			}
		}
		if (input_check_pressed("accept")) {
		    if (!selling) {
			    selling = true;
				exit;
			}
			if (selling) {
				var _sellval = 0;
				for (var i = 0; i < array_length(sellamount); ++i) {
					if (i > array_length(selllist) - 1) { break; }
				    _sellval += ((selllist[i].cost) * (selllist[i].golden ? 100 : 1)) * sellamount[i];
					selllist[i].amount -= sellamount[i];
					sellamount[i] = 0;
				}
				global.sand += _sellval;
			    exit;
			}
		}
		if (!selling and array_length(selllist) > 0) {
			sellamount[itemoption] += -input_check_pressed("left") + input_check_pressed("right");
			if (sellamount[itemoption] < 0) {
				sellamount[itemoption] = selllist[itemoption].amount;
			}
			if (sellamount[itemoption] > selllist[itemoption].amount) {
				sellamount[itemoption] = 0;
			}
			if (array_length(selllist) > 1) {
				itemoption += -input_check_pressed("up") + input_check_pressed("down");
			}
		}
		if (itemoption > array_length(selllist) - 1) {
		    itemoption = 0;
			firstitem = 0;
			lastitem = 7;
		}
		if (itemoption < 0) {
		    itemoption = clamp(array_length(selllist) - 1, 0, 99);
			firstitem = array_length(selllist) - 8;
			lastitem = array_length(selllist) - 1;
		}
		if (itemoption > lastitem) {
			firstitem++;
		    lastitem++;
		}
		if (itemoption < firstitem) {
			firstitem--;
		    lastitem--;
		}
		if (lastitem > array_length(selllist) - 1) { //Todo: Remove
		    lastitem = clamp(array_length(selllist) - 1, 0, 99);
		}
		#endregion
		whitebg = sine_wave(current_time  / 1250, 1, 0.15, 0.15);
    },
    draw: function() {
	    draw_sprite_ext(sHudShopNew, 0, GW - 50, 100, 45, 36, 0, c_white, 1);
		scribble($"[fa_middle][fa_center]{shopname}").scale(4).draw(GW - 50 - (sprite_get_width(sHudShopNew) * 45 / 2), 140);
		var _x = GW - 50 - (sprite_get_width(sHudShopNew) * 45 / 2);
		var _y = 200;
		var _offset = 0;
		draw_rectangle(_x - 485, _y + 520, _x + 500, _y + 520 + 3, false);
		if (selling) {
			draw_set_alpha(whitebg);
			draw_rectangle(_x - 480, _y + 530, _x + 505, _y + 530 + 75, false);
			draw_set_alpha(1);
			draw_sprite_ext(sHoloCursor, 1, _x - 510, _y + 570, 2, 2, 0, c_white, 1);
		}
		draw_sprite_ext(sHudButton, 1, _x - 370, _y + 570, 1, 1.75, 0, c_white, 1);
		scribble($"[fa_center][fa_middle][c_black]{lexicon_text("ShopOptions.Sell")}").scale(2).draw(_x - 370, _y + 572);
		scribble($"[fa_center][fa_middle]Sale Total :").scale(2.5).draw(_x, _y + 572);
		var _sellval = 0;
		for (var i = 0; i < array_length(sellamount); ++i) {
			if (i > array_length(selllist) - 1) { break; }
		    _sellval += ((selllist[i].cost) * (selllist[i].golden ? 100 : 1)) * sellamount[i];
		}
		draw_rectangle(_x + 100, _y + 535, _x + 480, _y + 525 + 75, true);
		scribble($"[fa_right][fa_middle]{_sellval}").scale(3).draw(_x + 460, _y + 572);
		var _min = array_length(selllist) > 7 ? firstitem : 0;
		var _max = array_length(selllist) > 7 ? lastitem : array_length(selllist) - 1;
		for (var i = _min; i <= _max; ++i) {
			var _alpha = 1;
			if (array_length(selllist) == 0) {
				break;
			}
			if (array_length(selllist) > 7) {
				if (lastitem > array_length(selllist) -1) { lastitem = array_length(selllist) - 1; }
				if (array_length(selllist) == 1) { break; }
				if (i > array_length(selllist) - 1) { break; }
			}
			if (itemoption == i and !selling) {
				draw_set_alpha(whitebg);
			    draw_rectangle(_x - 480, _y - 30 + _offset, _x + 505, _y + 30 + _offset, false);
				draw_set_alpha(1);
				draw_sprite_ext(sHoloCursor, 0, _x - 510, _y + _offset, 2, 2, 0, c_white, 1);
			}
			if (selllist[i].amount == 0) {
				draw_set_alpha(0.5);
				_alpha = 0.5;
			}
			draw_sprite_ext(selllist[i].icon, selllist[i].golden ? 1 : 0, _x - 450, _y + _offset, 2, 2, 0, c_white, _alpha);
			scribble($"{selllist[i].name}").scale(2).draw(_x - 410, _y - 8 + _offset);
			scribble($"[fa_center]<{sellamount[i]} / {selllist[i].amount}>").scale(2).draw(_x, _y - 8 + _offset);
			scribble($"[sSand] {(selllist[i].cost) * (selllist[i].golden ? 100 : 1)}").scale(2).draw(_x + 150, _y - 8 + _offset);
			scribble($"[fa_right]{((selllist[i].cost) * (selllist[i].golden ? 100 : 1)) * sellamount[i]}").scale(2).draw(_x + 465, _y - 8 + _offset);
			draw_set_alpha(1);
			_offset += 65;
		}
    }
});