#version 300 es
precision highp float;
out vec4 FragColor;
in vec2 TexCoord;

uniform sampler2D textTexture;
uniform float time_f;
uniform vec2 iResolution;

void main(void) {
    float zoomFactor = 0.5 + 0.5 * sin(time_f);
    float angle = time_f;
    vec2 center = vec2(0.5, 0.5);
    vec2 dir = TexCoord - center;
    float cosAngle = cos(angle);
    float sinAngle = sin(angle);
    vec2 rotatedTc = vec2(
        cosAngle * dir.x - sinAngle * dir.y,
        sinAngle * dir.x + cosAngle * dir.y
    ) * zoomFactor + center;
    FragColor = texture(textTexture, rotatedTc);
}
