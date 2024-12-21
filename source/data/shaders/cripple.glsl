#version 300 es
precision highp float;
out vec4 FragColor;
in vec2 TexCoord;

uniform sampler2D textTexture;
uniform float time_f;
uniform vec2 iResolution;

void main(void) {
    vec2 uv = TexCoord;
    vec2 center = iResolution * 0.5;
    float distance = length(uv * iResolution - center);
    float ripple = 0.05 * cos(distance * 10.0 - time_f * 5.0);
    uv += ripple;
    FragColor = texture(textTexture, uv);
}
