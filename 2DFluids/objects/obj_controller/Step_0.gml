///@desc Update particles

//Toggle debug info
if keyboard_check_pressed(ord("1")) debug = !debug;

//Create 10 particles at the mouse with left-click
if mouse_check_button(mb_left) 
{
	repeat(10)
	{
		var _px,_py;
		_px = mouse_x+random(20)-10;
		_py = mouse_y+random(20)-10;
		
		physics_particle_create(global.water_flags,_px,_py,0,0,color,1,1);
	}
}
//Erase particles with right-click
if mouse_check_button(mb_right) 
{
	physics_particle_delete_region_circle(mouse_x,mouse_y,64);
}

//Randomize color with middle-click
if mouse_check_button(mb_middle) color = make_color_hsv(irandom(255),255,255);


//Remove one particle for every 4000 particles:
var _steps = floor(physics_particle_count()/4000);
//This creates a soft particle limit, where more particles means faster removal
repeat(_steps)
{
	//Select a random particle
	var _part = irandom(physics_particle_count());
	//And delete it
	physics_particle_delete(_part);
}


//Update resolution
var _w,_h;
_w = window_get_width();
_h = window_get_height();
//Update surface only when we detect a change!
if (res_w != _w) || (res_h != _h)
{
	res_w = _w;
	res_h = _h;
	surface_resize(application_surface,res_w,res_h);
}
//End game with escape key
if keyboard_check(vk_escape) game_end();