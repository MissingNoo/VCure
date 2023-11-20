if (ach == -1) { exit; }
if (!Achievements[ach].unlocked) {
    Achievements[ach].unlocked = true;
}
alpha -= .005;
if (alpha <= 0) {
    instance_destroy();
}