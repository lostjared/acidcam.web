#version 300 es
precision highp float;

uniform sampler2D textTexture;
uniform float time_f;
uniform vec2 iResolution;

out vec4 FragColor;

void main() {
    vec2 uv = gl_FragCoord.xy / iResolution;
    vec4 texColor = texture(textTexture, uv);
    float xor_effect_r = mod((texColor.r * 255.0) + sin(uv.x * 20.0 + time_f) * 255.0, 256.0) / 255.0;
    float xor_effect_g = mod((texColor.g * 255.0) + cos(uv.y * 20.0 - time_f) * 255.0, 256.0) / 255.0;
    float xor_effect_b = mod((texColor.b * 255.0) + sin((uv.x + uv.y) * 20.0 + time_f) * 255.0, 256.0) / 255.0;
    vec3 finalColor = mix(texColor.rgb, vec3(xor_effect_r, xor_effect_g, xor_effect_b), 0.5);
    FragColor = vec4(finalColor, texColor.a);
}

