#version 300 es
precision highp float;
in vec2 TexCoord;
out vec4 FragColor;

uniform sampler2D textTexture;
uniform float time_f;
uniform vec2 iResolution;
uniform float restore_black;
in float restore_black_value;
uniform vec4 inc_valuex;

float pingPong(float x, float length) {
    float modVal = mod(x, length * 2.0);
    return modVal <= length ? modVal : length * 2.0 - modVal;
}

void main(void)
{
    if(restore_black_value == 1.0 && texture(textTexture, TexCoord) == vec4(0, 0, 0, 1))
        discard;
    FragColor = texture(textTexture, TexCoord);
    vec2 pos = gl_FragCoord.xy / iResolution;
    vec4 s = FragColor * sin(inc_valuex / 255.0 * time_f);
    FragColor[0] += s[0] * pos[0];
    FragColor[1] += s[1] * pos[1];
 
    float time_t = pingPong(time_f, 20.0) + 2.0;
    
    FragColor = sin(FragColor * time_t);
}
