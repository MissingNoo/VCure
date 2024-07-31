var _offset = fishing ? sprite_get_height(sprite_index) / 2 : 0;
oCamWorld.x += (oPlayerWorld.x - oCamWorld.x) / 16;
oCamWorld.y += ((oPlayerWorld.y - _offset) - oCamWorld.y) / 16;
