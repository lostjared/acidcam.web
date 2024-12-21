#version 300 es
precision highp float;


in vec2 TexCoord;
out vec4 FragColor;
uniform sampler2D textTexture;
uniform float time_f;

void main(void) {
     float tear = sin(TexCoord.x * 10.0 + time_f * 5.0) * 0.05;
    vec2 new_TexCoord = vec2(TexCoord.x + tear, TexCoord.y + tear);
    FragColor = texture(textTexture, new_TexCoord);
}
