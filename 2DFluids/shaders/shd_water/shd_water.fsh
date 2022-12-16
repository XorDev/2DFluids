varying vec4 v_vColor;
varying vec2 v_vTexcoord;

//Pass in water surface
uniform sampler2D u_surf_water;
//Texel size
uniform vec2 u_texel;

//Sample offset for displacement (in pixels) 
#define OFFSET 4.0
//Displacement intensity (in pixels)
#define DISPLACEMENT 8.0
//Screen refraction intensity (0.01 = 1%)
#define REFRACT 0.01

void main()
{
	//Sample the water surface
	vec4 water = texture2D(u_surf_water, v_vTexcoord);
	//Sample offsets in the 4 directions
	float water_l = texture2D(u_surf_water, v_vTexcoord - vec2(OFFSET, 0.0)*u_texel).a;
	float water_r = texture2D(u_surf_water, v_vTexcoord + vec2(OFFSET, 0.0)*u_texel).a;
	float water_u = texture2D(u_surf_water, v_vTexcoord - vec2(0.0, OFFSET)*u_texel).a;
	float water_d = texture2D(u_surf_water, v_vTexcoord + vec2(0.0, OFFSET)*u_texel).a;
	
	//Compute new contrasted alpha value
	float alpha = smoothstep(0.7,0.8, pow(water.a,2.0));
	//Compute displacement vector
	vec2 disp = vec2(water_l - water_r, water_u - water_d) * DISPLACEMENT;
	//Add displacement and fake refraction to texture coordinates
	vec2 coord = v_vTexcoord + (disp * u_texel - (v_vTexcoord - 0.5) * REFRACT) * alpha;
	//Sample displaced base color 
	vec4 col = texture2D(gm_BaseTexture, coord);
	//Blend with water using water alpha
	col.rgb = mix(col.rgb, col.rgb * water.rgb, alpha);
	
	//Output resulting color
    gl_FragColor = v_vColor * col;
}