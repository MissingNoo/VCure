//gameWindow();
view_enabled = true;
view_visible[0] = true;
wport = 640;
hport = 360;
if (os_type == os_android) {
	wport = display_get_width()/3;
	hport = display_get_height()/3;
}
view_camera[0] = camera_create_view(0, 0, wport, hport, 0, oCamWorld, -1, -1, infinity, infinity);
zoom_level = 1;
//Get the starting view size to be used for interpolation later
default_zoom_width = camera_get_view_width(view_camera[0]);
default_zoom_height = camera_get_view_height(view_camera[0]);