if (sprite_index == sSmolAmeGroundpound) {
	image_index = 0;
    sprite_index = sSmolAme;
	groundPoundTimer = 10;
	goingDownTimer = 0;
	groundPounding = false;
	goingDown = false;
	if (collision_circle(x, y, 80, oPlayer, false, true)) {
	    HP -= damage_calculation(atk * 1.5);
	}
	if (global.screenShake) {
		oGame.shakeMagnitude=6;
	}
}
if (sprite_index == sSmolAmeJump) {
	image_index = 0;
	image_index = 18;
	image_alpha = .99;
	if (ametp) {
	    ametp = false;
		x = target.x;
		y = target.y;
	}
	if (goingDownTimer < 0) {
		goingDownTimer = 0;
	    sprite_index = sSmolAmeGroundpound;
		goingDown = false;
	}    
}