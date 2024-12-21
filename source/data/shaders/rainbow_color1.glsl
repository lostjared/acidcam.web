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

    vec3 rainbow_FragColor = rainbow(angle / (2.0 * 3.14159));

    vec4 original_FragColor = texture(textTexture, TexCoord);
    vec3 blended_FragColor = mix(original_FragColor.rgb, rainbow_FragColor, 0.5);

    FragColor = vec4(tan(blended_FragColor * time_f), original_FragColor.a);
}

