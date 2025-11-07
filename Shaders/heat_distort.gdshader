shader_type canvas_item;

#include "res://Screen/CRT.gdshaderinc"

uniform sampler2D noise_texture : source_color, repeat_enable;
uniform vec2 screen_resolution = vec2(1280.0, 720.0);
global uniform float warp_strength : hint_range(0.0, 1.0);
uniform float warp_speed : hint_range(0.0, 2.0) = 0.333;
global uniform float heat_strength : hint_range(0.0, 0.05, 0.001);
uniform vec2 heat_speed = vec2(0.1, 0.05);
uniform sampler2D SCREEN_TEXT : hint_screen_texture, filter_linear_mipmap;

void fragment() {
    float t = TIME * warp_speed;

    // Start from SCREEN_UV
    vec2 pos = SCREEN_UV * 2.0 - 1.0;
    pos.y *= screen_resolution.y / screen_resolution.x;
    pos *= 4.0;

    // Apply warp distortion pattern
    for (float k = 1.0; k < 7.0; k += 1.0) { 
        pos.x += warp_strength * sin(2.0 * t + k * 1.5 * pos.y) + t * 0.5;
        pos.y += warp_strength * cos(2.0 * t + k * 1.5 * pos.x);
    }

    // Map back to [0, 1] UV space
    vec2 warp_uv = (pos / 4.0);
    warp_uv.y /= (screen_resolution.y / screen_resolution.x);
    warp_uv = (warp_uv + 1.0) * 0.5;

    // Add heat distortion noise
    vec2 noise_uv = UV + TIME * heat_speed;
    vec2 offset = (texture(noise_texture, noise_uv).xy * 2.0 - 1.0) * heat_strength;

    // Combine both distortions
    vec2 final_uv = warp_uv + offset;

    COLOR = texture(SCREEN_TEXTURE, final_uv);
}
