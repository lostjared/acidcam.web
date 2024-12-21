#version 300 es
precision highp float;
in vec2 TexCoord;
out vec4 FragColor;
uniform sampler2D textTexture;
uniform float time_f;
uniform vec2 iResolution;

void main(void) {
    vec2 uv = TexCoord * 2.0 - 1.0;
    float angle = atan(uv.y, uv.x);
    float radius = length(uv);

    int numSpokes = 32;
    float spokeWidth = 0.05;
    float spokeAngle = radians(360.0 / float(numSpokes));
    float spokePattern = mod(angle + time_f * 2.0, spokeAngle) - spokeAngle / 2.0;
    float spoke = smoothstep(-spokeWidth, 0.0, spokePattern) - smoothstep(0.0, spokeWidth, spokePattern);
    float centerGlow = exp(-radius * 20.0);
    vec4 texColor = texture(textTexture, uv * 0.5 + 0.5);
    float glow = max(spoke, centerGlow);
    
    FragColor = texColor * vec4(glow, glow, glow, 1.0);
}
