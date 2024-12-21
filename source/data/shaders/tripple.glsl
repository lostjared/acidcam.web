
#version 300 es
precision highp float;
out vec4 FragColor;
in vec2 TexCoord;

uniform sampler2D textTexture;
uniform float time_f;
uniform vec2 iResolution;

void main(void) {
    vec2 uv = TexCoord;
    vec2 center = vec2(0.5, 0.5);
    float distance = length(uv - center);

    uv.x += tan(distance * 20.0 - time_f * 2.0) * 0.02;
    uv.y += tan(distance * 20.0 - time_f * 2.0) * 0.02;

    FragColor = texture(textTexture, uv);
}
