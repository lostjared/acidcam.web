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

    float time_t =  pingPong(time_f, 10);
    
    float scrambleAmount = sin(time_f * 10.0) * 0.5 + 0.5;
    
    scrambleAmount = cos(scrambleAmount * time_t);
    
    uv.x += sin(uv.y * 50.0 + time_f * 10.0) * scrambleAmount * 0.05;
    uv.y += cos(uv.x * 50.0 + time_f * 10.0) * scrambleAmount * 0.05;

    FragColor = texture(textTexture, tan(uv * time_t));
}
