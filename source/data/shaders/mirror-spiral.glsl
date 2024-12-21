#version 300 es
precision highp float;
out vec4 FragColor;
in vec2 TexCoord;

uniform sampler2D textTexture;
uniform float time_f;
uniform vec2 iResolution;

void main(void) {
    vec2 uv = TexCoord * iResolution.xy;
    vec2 center = iResolution * 0.5;
    vec2 offset = uv - center;
    float radius = length(offset);
    float angle = atan(offset.y, offset.x);
    float spiralFactor = sin(time_f + radius * 10.0) * 0.5 + 0.5;
    radius *= spiralFactor;
    vec2 newUV = vec2(
        center.x + radius * cos(angle),
        center.y + radius * sin(angle)
    ) / iResolution;
    newUV = mod(newUV, 1.0);
    newUV = abs(newUV);
    FragColor = texture(textTexture, newUV);
}
