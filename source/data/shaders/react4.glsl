#version 300 es
precision highp float;


in vec2 TexCoord;
out vec4 FragColor;
uniform sampler2D textTexture;
uniform float time_f;

void main(void) {
    vec2 uv = TexCoord - 0.5;
    float drumEffect = sin(time_f * 10.0) * 0.1;
    vec2 drumUV = uv * (1.0 + drumEffect);
    FragColor = texture(textTexture, drumUV + 0.5);
}
