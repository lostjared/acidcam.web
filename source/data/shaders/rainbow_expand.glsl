#version 300 es
precision highp float;


in vec2 TexCoord;
out vec4 FragColor;
uniform sampler2D textTexture;
uniform float time_f;
uniform vec2 iResolution;

vec3 rainbow(float t) {
    t = fract(t);
    float r = abs(t * 6.0 - 3.0) - 1.0;
    float g = 2.0 - abs(t * 6.0 - 2.0);
    float b = 2.0 - abs(t * 6.0 - 4.0);
    return clamp(vec3(r, g, b), 0.0, 1.0);
}

void main(void) {
    vec2 uv = TexCoord * 2.0 - 1.0;
    uv.y *= iResolution.y / iResolution.x;

    float wave = sin(uv.x * 10.0 + time_f * 2.0) * 0.1;
    float expand = 0.5 + 0.5 * sin(time_f * 2.0);
    vec2 spiral_uv = uv * expand + vec2(cos(time_f), sin(time_f)) * 0.2;

    float angle = atan(spiral_uv.y + wave, spiral_uv.x) + time_f * 2.0;

    vec3 rainbow_FragColor = rainbow(angle / (2.0 * 3.14159));
    vec4 original_FragColor = texture(textTexture, TexCoord);
    vec3 blended_FragColor = mix(original_FragColor.rgb, rainbow_FragColor, 0.5);

    float time_t = mod(time_f, 30.0);
    FragColor = vec4(sin(blended_FragColor * time_t), original_FragColor.a);
}
