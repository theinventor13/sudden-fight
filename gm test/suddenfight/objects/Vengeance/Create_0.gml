
//GLOBAL STUFF
image_speed = 1;
p_cursor = instance_create_depth(x, y, -1000, cursor);
p_idle_speed = .4;
p_run_speed = 1;
p_dash_speed = 1.5;
l_id = layer_get_id("collision_map");
t_map = layer_tilemap_get_id(l_id);
//SPRITE STUFF
//used for sprite direction calculation
dd16 = 360 / 16;
pit2 = pi * 2;
//sprite direction
//543
//6*2
//701
s_dir = 0;
//sprite anims
s_idle[0] = vengeance_idle_down;
s_idle[1] = vengeance_idle_down_right;
s_idle[2] = vengeance_idle_right;
s_idle[3] = vengeance_idle_up_right;
s_idle[4] = vengeance_idle_up;
s_idle[5] = vengeance_idle_up_left;
s_idle[6] = vengeance_idle_left;
s_idle[7] = vengeance_idle_down_left;
s_run[0] = vengeance_run_down;
s_run[1] = vengeance_run_down_right;
s_run[2] = vengeance_run_right;
s_run[3] = vengeance_run_up_right;
s_run[4] = vengeance_run_up;
s_run[5] = vengeance_run_up_left;
s_run[6] = vengeance_run_left;
s_run[7] = vengeance_run_down_left;
//SPRITE STUFF

//BULLET STUFF
b_speed = 3;
b_aimfudge = 1/60;
b_timer = 0;
b_temp = 0;
b_delay = 1000000 * .05;
//BULLET STUFF