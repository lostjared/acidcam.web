#version 300 es
precision highp float;
out vec4 FragColor;
in vec2 TexCoord;

uniform sampler2D textTexture;
uniform float time_f;
uniform vec2 iResolution;

void main(void) {
    float inflate = abs(sin(time_f * 10.0)) * 0.5 + 0.5;
    vec2 adjusted_TexCoord = (TexCoord - 0.5) * vec2(inflate, inflate) + 0.5;
    FragColor = texture(textTexture, adjusted_TexCoord);
}
