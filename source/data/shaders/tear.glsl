#version 300 es
precision highp float;
out vec4 FragColor;
in vec2 TexCoord;
uniform sampler2D textTexture;
uniform vec2 iResolution;
uniform float time_f;
void main(void){
    vec2 normCoord = TexCoord;
    float tearLine = sin(time_f) * 0.5 + 0.5;
    float distFromTear = abs(normCoord.x - tearLine);
    float displacement = 0.202 * (1.0 - smoothstep(0.0, 0.1, distFromTear));
    normCoord.y += sin(displacement);
    FragColor = texture(textTexture, normCoord);
}
