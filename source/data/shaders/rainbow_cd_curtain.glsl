#version 300 es
precision highp float;


in vec2 TexCoord;
out vec4 FragColor;
uniform sampler2D textTexture;
uniform float time_f;
uniform vec2 iResolution;
uniform float value_alpha_r;

float hash(float n) {
    return fract(sin(n) * 43758.5453123);
}

vec2 random2(vec2 st) {
    st = vec2(dot(st, vec2(127.1, 311.7)),
              dot(st, vec2(269.5, 183.3)));
    return -1.0 + 2.0 * fract(sin(st) * 43758.5453123);
}

vec2 smoothRandom2(float t) {
    float t0 = floor(t);
    float t1 = t0 + 1.0;
    vec2 rand0 = random2(vec2(t0));
    vec2 rand1 = random2(vec2(t1));
    float mix_factor = fract(t);
    return mix(rand0, rand1, smoothstep(0.0, 1.0, mix_factor));
}

vec3 rainbow(float t, float seed) {
    t = fract(t + seed);
    float r = abs(t * 6.0 - 3.0) - 1.0;
    float g = 2.0 - abs(t * 6.0 - 2.0);
    float b = 2.0 - abs(t * 6.0 - 4.0);
    return clamp(vec3(r, g, b), 0.0, 1.0);
}

float pingPong(float x, float length) {
    float modVal = mod(x, length * 2.0);
    return modVal <= length ? modVal : length * 2.0 - modVal;
}

void main(void) {
    vec2 uv = TexCoord * 2.0 - 1.0;
    uv.y *= iResolution.y / iResolution.x;

    float pingPongTime = pingPong(time_f, 9.0);
    float rotations = floor(pingPongTime / 3.0);
    float direction = mod(rotations, 2.0) == 0.0 ? 1.0 : -1.0;
    float localTime = mod(pingPongTime, 3.0);
    float rotationAngle = localTime * 2.0 * 3.14159 * direction;

    float cosAngle = cos(rotationAngle);
    float sinAngle = sin(rotationAngle);

    vec2 rotatedUV = vec2(
        cosAngle * uv.x - sinAngle * uv.y,
        sinAngle * uv.x + cosAngle * uv.y
    );

    uv = rotatedUV;

    float time_t = pingPong(time_f, 15.0) + 1.0;
    float wave = sin(uv.x * 10.0 + time_t * 2.0) * 0.1;
    vec2 random_direction = smoothRandom2(time_t) * 0.5;
    float expand = 0.5 + 0.5 * sin(time_t * 2.0);
    vec2 spiral_uv = uv * expand + random_direction;
    float angle = atan(spiral_uv.y + wave, spiral_uv.x) + time_t * 2.0;

    float curtain_wave = sin(uv.y * 10.0 + time_f * 2.0) * 0.1;
    vec3 rainbow_FragColor = rainbow((angle / (2.0 * 3.14159)) + curtain_wave, value_alpha_r);

    vec4 original_FragColor = texture(textTexture, (rotatedUV + 1.0) / 2.0);
    vec3 blended_FragColor = mix(original_FragColor.rgb, rainbow_FragColor, 0.5);
    FragColor = vec4(sin(blended_FragColor * time_t), original_FragColor.a);
}