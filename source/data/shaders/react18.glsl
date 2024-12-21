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
    float gliTexCoordhStrength = 0.05;
    vec2 gliTexCoordh = vec2(
        pingPong(time_f * 10.0 + TexCoord.y * 20.0, 1.0) * gliTexCoordhStrength,
        pingPong(time_f * 10.0 + TexCoord.x * 20.0, 1.0) * gliTexCoordhStrength
    );
    vec2 displacedTc = TexCoord + gliTexCoordh;
    FragColor = texture(textTexture, displacedTc);
}
