dx = 0.0;
dy = 0.0;
moved = false;

if(keyboard_check(ord("D"))){
	dx = 1;
	moved = true;
}

if(keyboard_check(ord("A"))){
	dx = -1;
	moved = true;
}

if(keyboard_check(ord("S"))){
	dy = 1;
	moved = true;
}

if(keyboard_check(ord("W"))){
	dy = -1;
	moved = true;
}
//add joystick input
if(moved){
	
	direction = arctan2(dy, dx); //calculate player direction
	if(direction < 0){
		direction += 2 * pi; //adjust for atan2 faggotry
	}
	direction = radtodeg(pit2 - direction); //set builtin
	
	if(keyboard_check(vk_lshift)){
		speed = p_dash_speed;
		image_speed = p_dash_speed;
	}else{
		speed = p_run_speed;
		image_speed = p_run_speed;
	}
	//calculate animation direction
	if(direction < (270 + dd16) && direction >= (180 + dd16)){
		//down
		s_dir = 0;
	}
	
	if(direction < (360 - dd16) && direction >= (270 + dd16)){
		//down right
		s_dir = 1;
	}
	
	if((direction < dd16 && direction >= 0) || (direction > (360 - dd16))){
		//right
		s_dir = 2;
	}
	
	if(direction < (45 + dd16) && direction >= dd16){
		//up right
		s_dir = 3;
	}
	
	if(direction < (90 + dd16) && direction >= (45 + dd16)){
		//up 
		s_dir = 4;
	}
	
	if(direction < (135 + dd16) && direction >= (90 + dd16)){
		//up left
		s_dir = 5;
	}
	
	if(direction < (180 + dd16) && direction >= (135 + dd16)){
		//left
		s_dir = 6;
	}
	
	if(direction < (270 - dd16) && direction >= (180 + dd16)){
		//down left
		s_dir = 7;
	}
	
}else{
	image_speed = p_idle_speed;
	speed = 0;
}

if(moved){
	sprite_index = s_run[s_dir];
}else{
	sprite_index = s_idle[s_dir];
}

if(b_timer > 0){
	b_timer -= delta_time;	
}




