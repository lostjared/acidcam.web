#version 300 es
precision highp float;

in vec2 TexCoord;
out vec4 FragColor;
uniform float time_f;
uniform vec2 iResolution;
uniform sampler2D textTexture;

float PI = 3.1415926535897932384626433832795;

void main() {
    vec2 uv = (TexCoord - 0.5) * 2.0;
    uv.x *= iResolution.x / iResolution.y;
    
    float plasma = 0.0;
    plasma += sin((uv.x + time_f) * 5.0);
    plasma += sin((uv.y + time_f) * 5.0);
    plasma += sin((uv.x + uv.y + time_f) * 5.0);
    plasma += cos(length(uv + time_f) * 10.0);
    plasma *= 0.25;

    vec3 baseColor;
    baseColor.r = cos(plasma * PI + time_f * 0.2) * 0.5 + 0.5;
    baseColor.g = sin(plasma * PI + time_f * 0.2) * 0.5 + 0.5;
    baseColor.b = sin(plasma * PI + time_f * 0.4) * 0.5 + 0.5;

    float dispersion = 0.02;
    vec3 prismColor;
    prismColor.r = texture(textTexture, TexCoord + vec2(dispersion, 0.0)).r;
    prismColor.g = texture(textTexture, TexCoord).g;
    prismColor.b = texture(textTexture, TexCoord - vec2(dispersion, 0.0)).b;

    FragColor = vec4(mix(baseColor, prismColor, 0.6), 1.0);
}

