#version 300 es
precision highp float;
out vec4 FragColor;
in vec2 TexCoord;

uniform sampler2D textTexture;
uniform float time_f;
uniform vec2 iResolution;

void main(void) {
    vec2 uv = TexCoord;

    float gliTexCoordhStrength = sin(time_f * 10.0) * 0.1;
    float gliTexCoordhOffsetX = fract(sin(dot(uv, vec2(12.9898, 78.233))) * 43758.5453) * gliTexCoordhStrength;
    float gliTexCoordhOffsetY = fract(cos(dot(uv, vec2(4.898, 7.23))) * 23421.6312) * gliTexCoordhStrength;

    uv.x += gliTexCoordhOffsetX;
    uv.y += gliTexCoordhOffsetY;

    vec4 FragColorA = texture(textTexture, uv);
    vec4 FragColorB = texture(textTexture, uv + vec2(0.01 * sin(time_f * 50.0), 0.01 * cos(time_f * 50.0)));

    float noise = fract(sin(dot(uv, vec2(12.9898, 78.233))) * 43758.5453);
    FragColor = mix(FragColorA, FragColorB, noise);
}
