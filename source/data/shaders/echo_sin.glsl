#version 300 es
precision highp float;
in vec2 TexCoord;
out vec4 FragColor;
uniform sampler2D textTexture;
uniform float time_f;

float pingPong(float x, float length) {
    float modVal = mod(x, length * 2.0);
    return modVal <= length ? modVal : length * 2.0 - modVal;
}

void main(void)
{
    FragColor = texture(textTexture, TexCoord);
    vec4 FragColor2 = texture(textTexture, TexCoord / 2);
    vec4 FragColor3 = texture(textTexture, TexCoord / 4);
    vec4 FragColor4 = texture(textTexture, TexCoord / 8);
    FragColor = (FragColor * 0.4) + (FragColor2 * 0.4) + (FragColor3 * 0.4) + (FragColor4 * 0.4);
    
    float time_t = pingPong(time_f, 10.0) + 2.0;
    FragColor = sin(FragColor * time_t);
}
