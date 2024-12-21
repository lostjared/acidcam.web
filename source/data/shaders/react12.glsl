#version 300 es
precision highp float;


in vec2 TexCoord;
out vec4 FragColor;
uniform sampler2D textTexture;
uniform float time_f;

void main(void) {
    vec2 center = vec2(0.5, 0.5);
    vec2 uv = TexCoord - center;
    float dist = length(uv);
    float ripple = sin(10.0 * dist - time_f * 6.28318) * 0.1;
    uv += uv * ripple;
    uv += center;

    FragColor = texture(textTexture, uv);
}
