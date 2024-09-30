var screenAspect = window_get_width() / window_get_height();
var h = display_get_gui_height();
var w = display_get_gui_width();
var aspect = w / h;
while (aspect < screenAspect) {
	h-=.1;	
	aspect = w / h;
}
while (aspect > screenAspect) {
	w-=.1;
	aspect = w / h;
}
var zoom = 2;
display_set_gui_size(w,h);
display_set_gui_size(w/(aspect/zoom), display_get_gui_height()/(aspect/zoom));
GW = display_get_gui_width();
GH = display_get_gui_height();