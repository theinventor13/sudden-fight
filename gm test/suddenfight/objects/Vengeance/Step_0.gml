dirx = 0.0;
diry = 0.0;

if(keyboard_check(ord("D"))){
	dirx = 1;
}

if(keyboard_check(ord("A"))){
	dirx = -1;
}

if(keyboard_check(ord("S"))){
	diry = 1;
}

if(keyboard_check(ord("W"))){
	diry = -1;
}
//change this to work with angle
if(dirx == 0 && diry == 1){
	//down
	sprite_index = vengeance_run_down;
}
if(dirx == 1 && diry == 1){
	//down right
	sprite_index = vengeance_run_down_right;
}
if(dirx == 1 && diry == 0){
	//right
	sprite_index = vengeance_run_right;
}
if(dirx == 1 && diry == -1){
	//up right
	sprite_index = vengeance_run_up_right;
}
if(dirx == 0 && diry == -1){
	//up 
	sprite_index = vengeance_run_up;
}
if(dirx == -1 && diry == -1){
	//up left
	sprite_index = vengeance_run_up_left;
}
if(dirx == -1 && diry == 0){
	//left
	sprite_index = vengeance_run_left;
}
if(dirx == -1 && diry == 1){
	//down left
	sprite_index = vengeance_run_down_left;
}

var tm = dirx * dirx + diry * diry;
tm = sqrt(tm);
dirx = (dirx / tm) * run_speed;
diry = (diry / tm) * run_speed;
x += dirx;
y += diry;
show_debug_message("hello: ")


