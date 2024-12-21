#version 300 es
precision highp float;
out vec4 FragColor;
in vec2 TexCoord;

uniform sampler2D textTexture;
uniform float time_f;
uniform vec2 iResolution;

float pingPong(float x, float length) {
    float modVal = mod(x, length * 2.0);
    return modVal <= length ? modVal : length * 2.0 - modVal;
}

vec3 hsv2rgb(vec3 c) {
    vec4 K = vec4(1.0, 2.0/3.0, 1.0/3.0, 3.0);
    vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
    return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}

void main(void) {
    vec2 uv = TexCoord * iResolution.xy / iResolution.y;
    float pattern = sin(uv.x * 10.0) * cos(uv.y * 10.0);

    pattern = (pattern + 1.0) * 0.5;

    float reveal = 1.0;

    float cracks = step(pattern, reveal);

    float hue = pattern * 6.0;
    
    

    vec3 FragColorRGB = hsv2rgb(vec3(sin(hue * time_f), 1.0, 1.0));

    float time_t = pingPong(time_f, 8.0) + 2.0;
    FragColor = vec4(FragColorRGB * cracks * time_t, 1.0);
    FragColor = mix(sin(FragColor * time_t),FragColor + tan(texture(textTexture,TexCoord) * time_t), 0.5);
    
}
