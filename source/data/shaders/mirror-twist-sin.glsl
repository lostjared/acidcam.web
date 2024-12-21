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

void main(void) {
    vec2 uv = TexCoord;
    float angle = time_f * 0.5;
    float radius = length(uv - 0.5);
    float twist = radius * 5.0;

    float s = sin(twist + angle);
    float c = cos(twist + angle);
    float time_t = pingPong(time_f, 25.0) + 1.0;
    uv -= 0.5;
    uv = mat2(c, -s, s, c) * uv;
    uv += 0.5;

    if (uv.x > 0.5) {
        uv.x = 1.0 - uv.x;
    } else {
        uv.x = uv.x;
    }

    FragColor = texture(textTexture, sin(uv * time_t));
}
