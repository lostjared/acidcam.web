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
    float angle = atan(TexCoord.y - 0.5, TexCoord.x - 0.5);
    float modulatedTime = pingPong(time_f, 5.0);
    angle += modulatedTime;

    vec2 rotatedTC;
    rotatedTC.x = cos(angle) * (TexCoord.x - 0.5) - sin(angle) * (TexCoord.y - 0.5) + 0.5;
    rotatedTC.y = sin(angle) * (TexCoord.x - 0.5) + cos(angle) * (TexCoord.y - 0.5) + 0.5;

    FragColor = texture(textTexture, rotatedTC);
}
