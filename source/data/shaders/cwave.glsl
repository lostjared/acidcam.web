#version 300 es
precision highp float;
out vec4 FragColor;
in vec2 TexCoord;

uniform sampler2D textTexture;
uniform float time_f;
uniform vec2 iResolution;

void main(void) {
    vec2 uv = TexCoord * iResolution;
    uv -= 0.5 * iResolution;
    float dist = length(uv);
    float angle = atan(uv.y, uv.x);
    float wave = sin(dist * 10.0 - time_f * 5.0 + angle * 5.0);
    vec4 texColor = texture(textTexture, TexCoord);
    FragColor = texColor * (0.5 + 0.5 * wave);
}
