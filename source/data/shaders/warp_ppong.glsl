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
    float warpFactor = sin(time_f) * 0.5 + 0.5;
    vec2 warpedCoords;
    warpedCoords.x = pingPong(TexCoord.x + time_f * 0.1, 1.0);
    warpedCoords.y = pingPong(TexCoord.y + time_f * 0.1, 1.0);
    FragColor = texture(textTexture, warpedCoords);
}
