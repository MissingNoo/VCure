if (variable_instance_exists(self, "step")) {
    step(WeaponEvent.Draw);
}
else {
	draw_self();
}