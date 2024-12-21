#version 300 es
precision highp float;


in vec2 TexCoord;
out vec4 FragColor;
in float restore_black_value;

uniform sampler2D textTexture;

void main(void) {
    vec2 mirrored_TexCoord = abs(fract(TexCoord) - 0.5) + 0.5;
    vec4 FragColor1 = texture(textTexture, mirrored_TexCoord);
    vec4 FragColor2 = texture(textTexture, mirrored_TexCoord * 0.5);
    vec4 FragColor3 = texture(textTexture, mirrored_TexCoord * 0.25);
    vec4 FragColor4 = texture(textTexture, mirrored_TexCoord * 0.125);
    FragColor = (FragColor1 * 0.4) + (FragColor2 * 0.3) + (FragColor3 * 0.2) + (FragColor4 * 0.1);
}

