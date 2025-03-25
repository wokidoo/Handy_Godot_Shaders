// Converts non-linear depth to linear depth
float linear_depth(float depth, float near, float far) {
    return near * far / (far + depth * (near - far));
}

float view_space_depth(vec2 scree_uv, float depth, mat4 inv_projection_matrix){
	vec4 view_space_depth = inv_projection_matrix * vec4(scree_uv * 2.0 - 1.0, depth, 1.0);
	view_space_depth.xyz /= view_space_depth.w;
	return view_space_depth.z;
}

// Computes proximity of the fragment to a given position
float proximity(float fragment_depth, float scene_depth, float fade_distance) {
    return clamp(smoothstep(fragment_depth + fade_distance,fragment_depth,scene_depth),0.0,1.0);
}
