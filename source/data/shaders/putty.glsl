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
    float timeVar = time_f * 0.5;
    vec2 noise = vec2(
        pingPong(TexCoord.x + timeVar, 1.0),
        pingPong(TexCoord.y + timeVar, 1.0)
    );

    float streTexCoordhFactorX = 1.0 + 0.3 * sin(time_f + TexCoord.y * 10.0);
    float streTexCoordhFactorY = 1.0 + 0.3 * cos(time_f + TexCoord.x * 10.0);
    
    vec2 distortedUV = vec2(
        TexCoord.x * streTexCoordhFactorX + noise.x * 0.1,
        TexCoord.y * streTexCoordhFactorY + noise.y * 0.1
    );

    FragColor = texture(textTexture, distortedUV);
}
