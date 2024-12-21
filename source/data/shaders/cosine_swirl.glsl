#version 300 es
precision highp float;
out vec4 FragColor;
in vec2 TexCoord;

uniform sampler2D textTexture;
uniform float time_f;
uniform vec2 iResolution;

vec3 rainbow(float t) {
    float hue = mod(t, 1.0) * 6.0;
    float c = 1.0;
    float x = 1.0 - abs(mod(hue, 2.0) - 1.0);
    vec3 rgb = (hue < 1.0) ? vec3(c, x, 0.0) :
               (hue < 2.0) ? vec3(x, c, 0.0) :
               (hue < 3.0) ? vec3(0.0, c, x) :
               (hue < 4.0) ? vec3(0.0, x, c) :
               (hue < 5.0) ? vec3(x, 0.0, c) :
                             vec3(c, 0.0, x);
    return rgb;
}

void main(void) {
    vec2 center = vec2(0.5, 0.5);
    vec2 dir = TexCoord - center;
    float dist = length(dir);
    float angle = atan(dir.y, dir.x);
    float frequency = 1.0;
    float amplitude = 3.0;
    float spiralTime = sin(time_f * frequency) * amplitude;
    float scale = 1.0;
    float gradient_pos = mod(dist * scale + (angle + spiralTime) / (2.0 * 3.14159), 1.0);
    vec3 FragColor_gradient = rainbow(gradient_pos);
    vec4 ctx = texture(textTexture, TexCoord);
    float time_t = mod(time_f, 10.0) + 2.0;
    FragColor = mix(cos(ctx * time_t), vec4(FragColor_gradient, 1.0), 0.5);
}
