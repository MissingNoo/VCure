if (variable_instance_exists(self, "step") and beginStep) {
	beginStep = false;
    step(WeaponEvent.BeginStep);
}