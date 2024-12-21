#version 300 es
precision highp float;

out vec4 FragColor;
in vec2 TexCoord;

uniform sampler2D textTexture;
uniform vec2 iResolution;
uniform float time_f;

void main(void) {
    vec2 normCoord = (TexCoord * 2.0 - 1.0) * vec2(iResolution.x / iResolution.y, 1.0);
    normCoord.x = abs(normCoord.x);
    float dist = length(normCoord);
    float angle = atan(normCoord.y, normCoord.x);
    float spiralAmount = time_f;
    angle += spiralAmount;
    dist = mix(dist, 1.0 - dist, sin(spiralAmount * 0.5));
    vec2 spiralCoord = vec2(cos(angle), sin(angle)) * dist;
    float scale = 1.0 + sin(spiralAmount * 0.2) * 0.5;
    spiralCoord *= scale;
    spiralCoord = (spiralCoord / vec2(iResolution.x / iResolution.y, 1.0) + 1.0) / 2.0;

    float time_t = mod(time_f, 100);
    float waveScale = time_t;
    float speed = 16.0;
    float offset = sin(time_f * speed + spiralCoord.x * waveScale) * 0.05;
    vec2 TexCoordOffset = vec2(spiralCoord.x, spiralCoord.y + offset);

    FragColor = texture(textTexture, TexCoordOffset);
}
