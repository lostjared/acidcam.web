#version 300 es
precision highp float;

in vec2 TexCoord;
out vec4 FragColor;
uniform float time_f;
uniform sampler2D textTexture;
uniform vec2 iResolution;

float pingPong(float x, float length) {
    float modVal = mod(x, length * 2.0);
    return modVal <= length ? modVal : length * 2.0 - modVal;
}

void main(void) {
    vec2 normPos = gl_FragCoord.xy / iResolution.xy;
    
    vec2 mirroredPos = vec2(
        abs(fract(normPos.x * 2.0) - 0.5) * 2.0,
        abs(fract(normPos.y * 2.0) - 0.5) * 2.0
    );
    
    float time_t = pingPong(time_f, 6.0) + 2.0;
    float cycle = sin(time_t * 0.5);
    float movingPhase = mirroredPos.x + mirroredPos.y + cycle;
    float phase = sin(movingPhase * 10.0 - time_f * 2.0);
    
    vec2 TexCoordAdjusted = TexCoord + vec2(phase * 0.302, phase * 0.302);
    FragColor = texture(textTexture, TexCoordAdjusted);
}