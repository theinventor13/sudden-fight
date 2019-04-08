if(mouse_check_button(mb_left) && b_timer <= 0){
	
		b_temp = instance_create_depth(x + 10, y + 10, -1000, bullet);
		angle = arctan2(p_cursor.x - x, p_cursor.y - y);
		if(angle < 0){
			angle += pit2;
		}
		b_temp.direction = (radtodeg(angle) - 90 + random_range(-360 * b_aimfudge, 360 * b_aimfudge));
		b_temp.speed = b_speed;
		b_temp.image_speed = 1;
		b_timer = b_delay;
		
		b_temp = instance_create_depth(x - 10, y + 10, -1000, bullet);
		angle = arctan2(p_cursor.x - x, p_cursor.y - y);
		if(angle < 0){
			angle += pit2;
		}
		b_temp.direction = (radtodeg(angle) - 90 + random_range(-360 * b_aimfudge, 360 * b_aimfudge));
		b_temp.speed = b_speed;
		b_temp.image_speed = 1;
		b_timer = b_delay;
		
		b_temp = instance_create_depth(x + 10, y - 10, -1000, bullet);
		angle = arctan2(p_cursor.x - x, p_cursor.y - y);
		if(angle < 0){
			angle += pit2;
		}
		b_temp.direction = (radtodeg(angle) - 90 + random_range(-360 * b_aimfudge, 360 * b_aimfudge));
		b_temp.speed = b_speed;
		b_temp.image_speed = 1;
		b_timer = b_delay;
		
		b_temp = instance_create_depth(x - 10, y - 10, -1000, bullet);
		angle = arctan2(p_cursor.x - x, p_cursor.y - y);
		if(angle < 0){
			angle += pit2;
		}
		b_temp.direction = (radtodeg(angle) - 90 + random_range(-360 * b_aimfudge, 360 * b_aimfudge));
		b_temp.speed = b_speed;
		b_temp.image_speed = 1;
		b_timer = b_delay;
}

vx = x - oldx;
vy = y - oldy;
x = oldx;
y = oldy;

if(vx > 0){
	xside = bbox_right;
	h1 = (tilemap_get_at_pixel(t_map, xside+ceil(vx), bbox_bottom) & tile_index_mask) != 0;
	h2 = (tilemap_get_at_pixel(t_map, xside+ceil(vx), bbox_top) & tile_index_mask) != 0;
}else{
	xside = bbox_left;
	h1 = (tilemap_get_at_pixel(t_map, xside+vx, bbox_bottom) & tile_index_mask) != 0;
	h2 = (tilemap_get_at_pixel(t_map, xside+vx, bbox_top) & tile_index_mask) != 0;
}

if(vy > 0){
	yside = bbox_bottom;
	v1 = (tilemap_get_at_pixel(t_map, bbox_right, yside+ceil(vy)) & tile_index_mask) != 0;
	v2 = (tilemap_get_at_pixel(t_map, bbox_left, yside+ceil(vy)) & tile_index_mask) != 0;
}else{
	yside = bbox_top;
	v1 = (tilemap_get_at_pixel(t_map, bbox_right, yside+vy) & tile_index_mask) != 0;
	v2 = (tilemap_get_at_pixel(t_map, bbox_left, yside+vy) & tile_index_mask) != 0;
}



if(h1 || h2){
	if vx > 0 x = x - (x mod 16) + 15 - (bbox_right - x);
	else x = x - (x mod 16) - (bbox_left - x);
	vx = 0;
}

x += vx;

if(v1 || v2){
	if vy > 0 y = y - (y mod 16) + 15 - (bbox_bottom - y);
	else y = y - (y mod 16) - (bbox_top - y);
	vy = 0;
}
	
y += vy;
