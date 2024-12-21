#version 300 es
precision highp float;
out vec4 FragColor;
in vec2 TexCoord;

uniform sampler2D textTexture;
uniform vec2 iResolution;

void main() {
    vec2 uv = TexCoord;
    if (uv.x < 0.5) {
        uv.x = 1.0 - uv.x;
    }
    FragColor = texture(textTexture, uv);
}
