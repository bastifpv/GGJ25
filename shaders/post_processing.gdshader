shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

void fragment() {
    // Calculate UV coordinates
	vec2 uv = SCREEN_UV;
    // Offset the UV coordinates based on a sine wave
    uv.x += sin(SCREEN_UV.y * 2.0 + TIME) * 0.003; // Adjust the frequency and amplitude as needed
    uv.y += sin(SCREEN_UV.x * 2.0 + TIME) * 0.003;

    // Sample the texture using the modified UV coordinates
    COLOR = texture(screen_texture, uv);
}