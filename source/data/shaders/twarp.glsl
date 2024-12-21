#version 300 es
precision highp float;
out vec4 FragColor;
in vec2 TexCoord;

uniform sampler2D textTexture;
uniform float time_f;
uniform vec2 iResolution;

void main(void) {
    vec2 uv = TexCoord;
    float warpX = tan(uv.y * 10.0 + time_f) * 0.1;
    float warpY = tan(uv.x * 10.0 + time_f) * 0.1;
    uv.x += warpX;
    uv.y += warpY;
    FragColor = texture(textTexture, uv);
}

