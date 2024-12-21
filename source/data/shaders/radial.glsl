#version 300 es
precision highp float;
out vec4 FragColor;
in vec2 TexCoord;

uniform sampler2D textTexture;
uniform float time_f;
uniform vec2 iResolution;

void main(void) {
    vec2 uv = TexCoord - 0.5;
    float blurAmount = length(uv) * 0.2;
    vec4 sum = vec4(0.0);
    for (int i = -4; i <= 4; i++) {
        for (int j = -4; j <= 4; j++) {
            vec2 offset = vec2(i, j) * blurAmount / 10.0;
            sum += texture(textTexture, TexCoord + offset);
        }
    }
    FragColor = sum / 81.0;
}
