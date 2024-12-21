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
    vec2 uv = TexCoord * iResolution;
    uv -= 0.5 * iResolution;
    float dist = length(uv);
    float angle = atan(uv.y, uv.x);
    float time_t = pingPong(time_f, 20.0);
    float wave = sin(dist * 10.0 - time_f * 5.0 + angle * 5.0);
    wave = sin(wave * time_t);
    
    vec4 texColor = texture(textTexture, TexCoord);
    
    FragColor = texColor * (0.5 + 0.5 * wave);
}

