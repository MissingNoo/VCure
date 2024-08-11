function idolsong_create(obj){
	if (obj.idolDir == 90 and obj.shoots == -1) {
		obj.idolDir = 270;
		obj.idolStartX= obj.owner.x + 20;
		obj.direction = obj.idolDir;
	}else{
		obj.idolDir = 90;
		obj.idolStartX= obj.owner.x - 20;
		obj.direction = obj.idolDir;
	}
}
function idolsong_step(obj){
	    obj.x = sine_wave(current_time  / 1000, 1 * (obj.shoots % 2) ? 1 : -1, obj.upg[$ "travelWidth"], obj.idolStartX);
}