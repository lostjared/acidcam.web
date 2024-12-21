#version 300 es
precision highp float;

uniform sampler2D textTexture;
uniform float time_f;
uniform vec2 iResolution;

out vec4 FragColor;

void main() {
    vec2 uv = gl_FragCoord.xy / iResolution;
    vec4 texColor = texture(textTexture, uv);
    float distortion = sin(uv.x * 50.0 + time_f * 2.0) * cos(uv.y * 50.0 - time_f * 2.0);
    float xor_effect_r = mod((texColor.r * 255.0) + distortion * 255.0, 256.0) / 255.0;
    float xor_effect_g = mod((texColor.g * 255.0) + distortion * 255.0, 256.0) / 255.0;
    float xor_effect_b = mod((texColor.b * 255.0) + distortion * 255.0, 256.0) / 255.0;
    vec3 rainbow = vec3(
        0.5 + 0.5 * sin(time_f + uv.x * 10.0),
        0.5 + 0.5 * sin(time_f + uv.y * 10.0 + 2.0),
        0.5 + 0.5 * sin(time_f + (uv.x + uv.y) * 10.0 + 4.0)
    );
    vec3 finalColor = mix(vec3(xor_effect_r, xor_effect_g, xor_effect_b), rainbow, 0.5);
    FragColor = vec4(finalColor, texColor.a);
}
