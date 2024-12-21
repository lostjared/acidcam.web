#version 300 es
precision highp float;

in vec2 TexCoord;
out vec4 FragColor;
uniform float time_f;
uniform sampler2D textTexture;
uniform vec2 iResolution;

void main(void) {
    vec2 normCoord = gl_FragCoord.xy / iResolution.xy;
float diagonalDistance = (normCoord.x + normCoord.y - 1.0) * sqrt(2.0);
    float antiDiagonalDistance = (normCoord.x - normCoord.y) * sqrt(2.0);
    float diagonalWave = sin((diagonalDistance + time_f) * 5.0); // Wave frequency and speed
    float antiDiagonalWave = cos((antiDiagonalDistance + time_f) * 5.0);
    float combinedWave = (diagonalWave + antiDiagonalWave) * 0.5;

    vec2 waveAdjusted = vec2(TexCoord.x + combinedWave * 0.202, TexCoord.y + combinedWave * 0.202);
    
    FragColor = texture(textTexture, waveAdjusted);
}
