function psycho_axe_create(obj){
	obj.orbitoffset = 0;
	obj.orbitLength = 0;
	obj.xxstart = obj.xstart;
	obj.yystart = obj.ystart;
}
function psycho_axe_step(obj){
	obj.x = obj.xxstart + lengthdir_x(round(obj.orbitLength), round(obj.orbitPlace));
	obj.y = obj.yystart + lengthdir_y(round(obj.orbitLength), round(obj.orbitPlace));
	obj.orbitPlace -= 4;
	obj.orbitLength += 0.75;
	obj.image_angle += 10;
}