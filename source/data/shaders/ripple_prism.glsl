#version 300 es
precision highp float;

in vec2 TexCoord;
out vec4 FragColor;
uniform float time_f;
uniform sampler2D textTexture;
uniform vec2 iResolution;

void main(void) {
    vec2 normPos = (gl_FragCoord.xy / iResolution.xy) * 2.0 - 1.0;
    float dist = length(normPos);
    float phase = sin(dist * 10.0 - time_f * 4.0);
    vec2 TexCoordAdjusted = TexCoord + (normPos * 0.305 * phase);
    float dispersionScale = 0.02;
    vec2 dispersionOffset = normPos * dist * dispersionScale;
    vec2 TexCoordAdjustedR = TexCoordAdjusted + dispersionOffset * (-1.0);
    vec2 TexCoordAdjustedG = TexCoordAdjusted;
    vec2 TexCoordAdjustedB = TexCoordAdjusted + dispersionOffset * 1.0;
    float r = texture(textTexture, TexCoordAdjustedR).r;
    float g = texture(textTexture, TexCoordAdjustedG).g;
    float b = texture(textTexture, TexCoordAdjustedB).b;
    FragColor = vec4(r, g, b, 1.0);
}

