#version 300 es
precision highp float;


in vec2 TexCoord;
out vec4 FragColor;
uniform sampler2D textTexture;
uniform float time_f;

void main(void) {
    vec4 baseColor = texture(textTexture, TexCoord);
    float gliTexCoordhOffsetX = fract(sin(dot(TexCoord, vec2(12.9898, 78.233))) * 43758.5453) * 0.1 * sin(time_f * 20.0);
    float gliTexCoordhOffsetY = fract(cos(dot(TexCoord, vec2(4.898, 7.23))) * 23421.6312) * 0.1 * cos(time_f * 20.0);
    vec2 gliTexCoordhTc = TexCoord + vec2(gliTexCoordhOffsetX, gliTexCoordhOffsetY);
    vec4 gliTexCoordhColor = texture(textTexture, gliTexCoordhTc);
    float gliTexCoordhStrength = 0.5 + 0.5 * cos(time_f * 5.0);
    FragColor = mix(baseColor, gliTexCoordhColor, gliTexCoordhStrength);
}
