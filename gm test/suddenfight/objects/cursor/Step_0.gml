if(init){
	x += window_mouse_get_x() - (window_get_width() / 2);
	y += window_mouse_get_y() - (window_get_height() / 2);
}else{
	init = true;
}
//clamp cursor to viewport extents
x = clamp(x, camera_get_view_x(view_camera[0]), camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0]))
y = clamp(y, camera_get_view_y(view_camera[0]), camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0]))
window_mouse_set((window_get_width() / 2), (window_get_height() / 2));
