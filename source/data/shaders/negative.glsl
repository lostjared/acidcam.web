#version 300 es
precision highp float;
out vec4 FragColor;
in vec2 TexCoord;

uniform sampler2D textTexture;
uniform float time_f;
uniform vec2 iResolution;

void main(void) {
    vec4 texColor = texture(textTexture, TexCoord);
    FragColor = vec4(1.0 - texColor.rgb, texColor.a);
}
