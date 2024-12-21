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

float pingPong(float x, float length) {
    float modVal = mod(x, length * 2.0);
    return modVal <= length ? modVal : length * 2.0 - modVal;
}

void main(void) {
    vec2 uv = TexCoord * 2.0 - 1.0;
    uv.y *= iResolution.y / iResolution.x;

    float t = pingPong(time_f, 15) + 1.0;

    float wave = sin(uv.x * 10.0 + t * 2.0) * 0.1;
    float expand = 0.5 + 0.5 * sin(t * 2.0);
    vec2 spiral_uv = uv * expand + vec2(cos(t), sin(t)) * 0.2;

    float angle = atan(spiral_uv.y + wave, spiral_uv.x) + t * 2.0;

    vec3 rainbow_FragColor = rainbow(angle / (2.0 * 3.14159));
    vec4 original_FragColor = texture(textTexture, TexCoord);
    
    if (original_FragColor.rgb == vec3(0.0, 0.0, 0.0)) {
        discard;
    }

    vec3 blended_FragColor = mix(original_FragColor.rgb, rainbow_FragColor, 0.5);

    FragColor = vec4(sin(blended_FragColor * t), original_FragColor.a);
}
