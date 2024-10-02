var difficulty = sCaught1;
switch (currentDifficulty) {
    case 0:
    case 1:
        difficulty = sCaught1;
        break;
    case 2:
    case 3:
        difficulty = sCaught2;
        break;
    case 4:
        difficulty = sCaught3;
        break;
    case 5:
        difficulty = sCaught4;
        break;
}
instance_create_depth(oPlayerWorld.x, oPlayerWorld.y - 60, -1000, oVFX, {sprite_index : difficulty});
alarm[4] = 80;