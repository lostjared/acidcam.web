#version 300 es
precision highp float;
out vec4 FragColor;
in vec2 TexCoord;

uniform sampler2D textTexture;
uniform vec2 iResolution;
uniform float time_f;

void main(void) {
    vec2 normCoord = TexCoord;
    vec2 centeredCoord = normCoord * 2.0 - vec2(1.0, 1.0);
    centeredCoord.x *= iResolution.x / iResolution.y;
    float angle = atan(centeredCoord.y, centeredCoord.x);
    float dist = length(centeredCoord);
    float spiralFactor = 5.0;
    angle += dist * spiralFactor + time_f;
    vec2 spiralCoord = vec2(cos(angle), sin(angle)) * dist;
    spiralCoord.x *= iResolution.y / iResolution.x;
    spiralCoord = (spiralCoord + vec2(1.0, 1.0)) / 2.0;
    FragColor = texture(textTexture, spiralCoord);
}
