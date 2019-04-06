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
