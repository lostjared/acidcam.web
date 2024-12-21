#version 300 es
precision highp float;


in vec2 TexCoord;
out vec4 FragColor;
uniform sampler2D textTexture;
uniform float time_f;

void main(void) {
    vec2 uv = TexCoord;
    float amplitude = sin(time_f) * 0.5 + 0.5;
    vec2 distortedUV = uv + vec2(sin(uv.y * 10.0 + time_f) * 0.1, cos(uv.x * 10.0 + time_f) * 0.1) * amplitude;
    FragColor = texture(textTexture, distortedUV);
}
