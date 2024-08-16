if (!fall){
    y -= amnt;
    if (y < ystart - 20) {
        fall = true;
    }
}
else {
    amnt = lerp(amnt, -0.20, 0.15);
    y -= amnt;
}
hspeed = 0.40 * oPlayer.image_xscale;
image_alpha -= 0.03;
if (image_alpha <= 0) {
    instance_destroy();
}
