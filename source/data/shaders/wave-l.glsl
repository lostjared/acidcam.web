#version 300 es
precision highp float;

out vec4 FragColor;
in vec2 TexCoord;

uniform sampler2D textTexture;
uniform float time_f;
uniform vec2 iResolution;

void main() {
    
    vec2 pos = TexCoord;
    
    float wave_x = sin((TexCoord.x + time_f) * 5.0);
    float wave_y = cos((TexCoord.y + time_f) * 8.0);

    pos.x += wave_x;
    pos.y += wave_y;
    FragColor = texture(textTexture, sin(pos * time_f));
}
