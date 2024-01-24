if (!variable_instance_exists(other, "dudehittedcooldown")) {
    other.dudehittedcooldown = 0;
}
var cooldownOver = false;
if (other.dudehittedcooldown < global.currentFrame) {
    cooldownOver = true;
}
if (cooldownOver and !global.gamePaused and other.image_alpha == 1 and !other.infected) {
	other.dudehittedcooldown = global.currentFrame + 7;
	other.damaged = true;
	other.hp -= 10;
}