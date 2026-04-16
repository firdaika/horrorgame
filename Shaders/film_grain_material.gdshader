shader_type canvas_item;

uniform sampler2D screen_texture :
	hint_screen_texture;

uniform float grain_intensity : hint_range(0.0, 1.0) = 0.12;
uniform float vignette_intensity : hint_range(0.0, 1.0) = 0.35;

void fragment() {
	// Ambil warna asli dari layar
	vec4 screen_color = texture(screen_texture, SCREEN_UV);
	
	// Buat noise (efek grain) dengan fungsi acak sederhana
	float noise = fract(sin(SCREEN_UV.x * 435.234 + SCREEN_UV.y * 123.543 + TIME * 100.0) * 4378.123);
	vec3 grain = vec3(noise * grain_intensity);
	
	// Hitung vignette (efek gelap di pinggir)
	vec2 uv = SCREEN_UV * 2.0 - 1.0;
	float vignette = 1.0 - length(uv) * vignette_intensity;
	vignette = clamp(vignette, 0.0, 1.0);
	
	// Gabungkan warna asli, grain, dan vignette
	COLOR = vec4(screen_color.rgb + grain, screen_color.a);
	COLOR.rgb *= vignette;
}