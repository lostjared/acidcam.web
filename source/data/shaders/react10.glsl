#version 300 es
precision highp float;


in vec2 TexCoord;
out vec4 FragColor;
uniform sampler2D textTexture;
uniform float time_f;

void main(void) {
    float amplitude = sin(time_f * 5.0) * 2.0;
    float distFromCenter = abs(TexCoord.y - 0.5);
    vec2 distorted_TexCoord = TexCoord;
    distorted_TexCoord.y += amplitude * (0.5 - distFromCenter) * distFromCenter;
    distorted_TexCoord = clamp(distorted_TexCoord, vec2(0.0), vec2(1.0));
    FragColor = texture(textTexture, distorted_TexCoord);
}
