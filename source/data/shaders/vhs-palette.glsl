#version 300 es
precision highp float;
out vec4 FragColor;
in vec2 TexCoord;

uniform sampler2D textTexture;

void main(void) {
    vec4 texColor = texture(textTexture, TexCoord);

    vec4 vhsColor = texColor;
    vhsColor.rgb = vhsColor.rgb * vec3(0.9, 0.85, 0.8) + vec3(0.1, 0.1, 0.15);
    vhsColor.rgb = clamp(vhsColor.rgb, 0.0, 1.0);

    FragColor = vhsColor;
}
