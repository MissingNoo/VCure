if (sprite_index == sSmolAmeGroundpound) {
	image_index = 0;
    sprite_index = sSmolAme;
	groundPoundTimer = 8;
	goingDownTimer = 0;
	groundPounding = false;
	goingDown = false;
}
if (sprite_index == sSmolAmeJump) {
	image_alpha = .99;
	if (ametp) {
	    ametp = false;
		x = target.x;
		y = target.y;
	}
	image_index = 18;
	if (goingDownTimer < 0) {
		goingDownTimer = 0;
	    sprite_index = sSmolAmeGroundpound;
		ametp = true;
		if (collision_circle(x, y, 80, oPlayer, false, true)) {
			HP -= damage_calculation(atk * 1.5);
		}
		if (global.screenShake) {
			oGame.shakeMagnitude=6;
		}
		goingDown = false;
	}    
}