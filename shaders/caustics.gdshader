shader_type spatial;

uniform int iteration_times = 3;
uniform float speed = 0.3;
uniform vec4 floor_color : source_color = vec4(0.0, .35, .5, 1.0);
uniform vec4 caustics_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform float intensity = .003;

void fragment() 
{
    lowp vec2 p = mod(UV*TAU, TAU)-550.0;
	lowp vec2 i = vec2(p);
	lowp float c = 1.0;
	lowp float t = TIME * speed;

	for (int n = 0; n < iteration_times; n++) 
	{
		i = p + vec2(cos(t - i.x) + sin(t + i.y), sin(t - i.y) + cos(t + i.x));
		c += 1.0/length(vec2(p.x / (sin(i.x+t)/intensity),p.y / (cos(i.y+t)/intensity)));
	}
	c /= float(iteration_times);
	c = 1.17-pow(c, 1.4);
	c = clamp(c, 0.0, 0.85);
	vec4 color = vec4(pow(c, 8.0));
	
	//color = (color + caustics_color) / 2.0;
    //color = clamp(color + floor_color, 0.0, 1.0);
	color = (color + floor_color) / 2.0;
    
	ALBEDO = color.rgb;
}