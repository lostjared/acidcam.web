#version 300 es
precision highp float;
out vec4 FragColor;
in vec2 TexCoord;

uniform sampler2D textTexture;
uniform vec2 iResolution;
uniform float time_f;

float pingPong(float t, float l) {
    return abs(mod(t, 2.0 * l) - l);
}

void main() {
    vec2 uv = TexCoord;
    float streTexCoordh = 1.0 + pingPong(time_f, 2.0) * 0.5;

    if (uv.x < 0.5) {
        uv.x = 0.5 - (0.5 - uv.x) * streTexCoordh;
        uv.x = 1.0 - uv.x;
    } else {
        uv.x = 0.5 + (uv.x - 0.5) * streTexCoordh;
    }
    FragColor = texture(textTexture, uv);
}
