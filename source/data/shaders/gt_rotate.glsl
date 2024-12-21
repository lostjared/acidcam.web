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
    vec2 center = vec2(0.5, 0.5);
    float angle = time_f;
    vec2 TexCoord_centered = TexCoord - center;
    float cos_theta = cos(angle);
    float sin_theta = sin(angle);
    vec2 TexCoord_rotated;
    TexCoord_rotated.x = TexCoord_centered.x * cos_theta - TexCoord_centered.y * sin_theta;
    TexCoord_rotated.y = TexCoord_centered.x * sin_theta + TexCoord_centered.y * cos_theta;

    TexCoord_rotated += center;
    vec4 texColor = texture(textTexture, TexCoord_rotated);
    FragColor = texColor;
}

