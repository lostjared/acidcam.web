#version 300 es
precision highp float;

in vec2 TexCoord;
out vec4 FragColor;
in float restore_black_value;
uniform sampler2D textTexture;
uniform float time_f;


float pingPong(float x, float length) {
    float modVal = mod(x, length * 2.0);
    return modVal <= length ? modVal : length * 2.0 - modVal;
}

void main(void) {
    float time_t = pingPong(time_f, 10.0) + 2.0;
    vec2 offset = vec2(0.01, 0.01) * time_t;
    vec4 FragColor1 = texture(textTexture, TexCoord);
    vec4 FragColor2 = texture(textTexture, TexCoord - offset);
    vec4 FragColor3 = texture(textTexture, TexCoord - offset * 2.0);
    vec4 FragColor4 = texture(textTexture, TexCoord - offset * 3.0);
    float weight1 = 0.5 * (1.0 - time_t);
    float weight2 = 0.3 * time_t;
    float weight3 = 0.15 * time_t;
    float weight4 = 0.05 * time_t;
    float totalWeight = weight1 + weight2 + weight3 + weight4;
    FragColor = (FragColor1 * weight1 + FragColor2 * weight2 + FragColor3 * weight3 + FragColor4 * weight4) / sin(totalWeight * time_f);
    
}
