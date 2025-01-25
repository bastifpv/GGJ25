shader_type spatial;

uniform sampler2D surface_noise_texture;
uniform float height_multiplier = 0.1;
uniform float noise_sample_size = 0.5;
uniform float animation_speed = 0.05;

instance uniform vec4 bubble_color : source_color;

varying float height;

void vertex() {
	height = texture(surface_noise_texture, VERTEX.xz * noise_sample_size + vec2(TIME) * animation_speed).r * height_multiplier;
	VERTEX += NORMAL * height;
}

float fresnel(vec3 normal, mat4 camera_matrix) {
	vec3 view_direction_world = (camera_matrix * vec4(0.0, 0.0, 1.0, 0.0)).xyz;
	vec3 normal_world = (camera_matrix * vec4(normal, 0.0)).xyz;
	float d = dot(view_direction_world, normal_world);
	d = abs(d);
	d = clamp(d, 0.0, 1.0);
	
	return 1.0 - d;
}

void fragment() {
	ROUGHNESS = mix(0.05, 0.1, 1.0 - height);
	SPECULAR = height;
	ALPHA = fresnel(NORMAL, INV_VIEW_MATRIX);
	ALBEDO = bubble_color.rgb;
}