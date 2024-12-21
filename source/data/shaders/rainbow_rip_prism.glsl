#version 300 es
precision highp float;

in vec2 TexCoord;
out vec4 FragColor;
uniform float time_f;
uniform sampler2D textTexture;
uniform vec2 iResolution;

vec3 hsv2rgb(vec3 c) {
    vec4 K = vec4(1.0, 2.0/3.0, 1.0/3.0, 3.0);
    vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
    return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}

float pingPong(float x, float length) {
    float modVal = mod(x, length * 2.0);
    return modVal <= length ? modVal : length * 2.0 - modVal;
}

void main(void) {
    float time_z = pingPong(time_f, 4.0) + 0.5;
    vec2 uv = gl_FragCoord.xy / iResolution.xy;
    vec2 normPos = uv * 2.0 - 1.0 * time_z;
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
    vec3 texColor = vec3(r, g, b);
    float angle = atan(normPos.y, normPos.x);
    float spiral = angle + time_f * 1.0;
    float hue = mod(spiral / (2.0 * 3.14159265), 1.0);
    vec3 rainbowColor = hsv2rgb(vec3(hue, 1.0, 1.0));
    vec3 finalColor = texColor * rainbowColor;
    float time_t = pingPong(time_f, 8.0) + 2.0;
    FragColor = vec4(sin(finalColor * time_t), 1.0);
}
