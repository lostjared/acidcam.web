#version 300 es
precision highp float;

in vec2 TexCoord;
out vec4 FragColor;
uniform sampler2D textTexture;
in vec2 iResolution_;
uniform float time_f;

void main(void)
{
    vec2 mirrored_TexCoord = TexCoord;
    
    int direction = int(mod(time_f, 4.0));
    
    if (direction == 0) {
        mirrored_TexCoord = TexCoord;
    } else if (direction == 1) {
        mirrored_TexCoord.x = 1.0 - TexCoord.x;
    } else if (direction == 2) {
        mirrored_TexCoord.y = 1.0 - TexCoord.y;
    } else if (direction == 3) {
        mirrored_TexCoord = 1.0 - TexCoord;
    }

    FragColor = texture(textTexture, mirrored_TexCoord);
}

