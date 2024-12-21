#version 300 es
precision highp float;


in vec2 TexCoord;
out vec4 FragColor;
uniform sampler2D textTexture;
uniform float time_f;

void main(void) {
    vec4 baseColor = texture(textTexture, TexCoord);
    float gliTexCoordhOffsetX = sin(time_f * 10.0 + TexCoord.y * 20.0) * 0.05;
    float gliTexCoordhOffsetY = cos(time_f * 15.0 + TexCoord.x * 25.0) * 0.05;
    vec2 gliTexCoordhTc = TexCoord + vec2(gliTexCoordhOffsetX, gliTexCoordhOffsetY);
    vec4 gliTexCoordhColor = texture(textTexture, gliTexCoordhTc);
    float gliTexCoordhStrength = 0.5 + 0.5 * sin(time_f * 3.0);
    FragColor = mix(baseColor, gliTexCoordhColor, gliTexCoordhStrength);
}
