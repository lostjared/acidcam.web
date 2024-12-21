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
    vec2 TexCoord_centered = TexCoord - center;
    float dist = length(TexCoord_centered);
   vec2 dir = TexCoord_centered / max(dist, 1e-6);
    float waveLength = 0.05;
    float amplitude = 0.02;
    float speed = 2.0;

    float ripple = sin((dist / waveLength - time_f * speed) * 6.2831853); // 2 * PI
    vec2 TexCoord_displaced = TexCoord + dir * ripple * amplitude;
    vec4 texColor = texture(textTexture, TexCoord_displaced);
    FragColor = texColor;
}

