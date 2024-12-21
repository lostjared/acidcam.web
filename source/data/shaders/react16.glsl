#version 300 es
precision highp float;
out vec4 FragColor;
in vec2 TexCoord;
uniform sampler2D textTexture;
uniform vec2 iResolution;
uniform float time_f;

void main(void) {
    vec2 normPos = (gl_FragCoord.xy / iResolution.xy) * 2.0 - 1.0;
    float dist = length(normPos);
    float phase = sin(dist * 10.0 - time_f * 4.0);
    vec2 TexCoordAdjusted = TexCoord + (normPos * 0.305 * phase);
    vec4 FragColor1 = texture(textTexture, TexCoordAdjusted);
    vec2 centeredCoord = (TexCoord * 2.0) - vec2(1.0, 1.0);
    float streTexCoordhFactor = 1.0 + (1.0 - abs(centeredCoord.y)) * 0.5;
    centeredCoord.x *= sin(streTexCoordhFactor * time_f);
    vec2 streTexCoordhedCoord = (centeredCoord + vec2(1.0, 1.0)) / 2.0;
    vec4 FragColor2 = texture(textTexture, streTexCoordhedCoord);

    float gliTexCoordhFactor = sin(time_f * 50.0);
    vec4 gliTexCoordhColor = texture(textTexture, TexCoord + vec2(gliTexCoordhFactor * 0.1, gliTexCoordhFactor * 0.1));
    
    FragColor = mix(mix(FragColor1, FragColor2, 0.5), gliTexCoordhColor, 0.5);
}
