#version 300 es
precision highp float;
in vec2 TexCoord;
out vec4 FragColor;

uniform sampler2D textTexture;
uniform float time_f;

void main(void)
{
    vec2 center = vec2(0.5, 0.5);
    float angle = time_f;
    vec2 TexCoord1 = TexCoord;
    vec2 TexCoord2 = TexCoord - center;
    TexCoord2 *= 0.8;
    TexCoord2 = vec2(
        TexCoord2.x * cos(angle + 1.0) - TexCoord2.y * sin(angle + 1.0),
        TexCoord2.x * sin(angle + 1.0) + TexCoord2.y * cos(angle + 1.0)
    );
    TexCoord2 += center;
    TexCoord2 = fract(TexCoord2);
    vec2 TexCoord3 = TexCoord - center;
    TexCoord3 *= 0.6;
    TexCoord3 = vec2(
        TexCoord3.x * cos(angle + 2.0) - TexCoord3.y * sin(angle + 2.0),
        TexCoord3.x * sin(angle + 2.0) + TexCoord3.y * cos(angle + 2.0)
    );
    TexCoord3 += center;
    TexCoord3 = fract(TexCoord3);
    vec2 TexCoord4 = TexCoord - center;
    TexCoord4 *= 0.4;
    TexCoord4 = vec2(
        TexCoord4.x * cos(angle + 3.0) - TexCoord4.y * sin(angle + 3.0),
        TexCoord4.x * sin(angle + 3.0) + TexCoord4.y * cos(angle + 3.0)
    );
    TexCoord4 += center;
    TexCoord4 = fract(TexCoord4);
    vec4 FragColor1 = texture(textTexture, TexCoord1);
    vec4 FragColor2 = texture(textTexture, TexCoord2);
    vec4 FragColor3 = texture(textTexture, TexCoord3);
    vec4 FragColor4 = texture(textTexture, TexCoord4);
    FragColor = (FragColor1 + FragColor2 + FragColor3 + FragColor4) * 0.25;
}

