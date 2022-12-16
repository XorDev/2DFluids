///@desc Draw water

//Make sure the water surface exists!
if !surface_exists(surf_water) surf_water = surface_create(room_width,room_height);

//Draw water particles to surface
surface_set_target(surf_water);
draw_clear_alpha(0,0);
//This blendmode fixes the darkness when alpha blending particles
gpu_set_blendmode_ext_sepalpha(bm_src_alpha,bm_inv_src_alpha,bm_one,bm_one);

//Draw particles
physics_particle_draw(global.water_flags, 1, spr_water, 0);

gpu_set_blendmode(bm_normal);
surface_reset_target();

//Draw application surface with water shader
gpu_set_tex_filter(true);
shader_set(shd_water);
texture_set_stage(u_surf_water, surface_get_texture(surf_water));
shader_set_uniform_f(u_texel, 1/room_width, 1/room_height);
draw_surface(application_surface,0,0);
shader_reset();

//Draw debug information
if (debug)
{
	draw_text(8,8,"FPS: " + string(fps));
	draw_text(8,32,"Count: " + string(physics_particle_count()));
}
//Reset texture filtering
gpu_set_tex_filter(false);