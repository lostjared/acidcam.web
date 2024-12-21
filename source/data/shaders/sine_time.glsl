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
    vec4 FragColor_solid = vec4(0.3, 0.1, 0.8, 1.0);
    float time_t = pingPong(time_f, 10.0) + 2.0;
    vec4 ctx = texture(textTexture, TexCoord);
    FragColor = vec4(sin(ctx.rgb * time_t) , ctx.a);
    FragColor = mix(FragColor, FragColor_solid, 0.5);
}
