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
    float angle = atan(uv.y, uv.x) + time_f * 20.0;
    float radius = length(uv);

    float circle = step(0.5, radius) * step(radius, 0.75);
    float dot1 = step(distance(uv, vec2(0.25 * cos(time_f), 0.25 * sin(time_f))), 0.1);
    float dot2 = step(distance(uv, vec2(-0.25 * cos(time_f), -0.25 * sin(time_f))), 0.1);

    float yin_yang = circle + dot1 + dot2;

    vec3 rainbow_FragColor = rainbow(angle / (2.0 * 3.14159));

    vec4 original_FragColor = texture(textTexture, TexCoord);
    vec3 blended_FragColor = mix(original_FragColor.rgb, rainbow_FragColor, yin_yang);

    FragColor = vec4(sin(blended_FragColor * time_f), original_FragColor.a);
}
