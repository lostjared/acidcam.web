#version 300 es
precision highp float;
out vec4 FragColor;
in vec2 TexCoord;

uniform sampler2D textTexture;
uniform float time_f;
uniform vec2 iResolution;

void main(void) {
    float foldAmount = sin(time_f) * 0.5 + 0.5;
    vec2 uv = TexCoord;

    if (uv.x > foldAmount) {
        float offset = (uv.x - foldAmount) / (1.0 - foldAmount);
        uv.x = foldAmount + offset * foldAmount;
    }

    FragColor = texture(textTexture, uv);
}
