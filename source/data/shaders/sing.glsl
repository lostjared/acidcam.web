#version 300 es
precision highp float;
out vec4 FragColor;
in vec2 TexCoord;

uniform sampler2D textTexture;
uniform float time_f;
uniform vec2 iResolution;

void main(void) {
    vec2 uv = (TexCoord * 2.0) - 1.0;
    float distance = length(uv);
    float phase = sin(time_f * 3.14159265);
    float scale = smoothstep(0.0, 1.0, phase);
    vec2 scaled_uv = uv / scale;
    scaled_uv = (scaled_uv + 1.0) * 0.5;
    scaled_uv = clamp(scaled_uv, 0.0, 1.0);
    FragColor = texture(textTexture, scaled_uv);
}
