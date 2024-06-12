if (keyboard_check_pressed(vk_home)) {
    show = !show;
}
var _updown = - mouse_wheel_up() + mouse_wheel_down();
page += _updown;
if (page < 0) {
    page = 0;
}
if (page > array_length(pagenames) - 1) {
    page = array_length(pagenames) - 1;
}