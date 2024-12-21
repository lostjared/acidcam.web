#version 300 es
precision highp float;
out vec4 FragColor;
in vec2 TexCoord;

uniform sampler2D textTexture;
uniform float time_f;
uniform vec2 iResolution;

void main(void) {
    float mirrorAmount = sin(time_f * 3.14159);
    vec2 mirroredTC = vec2(abs(mirrorAmount * (TexCoord.x - 0.5)) + 0.5 * sign(mirrorAmount), TexCoord.y);
    FragColor = texture(textTexture, mirroredTC);
}
