#version 300 es
precision highp float;


in vec2 TexCoord;
out vec4 FragColor;
uniform sampler2D textTexture;
uniform float time_f;

float pingPong(float x, float length) {
    float modVal = mod(x, length * 2.0);
    return modVal <= length ? modVal : length * 2.0 - modVal;
}


void main(void) {
    float time_t =   pingPong(time_f, 10.0) + 2.0;
    vec2 uv = TexCoord - 0.5;
    float len = length(uv);
    float factor = sqrt(len) * 0.5;
    uv *= (1.0 + sin(factor * time_t));
    FragColor = texture(textTexture, uv + 0.5);
}
