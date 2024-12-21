#version 300 es
precision highp float;
out vec4 FragColor;
in vec2 TexCoord;

uniform sampler2D textTexture;
uniform float time_f;
uniform vec2 iResolution;

vec3 getRainbowColor(float position) {
    float r = sin(position + 0.0) * 0.5 + 0.5;
    float g = sin(position + 2.0) * 0.5 + 0.5;
    float b = sin(position + 4.0) * 0.5 + 0.5;
    return vec3(r, g, b);
}

float pingPong(float x, float length) {
    float modVal = mod(x, length * 2.0);
    return modVal <= length ? modVal : length * 2.0 - modVal;
}


void main(void) {
    float time_t = pingPong(time_f, 10.0) + 2.0;
    float wave = sin(TexCoord.y * 10.0 + time_f) * 0.05;
    vec2 new_TexCoord = vec2(TexCoord.x + wave, TexCoord.y);
    vec4 texColor = texture(textTexture, new_TexCoord);
    
    float spiralPosX = TexCoord.x * cos(time_f) - TexCoord.y * sin(time_f);
    float spiralPosY = TexCoord.x * sin(time_f) + TexCoord.y * cos(time_f);
    
    float rainbowPos = sqrt(spiralPosX * spiralPosX + spiralPosY * spiralPosY) * 10.0 + time_f * 5.0;
    
    vec3 rainbowColor = getRainbowColor(sin(rainbowPos * time_t));
    
    FragColor = sin(vec4(mix(texColor.rgb, rainbowColor, 0.5), texColor.a) * time_t);
}
