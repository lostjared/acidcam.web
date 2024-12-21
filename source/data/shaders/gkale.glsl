#version 300 es
precision highp float;
out vec4 FragColor;
in vec2 TexCoord;

uniform sampler2D textTexture;
uniform float time_f;
uniform vec2 iResolution;

float pingPong(float x, float length) {
    float modVal = mod(x, length * 2.0);
    return modVal <= length ? modVal : length * 2.0 - modVal;
}

void main(void) {
    vec2 uv = TexCoord * 2.0 - 1.0;
    uv.x *= iResolution.x / iResolution.y;
    float angle = atan(uv.y, uv.x);
    float radius = length(uv) * 1.4142;
    float segments = 8.0;
    angle = mod(angle, 6.28318 / segments);
    angle = abs(angle - 3.14159 / segments);
    uv = vec2(cos(angle), sin(angle)) * radius;
    uv = uv * 0.5 + 0.5;
    uv = clamp(uv, 0.0, 1.0);
    float time_t = pingPong(time_f * 0.5, 7.0) + 2.0;
    vec4 texColor = texture(textTexture, uv);
    float pattern = cos(radius * 10.0 - time_t * 5.0);
    vec3 FragColorShift = vec3(
        0.5 + 0.5 * cos(pattern + time_t + 0.0),
        0.5 + 0.5 * cos(pattern + time_t + 2.094),
        0.5 + 0.5 * cos(pattern + time_t + 4.188)
    );
    vec3 finalColor = texColor.rgb * FragColorShift;
    FragColor = vec4(finalColor, texColor.a);
    FragColor = mix(FragColor, texture(textTexture, TexCoord), 0.5);
    FragColor = sin(FragColor * time_t);
}
