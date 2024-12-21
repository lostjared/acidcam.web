#version 300 es
precision highp float;

uniform float time_f;
uniform vec2 iResolution;
uniform sampler2D textTexture;
in vec2 TexCoord;
out vec4 FragColor;

float pingPong(float x, float length) {
    float modVal = mod(x, length * 2.0);
    return modVal <= length ? modVal : length * 2.0 - modVal;
}

void main() {
    vec2 uv = TexCoord - 0.5;
    uv.y *= iResolution.y / iResolution.x;
    float intensity = pingPong(time_f, 10.0);
    float angle = atan(uv.y, uv.x);
    float radius = length(uv);
    float swirl = sin(time_f * 0.5) * 0.5 + 0.5;
    angle += intensity * swirl * sin(radius * 10.0 + time_f);
    uv = vec2(cos(angle), sin(angle)) * radius;
    vec4 texColor = texture(textTexture, uv + 0.5);
    FragColor = texColor;
}

