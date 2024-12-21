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
    vec2 center = iResolution / 2.0;
    vec2 uv = TexCoord * iResolution;
    float distanceFromCenter = length(uv - center);

    float rippleSpeed = 2.0;
    float rippleFrequency = 20.0;

    float time = time_f * rippleSpeed;
    float wave = sin(pingPong(distanceFromCenter + time, rippleFrequency));

    float warpStrength = 0.05;
    float warpFrequency = 5.0;
    vec2 warp = vec2(sin(uv.y * warpFrequency + time), sin(uv.x * warpFrequency + time)) * warpStrength;

    vec2 rippleUV = TexCoord + normalize(uv - center) * wave * 0.01 + warp;

    FragColor = texture(textTexture, rippleUV);
}
