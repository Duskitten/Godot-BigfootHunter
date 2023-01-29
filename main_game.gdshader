shader_type spatial;
uniform sampler2D tex_frg_3 : source_color, filter_nearest;
uniform sampler2D tex_frg_9 : source_color, filter_nearest;
uniform sampler2D tex_frg_4 : source_color, filter_nearest;



void fragment() {
// Input:6
	vec2 n_out6p0 = UV;


// VectorOp:7
	vec3 n_in7p1 = vec3(800.00000, 800.00000, 800.00000);
	vec3 n_out7p0 = vec3(n_out6p0, 0.0) * n_in7p1;


// Texture2D:3
	vec4 n_out3p0 = texture(tex_frg_3, vec2(n_out7p0.xy));


// Texture2D:9
	vec4 n_out9p0 = texture(tex_frg_9, vec2(n_out7p0.xy));


// Texture2D:4
	vec4 n_out4p0 = texture(tex_frg_4, UV);


// Mix:5
	vec3 n_out5p0 = mix(vec3(n_out3p0.xyz), vec3(n_out9p0.xyz), vec3(n_out4p0.xyz));


// Output:0
	ALBEDO = n_out5p0;
	ROUGHNESS = float(1.0);
	METALLIC = float(0);
	SPECULAR = float(0);
}
