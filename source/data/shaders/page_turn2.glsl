#version 300 es
precision highp float;
out vec4 FragColor;
in vec2 TexCoord;

uniform sampler2D textTexture;
uniform float time_f;
uniform vec2 iResolution;

float pingPong(float x, float length) {
    float modVal = mod(x, length * 2.0);
    return modVal <= length ? modVal : length * 2.0 - modVal;
}

void main(void) {
    float time_t = pingPong(time_f, 10.0) + 2.0;
    float foldAmount = sin(time_t) * 0.5 + 0.5;
    vec2 uv = TexCoord;

    if (uv.x > foldAmount) {
        float offset = (uv.x - foldAmount) / (1.0 - foldAmount);
        uv.x = foldAmount + offset * foldAmount;
    }

    FragColor = texture(textTexture, uv);
}
