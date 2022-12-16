///@desc Flowing water

repeat(flow_rate)
{
	var _px,_py;
	_px = irandom_range(bbox_left,bbox_right);
	_py = irandom_range(bbox_top,bbox_bottom);
	
	physics_particle_create(global.water_flags,_px,_py,0,0,image_blend,1,1);
}