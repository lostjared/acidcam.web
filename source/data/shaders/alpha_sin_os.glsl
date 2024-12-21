#version 300 es
precision highp float;

out vec4 FragColor;
in vec2 TexCoord;

uniform sampler2D textTexture;
uniform float time_f;
uniform vec2 iResolution;

float pingPong(float value, float range) {
    float modValue = mod(value, 2.0 * range);
    return range - abs(modValue - range);
}


void main() {
    vec2 uv = TexCoord;
    vec4 pixelColor = texture(textTexture, uv);
    float scale = 0.5 + 0.5 * pingPong(time_f, 8.0) + 1.5;
    vec4 scaledColor = mod(pixelColor * scale, 1.0);
    FragColor = scaledColor;
}
