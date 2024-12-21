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

void main() {
    float displacement = pingPong(TexCoord.x * iResolution.x + time_f * 50.0, 20.0);
    vec2 distortedTC = vec2(
        atan(TexCoord.y - 0.5, TexCoord.x - 0.5) / 3.14159 + 0.5,
        TexCoord.y + sin(time_f * 2.0) * 0.02
    );
    distortedTC.x += displacement / iResolution.x;
    FragColor = texture(textTexture, sin(distortedTC * time_f));
}
