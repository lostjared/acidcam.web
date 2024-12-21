#version 300 es
precision highp float;


in vec2 TexCoord;
out vec4 FragColor;

uniform sampler2D textTexture;
uniform float time_f;
uniform vec2 iResolution;

vec4 adjustHue(vec4 FragColor, float angle) {
    float U = cos(angle);
    float W = sin(angle);
    mat3 rotationMatrix = mat3(
        0.299, 0.587, 0.114,
        0.299, 0.587, 0.114,
        0.299, 0.587, 0.114
    ) + mat3(
        0.701, -0.587, -0.114,
        -0.299, 0.413, -0.114,
        -0.3, -0.588, 0.886
    ) * U + mat3(
        0.168, 0.330, -0.497,
        -0.328, 0.035, 0.292,
        1.25, -1.05, -0.203
    ) * W;
    return vec4(rotationMatrix * FragColor.rgb, FragColor.a);
}

void main() {
    vec2 uv = TexCoord;
    vec4 textTextureledColor = texture(textTexture, uv);
    float hueShift = sin(uv.x * 10.0 + uv.y * 10.0 + time_f);
    vec4 adjustedColor = adjustHue(textTextureledColor, hueShift);
    FragColor = adjustedColor;
}

