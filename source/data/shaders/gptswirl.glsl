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
    vec2 uv = TexCoord;
    vec2 center = vec2(0.5, 0.5);
    vec2 dir = uv - center;
    float dist = length(dir);
    float angle = atan(dir.y, dir.x);
    float swirl = dist * 5.0;
    angle += swirl * sin(time_f) * pingPong(dist + time_f, 1.0);
    uv = center + vec2(cos(angle), sin(angle)) * dist;
    vec4 texColor = texture(textTexture, uv);
    float FragColorMod = 0.5 + 0.5 * sin(time_f + dist * 10.0);
    FragColor = texColor * FragColorMod;
}
