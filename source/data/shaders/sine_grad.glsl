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
    float scale = 5.0;
    float speed = 0.2;
    float gradient_pos = 0.5 + 0.5 * sin((TexCoord.x * scale + TexCoord.y * scale) + time_f * speed);
    vec3 FragColor_gradient = rainbow(gradient_pos);

    float time_t = pingPong(time_f, 10.0) + 2.0;
    vec4 ctx = texture(textTexture, TexCoord);
    FragColor = vec4(sin(ctx.rgb * time_t), ctx.a);
    FragColor = mix(FragColor, vec4(FragColor_gradient, 1.0), 0.5);
}
