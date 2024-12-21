#version 300 es
precision highp float;
out vec4 FragColor;
in vec2 TexCoord;

uniform sampler2D textTexture;
uniform float time_f;
uniform vec2 iResolution;

vec3 compositeEffect(vec2 uv) {
    float offset = 0.01;
    vec3 col;
    col.r = texture(textTexture, uv + vec2(offset, 0.0)).r;
    col.g = texture(textTexture, uv).g;
    col.b = texture(textTexture, uv - vec2(offset, 0.0)).b;
    float noise = fract(sin(dot(uv.xy, vec2(12.9898, 78.233))) * 43758.5453);
    col += noise * 0.05;
    float scanline = sin(uv.y * iResolution.y * 1.5) * 0.1;
    col -= scanline;
       float bleed = sin(uv.y * iResolution.y * 0.2 + time_f * 5.0) * 0.005;
    col.r += bleed * 0.002;
    col.b -= bleed * 0.002;
    return col;
}

void main(void) {
    vec2 uv = TexCoord;
    vec3 col = compositeEffect(uv);
    FragColor = vec4(col, 1.0);
}
