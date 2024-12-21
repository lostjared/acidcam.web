#version 300 es
precision highp float;
out vec4 FragColor;
in vec2 TexCoord;

uniform sampler2D textTexture;
uniform float time_f;
uniform vec2 iResolution;

void main(void) {
    vec2 uv = TexCoord;
    vec2 center = uv - 0.5;
    uv = uv + center * (0.1 * length(center));
    float scanline = sin(uv.y * iResolution.y * 0.75) * 0.05;
    vec3 offset = vec3(0.001, -0.001, 0.0) * scanline;
    vec3 texColor;
    texColor.r = texture(textTexture, uv + vec2(offset.r, 0.0)).r;
    texColor.g = texture(textTexture, uv + vec2(0.0, offset.g)).g;
    texColor.b = texture(textTexture, uv + vec2(0.0, offset.b)).b;
    texColor *= (1.0 - scanline);
    FragColor = vec4(texColor, 1.0);
}