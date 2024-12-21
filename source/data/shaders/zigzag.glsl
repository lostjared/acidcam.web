#version 300 es
precision highp float;
out vec4 FragColor;
in vec2 TexCoord;

uniform sampler2D textTexture;
uniform float time_f;
uniform vec2 iResolution;

void main(void) {
    vec2 normCoord = TexCoord;
    float timeAdjustedFrequency = 10.0 + sin(time_f) * 5.0;
    
    float timeAdjustedAmplitude = 0.01 + (sin(time_f * 0.5) * 0.5 + 0.5) * 0.05;
    float zigzagFactor = abs(fract(normCoord.y * timeAdjustedFrequency) - 0.5) * 2.0;
    float xDisplacement = zigzagFactor * timeAdjustedAmplitude;
    vec2 displacedCoord = vec2(normCoord.x + xDisplacement, normCoord.y);
    displacedCoord = clamp(displacedCoord, 0.0, 1.0);
    FragColor = texture(textTexture, displacedCoord);
}
