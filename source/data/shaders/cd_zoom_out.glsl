#version 300 es
precision highp float;
out vec4 FragColor;
in vec2 TexCoord;

uniform sampler2D textTexture;
uniform float time_f;
uniform vec2 iResolution;

void main(void) {
    vec2 centeredCoord = TexCoord - 0.5;
    float angle = time_f;
    
    float zoom = 2.5 - abs(sin(time_f)) * 4.0;
    centeredCoord *= zoom;
    
    vec2 rotatedCoord;
    rotatedCoord.x = centeredCoord.x * cos(angle) - centeredCoord.y * sin(angle);
    rotatedCoord.y = centeredCoord.x * sin(angle) + centeredCoord.y * cos(angle);
    rotatedCoord += 0.5;
    
    FragColor = texture(textTexture, rotatedCoord);
}
