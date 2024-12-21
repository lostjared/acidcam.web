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
    float t = mod(time_f, 10.0) * 0.1;
    float angle = sin(t * 3.14159265) * 0.5;
    vec2 center = vec2(0.5, 0.5);
    uv -= center;
    float dist = length(uv);
    float bend = sin(dist * 6.0 - t * 2.0 * 3.14159265) * 0.05;
    uv = mat2(cos(angle), -sin(angle), sin(angle), cos(angle)) * uv;
    uv += center;
    float time_t = pingPong(time_f, 10.0);
    uv += sin(time_t * bend) + tan(bend * uv * time_t) ;
    FragColor = texture(textTexture, uv);
}
