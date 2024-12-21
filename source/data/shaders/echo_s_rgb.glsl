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

    vec4 FragColor1 = texture(textTexture, TexCoord1);
    vec4 FragColor2 = texture(textTexture, TexCoord2);
    vec4 FragColor3 = texture(textTexture, TexCoord3);
    float pi = 3.14159265;
    float offset = 2.0 * pi / 3.0;

    float w0 = sin(time_f) * 0.5 + 0.5;
    float w1 = sin(time_f + offset) * 0.5 + 0.5;
    float w2 = sin(time_f + 2.0 * offset) * 0.5 + 0.5;

    vec3 weights1 = vec3(w0, 0.0, 0.0);
    vec3 weights2 = vec3(0.0, w1, 0.0);
    vec3 weights3 = vec3(0.0, 0.0, w2);

    vec3 finalColor = FragColor1.rgb * weights1 + FragColor2.rgb * weights2 + FragColor3.rgb * weights3;

    FragColor = vec4(finalColor, 1.0);
}

