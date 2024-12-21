#version 300 es
precision highp float;


in vec2 TexCoord;
out vec4 FragColor;
uniform sampler2D textTexture;
uniform float time_f;

void main(void) {
    vec2 redOffset = vec2(sin(time_f * 5.0), cos(time_f * 5.0)) * 0.02;
    vec2 greenOffset = vec2(cos(time_f * 7.0), sin(time_f * 7.0)) * 0.02;
    vec2 blueOffset = vec2(sin(time_f * 3.0), cos(time_f * 3.0)) * 0.02;

    vec4 redChannel = texture(textTexture, TexCoord + redOffset);
    vec4 greenChannel = texture(textTexture, TexCoord + greenOffset);
    vec4 blueChannel = texture(textTexture, TexCoord + blueOffset);

    FragColor = vec4(redChannel.r, greenChannel.g, blueChannel.b, 1.0);
}
