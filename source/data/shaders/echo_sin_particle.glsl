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

vec2 hash(vec2 p) {
    p = vec2(dot(p, vec2(127.1, 311.7)), dot(p, vec2(269.5, 183.3)));
    return -1.0 + 2.0 * fract(sin(p) * 43758.5453123);
}

float noise(vec2 p) {
    vec2 i = floor(p);
    vec2 f = fract(p);
    vec2 u = f * f * (3.0 - 2.0 * f);
    return mix(
        mix(dot(hash(i + vec2(0.0, 0.0)), f - vec2(0.0, 0.0)), dot(hash(i + vec2(1.0, 0.0)), f - vec2(1.0, 0.0)), u.x),
        mix(dot(hash(i + vec2(0.0, 1.0)), f - vec2(0.0, 1.0)), dot(hash(i + vec2(1.0, 1.0)), f - vec2(1.0, 1.0)), u.x),
        u.y);
}

void main() {
    vec2 uv = gl_FragCoord.xy / iResolution.xy;
    vec3 col = vec3(0.0);

    float numParticles = 50.0;
    for (float i = 0.0; i < numParticles; i += 1.0) {
        float t = time_f * 0.1 + i * 6.28 / numParticles;
        vec2 pos = vec2(sin(t + noise(vec2(i, t)) * 10.0), cos(t + noise(vec2(i, t)) * 10.0)) * 0.3 + 0.5;
        float d = length(uv - pos);
        col += vec3(0.1, 0.5, 0.8) * (1.0 - d) * exp(-d * 10.0);
    }

    FragColor = vec4(col, 1.0);
    FragColor = mix(texture(textTexture, TexCoord), FragColor, 0.5);

    vec4 FragColor2 = texture(textTexture, TexCoord / 2);
    vec4 FragColor3 = texture(textTexture, TexCoord / 4);
    vec4 FragColor4 = texture(textTexture, TexCoord / 8);
    FragColor = (FragColor * 0.4) + (FragColor2 * 0.4) + (FragColor3 * 0.4) + (FragColor4 * 0.4);

    float time_t = pingPong(time_f, 10.0) + 2.0;
    FragColor = sin(FragColor * time_t);
}
