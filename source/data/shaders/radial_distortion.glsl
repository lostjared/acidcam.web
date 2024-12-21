#version 300 es
precision highp float;

in vec2 TexCoord;
out vec4 FragColor;
uniform sampler2D textTexture;
uniform float time_f;
uniform vec2 iResolution;

float pingPong(float x, float length) {
    float modVal = mod(x, length * 2.0);
    return modVal <= length ? modVal : length * 2.0 - modVal;
}

void main(void) {
    vec2 uv = TexCoord - 0.5;
    float len = length(uv);
    float time_t = pingPong(time_f, 2.0) + 0.05;
    
    float radialDistortion = sin(len * 10.0 - time_f) * time_t;
    uv += uv * radialDistortion;

    float warpFactor = sin(time_f) * 0.5 + 0.5;
    vec2 warpedCoords;
    warpedCoords.x = pingPong(uv.x + time_f * 0.1, 1.0);
    warpedCoords.y = pingPong(uv.y + time_f * 0.1, 1.0);
    float timeVar = time_f * 0.5;
    vec2 noise = vec2(
        pingPong(warpedCoords.x + timeVar, 1.0),
        pingPong(warpedCoords.y + timeVar, 1.0)
    );

    float streTexCoordhFactorX = 1.0 + 0.3 * sin(time_f + warpedCoords.y * 10.0);
    float streTexCoordhFactorY = 1.0 + 0.3 * cos(time_f + warpedCoords.x * 10.0);
    
    vec2 finalUV = vec2(
        warpedCoords.x * streTexCoordhFactorX + noise.x * 0.1,
        warpedCoords.y * streTexCoordhFactorY + noise.y * 0.1
    );

    FragColor = texture(textTexture, finalUV + 0.5);
}
