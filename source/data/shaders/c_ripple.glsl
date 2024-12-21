#version 300 es
precision highp float;


in vec2 TexCoord;
out vec4 FragColor;
uniform sampler2D textTexture;
uniform float time_f;

float pingPong(float x, float length) {
    float modVal = mod(x, length * 2.0);
    return modVal <= length ? modVal : length * 2.0 - modVal;
}

void main(void) {
    float time_t = pingPong(time_f, 10.0);
    
    float dist = sqrt(TexCoord.x * TexCoord.x + TexCoord.y * TexCoord.y);
    dist = sin(dist * time_t);
    float ripple = sin(dist * 10.0 - time_f * 5.0);
    vec2 offset = TexCoord + ripple * 0.02;
    vec4 texColor = texture(textTexture, offset);
    FragColor = texColor;
}
