///@desc Initialize

res_w = window_get_width();
res_h = window_get_height();

surface_resize(application_surface,res_w,res_h);
application_surface_draw_enable(false);

debug = false;

draw_set_font(fnt_main);
draw_set_color(c_black);

surf_water = -1;

u_surf_water = shader_get_sampler_index(shd_water, "u_surf_water");
u_texel = shader_get_uniform(shd_water, "u_texel");

global.water_flags = phy_particle_flag_water | phy_particle_flag_colourmixing;
color = -1;

physics_particle_set_max_count(24000);
physics_particle_set_radius(4);