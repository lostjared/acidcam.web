#version 300 es
precision highp float;
out vec4 FragColor;
in vec2 TexCoord;

uniform sampler2D textTexture;
uniform float time_f;
uniform vec2 iResolution;

void main(void) {
    vec2 uv = TexCoord;
    vec2 pixelSize = vec2(0.01, 0.01);
    uv = floor(uv / pixelSize) * pixelSize;
    FragColor = texture(textTexture, uv);
}
