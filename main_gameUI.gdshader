shader_type canvas_item;

uniform float scan_line_count : hint_range(0.0, 3000.0) = 1000;
uniform sampler2D SCREEN_TEXTURE: hint_screen_texture, filter_linear;

void fragment() {
	float wave =  sin(TIME*8.0)*2.0*sin(TIME*1.0);
	float wave2 = cos(-TIME*5.0)*2.0*sin(-TIME*5.0);
	float wave3 =  cos(-TIME*8.0)*2.0*sin(-TIME*8.0);
	
	float R = texture(SCREEN_TEXTURE,SCREEN_UV+vec2(0.0,SCREEN_PIXEL_SIZE.x*wave3), 0.0).r;
	float G = texture(SCREEN_TEXTURE,SCREEN_UV+vec2(SCREEN_PIXEL_SIZE.x*wave,0.0), 0.0).g;
	float B = texture(SCREEN_TEXTURE,SCREEN_UV+vec2(0.0,SCREEN_PIXEL_SIZE.y*wave2), 0.0).b;
	
	float s = sin(TIME*2.0 + (SCREEN_UV.y) * scan_line_count*2000.0) + (SCREEN_PIXEL_SIZE.y);
	vec4 scan_line = vec4(vec3(pow(s,.5))+vec3(R,G,B)*1.0,.5);
		
	float s2 = sin(TIME*2.0 + (SCREEN_UV.y)  * scan_line_count*2000.0);
	vec4 scan_line2 = vec4(vec3(pow(s2,.1))+vec3(R,G,B)*1.0,.8);
	COLOR = (((scan_line*scan_line2))/3.0);
	}
