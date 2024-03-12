function psycho_axe_step(){
	x = xxstart + lengthdir_x(round(orbitLength), round(orbitPlace));
	y = yystart + lengthdir_y(round(orbitLength), round(orbitPlace));
	orbitPlace -= 4;
	orbitLength += 0.75;
	image_angle += 10;
}
function blbook_step(){
	x = owner.x + lengthdir_x(orbitLength, round(orbitPlace));
	y = owner.y - 16 + lengthdir_y(orbitLength, round(orbitPlace));
	orbitPlace-=spinningSpeed;
}
function blfujoshibook_step(){
	orbitLength = 100;
	x = owner.x + lengthdir_x(orbitLength, round(orbitPlace));
	y = owner.y - 16 + lengthdir_y(orbitLength, round(orbitPlace));
	orbitPlace -= 8;
}
function blfujoshiaxe_step(){
	orbitLength = 190;
	x = owner.x + lengthdir_x(orbitLength, round(orbitPlace));
	y = owner.y - 16 + lengthdir_y(orbitLength, round(orbitPlace));
	orbitPlace -= 10;
	//orbitPlace = oGui.f;
}
function stream_of_tears(){
	if (shoots == -1) {
		x = owner.x + lengthdir_x(16, round(orbitPlace));
		y = owner.y + lengthdir_y(16, round(orbitPlace));
		orbitPlace += 2 * Delta;
		image_angle = point_direction(owner.x, owner.y, x, y);
	}
	else{
		x = owner.x - lengthdir_x(16, round(orbitPlace));
		y = owner.y - lengthdir_y(16, round(orbitPlace));
		orbitPlace += 2 * Delta;
		image_angle = point_direction(owner.x, owner.y, x, y);
	}
}
function  absolute_wall(){
	
}