var _updown = - input_check_pressed("up") + input_check_pressed("down");
var _leftright = - input_check_pressed("left") + input_check_pressed("right");
if (ANVIL) {
	if (anvilconfirm) { return; }
	anvilSelected += _leftright;
	if (anvilSelected < 0) { anvilSelected = 5; }
	if (anvilSelected > 5) { anvilSelected = 0; }
	anvilSelectedCategory += _updown;
	if (anvilSelectedCategory < 0) { anvilSelectedCategory = 0; }
	if (anvilSelectedCategory > 1) { anvilSelectedCategory = 1; }	
}