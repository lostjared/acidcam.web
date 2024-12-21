#version 300 es
precision highp float;
out vec4 FragColor;
in vec2 TexCoord;

uniform sampler2D textTexture;
uniform float time_f;
uniform vec2 iResolution;

float rand(vec2 co) {
    return fract(sin(dot(co.xy, vec2(12.9898, 78.233))) * 43758.5453);
}

float noise(vec2 pos) {
    vec2 i = floor(pos);
    vec2 f = fract(pos);
    vec2 u = f * f * (3.0 - 2.0 * f);
    return mix(mix(rand(i + vec2(0.0, 0.0)), rand(i + vec2(1.0, 0.0)), u.x),
               mix(rand(i + vec2(0.0, 1.0)), rand(i + vec2(1.0, 1.0)), u.x), u.y);
}

void main(void) {
    vec2 uv = TexCoord;
    float gliTexCoordhStrength = 0.01;
    float timeNoise = noise(uv * 10.0 + time_f * 0.5);
    uv.x += (rand(uv + time_f) - 0.5) * gliTexCoordhStrength;
    uv.y += (rand(uv + time_f * 1.5) - 0.5) * gliTexCoordhStrength;
    vec4 texColor = texture(textTexture, uv);
    vec4 FragColorShift = vec4(texColor.r, texColor.g * 0.5 + 0.5 * timeNoise, texColor.b * 0.5 + 0.5 * (1.0 - timeNoise), texColor.a);
    float gliTexCoordhNoise = rand(uv + time_f);
    vec4 gliTexCoordhColor = vec4(vec3(sin(gliTexCoordhNoise * time_f)), 1.0) * gliTexCoordhStrength ;
    FragColor = mix(FragColorShift, gliTexCoordhColor, gliTexCoordhStrength * gliTexCoordhNoise);
    FragColor = sin(FragColor * time_f);
}
