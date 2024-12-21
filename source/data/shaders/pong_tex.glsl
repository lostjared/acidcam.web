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
    vec2 uv = TexCoord * 2.0;
    uv.x = pingPong(uv.x, 1.0);
    uv.y = pingPong(uv.y, 1.0);
    float frequency = 10.0;
    float amplitude = 0.05;
    uv += sin(uv * frequency + time_f) * amplitude;
    vec4 texColor = texture(textTexture, uv);
    FragColor = texColor;
}
