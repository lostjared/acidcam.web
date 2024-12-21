#version 300 es
precision highp float;

out vec4 FragColor;
in vec2 TexCoord;

uniform sampler2D textTexture;
uniform float time_f;
uniform vec2 iResolution;

void main() {
    vec2 uv = TexCoord;
    float centerY = 0.5 + 0.25 * sin(time_f);
    float shiftAmount = 0.1 * sin(time_f);

    if (uv.y > centerY) {
        uv.x += shiftAmount;
    } else {
        uv.x -= shiftAmount;
    }

    vec4 baseColor = texture(textTexture, uv);
    FragColor = baseColor;
}
