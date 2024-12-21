#version 300 es
precision highp float;
out vec4 FragColor;
in vec2 TexCoord;

uniform sampler2D textTexture;
uniform float time_f;
uniform vec2 iResolution;

void main(void) {
    vec2 center = vec2(0.5, 0.5);
    vec2 dir = TexCoord - center;
    float factor = 2.0;
    dir.x *= factor;
    vec2 new_TexCoord = center + dir;
    FragColor = texture(textTexture, new_TexCoord);
}
