shader_type spatial;

uniform vec4 shield_color_1 : source_color;
uniform vec4 shield_color_2 : source_color;
uniform float size = 0.1;
uniform float intensity = 0.1;
uniform sampler2D noise_tex : repeat_enable;
uniform vec2 noise_offset = vec2(0.0,0.1);
uniform float noise_pct : hint_range(0.0, 1.0) = 0.1;
uniform float noise_intensity = 0.1;

void vertex() {
    VERTEX += NORMAL*size;
}

void fragment() {
    vec4 noise_color = texture(noise_tex,UV+noise_offset*TIME);
    ALBEDO = mix(shield_color_1.rgb,shield_color_2.rgb,dot(NORMAL,VIEW));
    ALBEDO *= (smoothstep(1.0,noise_color.r*noise_intensity,noise_pct) + 1.0);
    ALPHA = clamp(smoothstep(intensity,0.0,dot(NORMAL,VIEW)),0.0,1.0);

}