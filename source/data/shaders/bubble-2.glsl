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
    vec2 uv = TexCoord * 2.0 - 1.0;
    float len = length(uv);
    float time_t = pingPong(time_f, 10.0);
    float bubble = smoothstep(0.8, 1.0, 1.0 - len);
    bubble = sin(bubble * time_t);
    
    vec2 distort = uv * (1.0 + 0.1 * sin(time_f + len * 20.0));
    
    distort = sin(distort * time_t);
    
    vec4 texColor = texture(textTexture, distort * 0.5 + 0.5);
    FragColor = mix(texColor, vec4(1.0, 1.0, 1.0, 1.0), bubble);
}
