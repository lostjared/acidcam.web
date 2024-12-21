#version 300 es
precision highp float;
out vec4 FragColor;
in vec2 TexCoord;

uniform sampler2D textTexture;
uniform float time_f;
uniform vec2 iResolution;

float pingPong(float x, float length) {
    float modVal = mod(x, length * 2.0);
    return modVal <= length ? modVal : length * 2.0 - modVal;
}

vec3 rainbow(float t) {
    float r = sin(6.28318 * t + 0.0);
    float g = sin(6.28318 * t + 2.09439);
    float b = sin(6.28318 * t + 4.18878);
    return vec3(r, g, b) * 0.5 + 0.5;
}

void main(void) {
    vec2 center = vec2(0.5, 0.5);
    vec2 dir = TexCoord - center;
    float dist = length(dir);
    float angle = atan(dir.y, dir.x);
    float radius = dist + sin(time_f * 2.0 + dist * 10.0) * 0.05;
    vec2 spiral_offset = vec2(cos(angle), sin(angle)) * radius;
    vec2 spiral_TexCoord = center + spiral_offset;
    spiral_TexCoord = clamp(spiral_TexCoord, vec2(0.0), vec2(1.0));
    float gradient_pos = mod(dist * 3.0 - time_f * 0.5, 1.0);
    vec3 FragColor_gradient = rainbow(gradient_pos);
    vec4 ctx = texture(textTexture, TexCoord);
    FragColor = mix(ctx, vec4(FragColor_gradient, 1.0), 0.5);
}

