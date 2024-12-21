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
    float swirl_strength = 0.1;
    float swirl_speed = 1.0;
    float angle = swirl_speed * time_f + length(TexCoord - 0.5);
    vec2 swirl_offset = vec2(cos(angle), sin(angle)) * swirl_strength;
    vec2 swirl_TexCoord = TexCoord + swirl_offset;
    swirl_TexCoord = clamp(swirl_TexCoord, vec2(0.0), vec2(1.0));
    float scale = 5.0;
    float speed = 0.2;
    float gradient_pos = 0.5 + 0.5 * sin((swirl_TexCoord.x * scale + swirl_TexCoord.y * scale) + time_f * speed);
    vec3 FragColor_gradient = rainbow(gradient_pos);
    vec4 ctx = texture(textTexture, swirl_TexCoord);
    FragColor = vec4(sin(ctx.rgb * time_f), ctx.a);
    FragColor = mix(FragColor, vec4(FragColor_gradient, 1.0), 0.5);
}
