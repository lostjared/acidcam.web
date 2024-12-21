#version 300 es
precision highp float;


in vec2 TexCoord;
out vec4 FragColor;
uniform sampler2D textTexture;
uniform float time_f;

void main(void) {
    float tear1 = sin(TexCoord.x * 10.0 + time_f * 5.0) * 0.05;
    float tear2 = sin(TexCoord.x * 20.0 + time_f * 7.0) * 0.03;
    float tear3 = sin(TexCoord.x * 30.0 + time_f * 9.0) * 0.02;
    
    float combined_tear = tear1 + tear2 + tear3;
    vec2 new_TexCoord = vec2(TexCoord.x + combined_tear, TexCoord.y + combined_tear);
    FragColor = texture(textTexture, new_TexCoord);
}
