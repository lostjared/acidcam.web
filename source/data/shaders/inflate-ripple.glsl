#version 300 es
precision highp float;
out vec4 FragColor;
in vec2 TexCoord;

uniform sampler2D textTexture;
uniform float time_f;
uniform vec2 iResolution;

void main(void) {
    float cycle_time = mod(time_f, 5.0);
    float inflate = min(cycle_time * 0.4, 1.5);
    vec2 center = vec2(0.5, 0.5);
    float distance = length(TexCoord - center);
    float ripple = sin((distance - cycle_time) * 10.0) * 0.02;

    vec2 adjusted_TexCoord = (TexCoord - center) * inflate + center + normalize(TexCoord - center) * ripple;
    FragColor = texture(textTexture, adjusted_TexCoord);
}
