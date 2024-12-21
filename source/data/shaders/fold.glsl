#version 300 es
precision highp float;
out vec4 FragColor;
in vec2 TexCoord;

uniform sampler2D textTexture;
uniform float time_f;
uniform vec2 iResolution;

void main(void) {
    float foldAmount = sin(time_f * 3.14159);
    vec2 foldedTC = vec2(TexCoord.x, abs(foldAmount * (TexCoord.y - 0.5)) + 0.5 * sign(foldAmount));
    FragColor = texture(textTexture, foldedTC);
}
