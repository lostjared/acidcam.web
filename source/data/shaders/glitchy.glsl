#version 300 es
precision highp float;
out vec4 FragColor;
in vec2 TexCoord;

uniform sampler2D textTexture;
uniform float time_f;
uniform vec2 iResolution;

void main(void) {
    vec2 uv = TexCoord;
    float gliTexCoordhFactorX = sin(time_f * 10.0 + uv.y * 20.0) * 0.1;
    float gliTexCoordhFactorY = cos(time_f * 7.0 + uv.x * 15.0) * 0.1;
    uv.x += gliTexCoordhFactorX;
    uv.y += gliTexCoordhFactorY;

    float gliTexCoordhLine = fract(sin(dot(uv * time_f, vec2(12.9898, 78.233))) * 43758.5453);
    if (gliTexCoordhLine < 0.1) {
        uv.x += sin(time_f * 50.0) * 0.02;
    } else if (gliTexCoordhLine < 0.2) {
        uv.y += cos(time_f * 50.0) * 0.02;
    }

    float gliTexCoordhBlock = fract(sin(dot(uv * time_f, vec2(39.3468, 11.135))) * 23454.2345);
    if (gliTexCoordhBlock < 0.15) {
        uv.x = mod(uv.x * 5.0, 1.0);
        uv.y = mod(uv.y * 5.0, 1.0);
    }

    vec2 uvOffset = vec2(sin(time_f * 20.0 + uv.y * 30.0), cos(time_f * 20.0 + uv.x * 30.0)) * 0.03;
    uv += uvOffset;

    FragColor = texture(textTexture, uv);
}
