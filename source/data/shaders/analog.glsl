#version 300 es
precision highp float;
out vec4 FragColor;
in vec2 TexCoord;

uniform sampler2D textTexture;
uniform float time_f;
uniform vec2 iResolution;

vec3 analogEffect(vec2 uv) {
    vec3 col = texture(textTexture, uv).rgb;

    float offset = 0.002;
    col.r = texture(textTexture, uv + vec2(offset, 0.0)).r;
    col.b = texture(textTexture, uv - vec2(offset, 0.0)).b;

    float noise = fract(sin(dot(uv.xy + time_f, vec2(12.9898, 78.233))) * 43758.5453);
    col += noise * 0.05;

    float scanline = sin(uv.y * iResolution.y * 3.0 + time_f * 20.0) * 0.05;
    col -= vec3(scanline);

    float vignette = smoothstep(1.0, 0.8, length(uv - 0.5) * 1.5);
    col *= vignette;

    return col;
}

void main(void) {
    vec2 uv = TexCoord;
    vec3 col = analogEffect(uv);
    FragColor = vec4(col, 1.0);
}
