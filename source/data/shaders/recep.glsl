#version 300 es
precision highp float;
out vec4 FragColor;
in vec2 TexCoord;

uniform sampler2D textTexture;
uniform float time_f;
uniform vec2 iResolution;

float noise(vec2 co) {
    return fract(sin(dot(co.xy, vec2(12.9898, 78.233))) * 43758.5453);
}

void main(void) {
    vec2 uv = TexCoord;
    float n = noise(uv * time_f);
    float offset = sin(uv.y * 10.0 + time_f) * 0.1;
    uv.x += offset * n;
    vec4 texColor = texture(textTexture, uv);
    float stripe = step(0.5, fract(uv.y * 40.0 + time_f));
    texColor.rgb *= stripe;
    texColor.rgb += n * 0.2;
    FragColor = texColor;
}
