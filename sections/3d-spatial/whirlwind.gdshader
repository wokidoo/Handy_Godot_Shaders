shader_type spatial;
render_mode 
		cull_disabled,
		depth_prepass_alpha,
		unshaded,
		blend_mix;

uniform float size = 0.0;

group_uniforms color;
uniform vec3 whirl_color_1 : source_color;
uniform vec3 whirl_color_2 : source_color;
uniform float effect_intensity = 2.0;
group_uniforms;

group_uniforms noise;
uniform float noise_ratio : hint_range(0.0, 1.0) = 0.5;
uniform sampler2D noise_tex_1 : repeat_enable;
uniform sampler2D noise_tex_2 : repeat_enable;
uniform vec2 noise_offset_1 = vec2(0.1,0.0);
uniform vec2 noise_offset_2 = vec2(0.1,0.0);
uniform float effect_opacity : hint_range(0.0, 1.0) = 0.5;
group_uniforms;

group_uniforms shape;
uniform float effect_height : hint_range(0.0, 1.0) = 0.5 ;
uniform float effect_height_range :hint_range(0.0, 1.0) = 0.1;
uniform float effect_edge_opacity : hint_range(0.0, 1.0) = 0.5;
group_uniforms;

void vertex(){
	VERTEX += NORMAL*size;
}

void fragment(){
	
	float front_facing = 1.0;
	vec4 noise_color = mix(
			texture(noise_tex_1,UV+(noise_offset_1*TIME*front_facing)), 
			texture(noise_tex_2,UV+(noise_offset_2*TIME*front_facing)),
			noise_ratio);
	
	float effect_factor = 
		step(effect_height-effect_height_range,UV.y) *
		step(UV.y,effect_height+effect_height_range) * 
		smoothstep(effect_height-(effect_height_range+effect_height_range)*effect_edge_opacity,effect_height,UV.y) *
		smoothstep(effect_height+(effect_height_range+effect_height_range)*effect_edge_opacity,effect_height,UV.y) *
		step(effect_opacity,noise_color.r);
		
	float final_alpha = noise_color.r*abs(effect_intensity)*effect_factor;
	ALPHA = clamp(0.0,1.0,final_alpha);
	
	vec3 final_color = mix(whirl_color_2,whirl_color_1,float(FRONT_FACING));
	ALBEDO = (final_color*noise_color.rgb);
}