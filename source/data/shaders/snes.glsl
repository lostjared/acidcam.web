#version 300 es
precision highp float;
out vec4 FragColor;
in vec2 TexCoord;

uniform sampler2D textTexture;
uniform float time_f;
uniform vec2 iResolution;

void main(void) {
    vec2 uv = TexCoord;
    float pixelSize = 0.01;
    uv = floor(uv / pixelSize) * pixelSize;
    vec4 texColor = texture(textTexture, uv);
    vec3 paletteColor = floor(texColor.rgb * 31.0) / 31.0;
    FragColor = vec4(paletteColor, texColor.a);
}
