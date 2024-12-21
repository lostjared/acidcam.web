#version 300 es
precision highp float;
out vec4 FragColor;
in vec2 TexCoord;

uniform sampler2D textTexture;
uniform float time_f;
uniform vec2 iResolution;

void main(void) {
    float xDistort = cos(TexCoord.y * 10.0 + time_f) * 0.1;
    float yDistort = sin(TexCoord.x * 10.0 + time_f) * 0.1;
    float tanDistortX = tan(TexCoord.x * 5.0 + time_f) * 0.05;
    float tanDistortY = tan(TexCoord.y * 5.0 + time_f) * 0.05;
    vec2 distortedTC = TexCoord + vec2(xDistort + tanDistortX, yDistort + tanDistortY);
    distortedTC = fract(distortedTC);
    FragColor = texture(textTexture, distortedTC);
}
