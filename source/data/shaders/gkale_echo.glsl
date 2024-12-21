#version 300 es
precision highp float;
in vec2 TexCoord;
out vec4 FragColor;
uniform sampler2D textTexture;
uniform float time_f;
uniform vec2 iResolution;
float pingPong(float x, float length) {
    float modVal = mod(x, length * 2.0);
    return modVal <= length ? modVal : length * 2.0 - modVal;
}
vec4 firstEffect(vec2 TexCoord) {
    vec2 center = vec2(0.5, 0.5);
    float angle = time_f;
    vec2 TexCoord1 = TexCoord;
    vec2 TexCoord2 = TexCoord - center;
    TexCoord2 *= 0.8;
    TexCoord2 = vec2(
        TexCoord2.x * cos(angle + 1.0) - TexCoord2.y * sin(angle + 1.0),
        TexCoord2.x * sin(angle + 1.0) + TexCoord2.y * cos(angle + 1.0)
    );
    TexCoord2 += center;
    TexCoord2 = fract(TexCoord2);
    vec2 TexCoord3 = TexCoord - center;
    TexCoord3 *= 0.6;
    TexCoord3 = vec2(
        TexCoord3.x * cos(angle + 2.0) - TexCoord3.y * sin(angle + 2.0),
        TexCoord3.x * sin(angle + 2.0) + TexCoord3.y * cos(angle + 2.0)
    );
    TexCoord3 += center;
    TexCoord3 = fract(TexCoord3);
    vec2 TexCoord4 = TexCoord - center;
    TexCoord4 *= 0.4;
    TexCoord4 = vec2(
        TexCoord4.x * cos(angle + 3.0) - TexCoord4.y * sin(angle + 3.0),
        TexCoord4.x * sin(angle + 3.0) + TexCoord4.y * cos(angle + 3.0)
    );
    TexCoord4 += center;
    TexCoord4 = fract(TexCoord4);
    vec4 FragColor1 = texture(textTexture, TexCoord1);
    vec4 FragColor2 = texture(textTexture, TexCoord2);
    vec4 FragColor3 = texture(textTexture, TexCoord3);
    vec4 FragColor4 = texture(textTexture, TexCoord4);
    return (FragColor1 + FragColor2 + FragColor3 + FragColor4) * 0.25;
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
    vec4 texColor = firstEffect(uv);
    float pattern = cos(radius * 10.0 - time_t * 5.0);
    vec3 FragColorShift = vec3(
        0.5 + 0.5 * cos(pattern + time_t + 0.0),
        0.5 + 0.5 * cos(pattern + time_t + 2.094),
        0.5 + 0.5 * cos(pattern + time_t + 4.188)
    );
    vec3 finalColor = texColor.rgb * FragColorShift;
    FragColor = vec4(finalColor, texColor.a);
    FragColor = mix(FragColor, firstEffect(TexCoord), 0.5);
    FragColor = sin(FragColor * time_t);
}

