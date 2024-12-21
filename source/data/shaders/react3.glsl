#version 300 es
precision highp float;


in vec2 TexCoord;
out vec4 FragColor;
uniform sampler2D textTexture;
uniform float time_f;

void main(void) {
    vec2 uv = TexCoord - 0.5;
    float radius = length(uv);
    float angle = atan(uv.y, uv.x) + radius * 10.0 + time_f * (0.5 + sin(time_f) * 0.5);
    vec2 spiralUV = vec2(cos(angle), sin(angle)) * radius;
    FragColor = texture(textTexture, spiralUV + 0.5);
}
