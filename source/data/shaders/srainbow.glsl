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
    float angle = atan(uv.y, uv.x);
    float radius = length(uv);
    float dispersion = 0.02;
    vec2 dir = normalize(uv);
    vec2 offset_r = TexCoord + dir * dispersion;
    vec2 offset_g = TexCoord;
    vec2 offset_b = TexCoord - dir * dispersion;
    float r = texture(textTexture, offset_r).r;
    float g = texture(textTexture, offset_g).g;
    float b = texture(textTexture, offset_b).b;
    vec3 prism_FragColor = vec3(r, g, b);
    float t = fract((angle / (2.0 * 3.14159)) + time_f * 0.1);
    vec3 rainbow_FragColor = rainbow(t);
    float rainbow_factor = 0.5;
    vec3 final_FragColor = mix(prism_FragColor, rainbow_FragColor, rainbow_factor);
    
    float time_t = pingPong(time_f, 4.0) + 2.0;
    
    FragColor = vec4(sin(final_FragColor * time_t), 1.0);
}

