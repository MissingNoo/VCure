//if (keyboard_check_pressed(vk_home)) {
//		    show_message_async(HouseInventory[HouseCategory.Interior]);
//		}
if (global.gamePaused) { return; }
if (instance_exists(oNpcShop) or instance_exists(oBloopShop) or (instance_exists(oHouseManager) and oHouseManager.editHouse) or fishing or instance_exists(oFishPrize) or !canMove) { return; }
Movement();
image_speed = global.gamePaused ? 0 : 1;