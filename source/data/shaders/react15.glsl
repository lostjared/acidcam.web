#version 300 es
precision highp float;


in vec2 TexCoord;
out vec4 FragColor;
uniform sampler2D textTexture;
uniform float time_f;
uniform vec2 iResolution;

vec3 rainbow(float t) {
    t = fract(t);
    float r = abs(t * 6.0 - 3.0) - 1.0;
    float g = 2.0 - abs(t * 6.0 - 2.0);
    float b = 2.0 - abs(t * 6.0 - 4.0);
    return clamp(vec3(r, g, b), 0.0, 1.0);
}

void main() {
    vec2 uv = TexCoord;
    float t = time_f * 0.1;
    vec3 rainbowColor = rainbow(uv.x + t);
    vec4 texColor = texture(textTexture, uv);
    FragColor = mix(texColor, vec4(rainbowColor, 1.0), 0.5);
}
