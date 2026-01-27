shader_type spatial;
render_mode cull_disabled;

uniform vec3 color_1 : source_color = vec3(0.7, 0.65, 0.6);
uniform vec3 color_2 : source_color = vec3(0.9, 0.85, 0.8);
uniform float blend_smoothness : hint_range(0.0, 1.0) = 0.5;
uniform float noise_scale : hint_range(0.1, 10.0) = 3.0;

varying vec3 world_pos;

// Simple 2D noise function for painterly effect
float hash(vec2 p) {
	return fract(sin(dot(p, vec2(127.1, 311.7))) * 43758.5453);
}

float noise(vec2 p) {
	vec2 i = floor(p);
	vec2 f = fract(p);

	// Smooth interpolation (cubic for painterly feel)
	vec2 u = f * f * (3.0 - 2.0 * f);

	return mix(mix(hash(i + vec2(0.0, 0.0)),
				   hash(i + vec2(1.0, 0.0)), u.x),
			   mix(hash(i + vec2(0.0, 1.0)),
				   hash(i + vec2(1.0, 1.0)), u.x), u.y);
}

// Multi-octave noise for more detail
float fbm(vec2 p) {
	float value = 0.0;
	float amplitude = 0.5;
	float frequency = 1.0;

	for (int i = 0; i < 4; i++) {
		value += amplitude * noise(p * frequency);
		frequency *= 2.0;
		amplitude *= 0.5;
	}

	return value;
}

void vertex() {
	// Pass world position to fragment shader
	world_pos = (MODEL_MATRIX * vec4(VERTEX, 1.0)).xyz;
}

void fragment() {
	// Generate painterly noise using world coordinates
	vec2 local_pos = world_pos.xy * noise_scale;
	float paint_noise = fbm(local_pos);

	// Add some variation with offset noise
	float detail = fbm(local_pos * 2.0 + vec2(1.3, 2.7)) * 0.5;
	paint_noise = mix(paint_noise, detail, 0.4);

	// Smoothly blend between two colors using smoothstep for better transitions
	float blend_factor = smoothstep(0.5 - blend_smoothness * 0.5, 0.5 + blend_smoothness * 0.5, paint_noise);
	// Darken the back face
	if (!FRONT_FACING) {
		// color *= 0.6; // Darken by 40%
	}
	vec3 col1 = color_1;
	vec3 col2 = color_2;
	if (local_pos.y > 2.8) {
		col1 *= 0.8; // Darken lower area by 90%
		col2 *= 0.6;
	}
	vec3 color = mix(col1, col2, blend_factor);

	ALBEDO = color;
}
