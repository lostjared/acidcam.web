#version 300 es
precision highp float;


in vec2 TexCoord;
out vec4 FragColor;
uniform sampler2D textTexture;
uniform float time_f;
uniform vec2 iResolution;

void main(void) {
    vec2 uv = TexCoord;
    vec2 pos = uv - 0.5;
    float len = length(pos);
    
    vec2 ripple = pos * (0.6 / len) * sin(len * 2.0 - time_f * 1.0);
    uv += ripple * 0.4;
    FragColor = texture(textTexture, uv);
}
