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
    float trailLength = 8.0;
    vec4 currentColor = texture(textTexture, TexCoord);

    vec4 shadowColor1 = texture(textTexture, TexCoord - vec2(sin(time_f), cos(time_f)) * 0.02 * pingPong(time_f, trailLength));
    vec4 shadowColor2 = texture(textTexture, TexCoord - vec2(sin(time_f + 1.0), cos(time_f + 1.0)) * 0.04 * pingPong(time_f + 1.0, trailLength));
    vec4 shadowColor3 = texture(textTexture, TexCoord - vec2(sin(time_f + 2.0), cos(time_f + 2.0)) * 0.06 * pingPong(time_f + 2.0, trailLength));

    vec4 shadowColor = (shadowColor1 + shadowColor2 + shadowColor3) / 3.0;

    FragColor = mix(currentColor, shadowColor, 0.5);
}
