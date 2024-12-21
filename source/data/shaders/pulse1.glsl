#version 300 es
precision highp float;

in vec2 TexCoord;
out vec4 FragColor;
uniform sampler2D textTexture;
uniform float time_f;
uniform vec2 iResolution;
void main() {
    vec2 uv = TexCoord;
    vec2 center = vec2(0.5, 0.5);
    vec2 offset = uv - center;

    float ripple = sin(length(offset) * 20.0 - time_f * 5.0) * 0.05;
    float angle = atan(offset.y, offset.x) + ripple * sin(time_f);
    float radius = length(offset);
    vec2 swirlUV = center + radius * vec2(cos(angle), sin(angle));
    float pulse = 0.2 * sin(time_f * 3.0);
    swirlUV += pulse * normalize(offset);
    vec4 texColor = texture(textTexture, swirlUV);
    vec3 shiftedColor = texColor.rgb * (0.8 + 0.2 * sin(time_f * 2.0));
    FragColor = vec4(shiftedColor, texColor.a);
}
