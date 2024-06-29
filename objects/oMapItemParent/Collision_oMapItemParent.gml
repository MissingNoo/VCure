if (!cancollide) {
    exit;
}
if (other.x == x or other.y == y) {
	other.cancollide = false;
    instance_destroy();
}