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
    float time_t = pingPong(time_f, 10.0);
    vec2 uv = TexCoord - 0.5;
    float distance = length(uv);
    float pulse = 1.0 + 0.5 * sin(time_t * 2.0 + distance * 20.0);
    uv *= pulse;
    uv += 0.5;
    FragColor = texture(textTexture, uv);
}
