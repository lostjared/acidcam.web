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

void main(void) {
    float time_t = pingPong(time_f, 10.0);
    vec2 center = vec2(0.5, 0.5);
    float dist = sqrt((TexCoord.x - center.x) * (TexCoord.x - center.x) + (TexCoord.y - center.y) * (TexCoord.y - center.y));
    
    dist = sin(dist * time_t);
    
    float angle = atan(TexCoord.y - center.y, TexCoord.x - center.x);
      
     float wave = sin(dist * 10.0 + angle * 5.0 - time_f * 5.0);
      
      vec2 offset = TexCoord + wave * 0.02 * vec2(cos(angle), sin(angle));
      vec4 texColor = texture(textTexture, offset);
      FragColor = texColor;
}
