
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
    float tear4 = sin(TexCoord.x * 40.0 + time_f * 11.0) * 0.015;
    float tear5 = sin(TexCoord.x * 50.0 + time_f * 13.0) * 0.01;
    float tear6 = sin(TexCoord.x * 60.0 + time_f * 15.0) * 0.007;
    float tear7 = sin(TexCoord.x * 70.0 + time_f * 17.0) * 0.005;
    float tear8 = sin(TexCoord.x * 80.0 + time_f * 19.0) * 0.003;
    float tear9 = sin(TexCoord.x * 90.0 + time_f * 21.0) * 0.002;
    
    float combined_tear = tear1 + tear2 + tear3 + tear4 + tear5 + tear6 + tear7 + tear8 + tear9;
    
    vec2 new_TexCoord = vec2(TexCoord.x + combined_tear, TexCoord.y + combined_tear);
    
    FragColor = texture(textTexture, new_TexCoord);
}
