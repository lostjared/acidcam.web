#version 300 es
precision highp float;
out vec4 FragColor;
in vec2 TexCoord;

uniform sampler2D textTexture;
uniform float time_f;
uniform vec2 iResolution;

void main(void) {
    vec2 uv = TexCoord;
    float foldAmount = sin(time_f * 3.14159);
    
    if (foldAmount > 0.0) {
        if (uv.x < 0.5) {
            uv.x = mix(uv.x, 0.5, foldAmount);
        } else {
            uv.x = mix(uv.x, 0.5, foldAmount);
        }
    } else {
        uv.x = mix(0.5 + abs(uv.x - 0.5), uv.x, abs(foldAmount));
    }
    vec2 translate = vec2(sin(time_f * 2.0), cos(time_f * 2.0)) * 0.25;
    uv += translate * foldAmount;
    uv = (uv - 0.5) * 1.5 + 0.5;
    uv = clamp(uv, 0.0, 1.0);
    FragColor = texture(textTexture, uv);
}
