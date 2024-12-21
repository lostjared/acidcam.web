#version 300 es
precision highp float;
in vec2 TexCoord;
out vec4 FragColor;
uniform float time_f;
uniform sampler2D textTexture;
uniform vec2 iResolution;

void main(void) {
    vec2 normPos = gl_FragCoord.xy / iResolution.xy;
    float cycle = sin(time_f * 0.5);
    float movingPhase = normPos.x + cycle;
    float phase = sin(movingPhase * 10.0 - time_f * 2.0);
    vec2 TexCoordAdjusted = TexCoord + (vec2(phase, 0) * 0.302);

    float gliTexCoordhFactor = sin(time_f);
    vec2 gliTexCoordhOffset = vec2(gliTexCoordhFactor * 0.1, gliTexCoordhFactor * 0.1);
    vec4 gliTexCoordhColor = texture(textTexture, TexCoord + gliTexCoordhOffset);

    vec4 baseColor = texture(textTexture, TexCoordAdjusted);
    FragColor = mix(baseColor, gliTexCoordhColor, 0.5);
}






