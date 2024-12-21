#version 300 es
precision highp float;
out vec4 FragColor;
in vec2 TexCoord;

uniform sampler2D textTexture;
uniform float time_f;
uniform vec2 iResolution;

void main(void) {
    vec2 uv = TexCoord - vec2(0.5);
    float radius = length(uv) * 2.0;

    float frequency = 10.0;
    float amplitude = 0.1;

    float pulsate = amplitude * sin(time_f * frequency);
float adjustedRadius = clamp(radius + pulsate, 0.0, 1.0);

    vec3 neonBlue = vec3(0.0, 1.0, 1.0);
    vec3 neonPink = vec3(1.0, 0.0, 0.5);
    vec3 gradientColor = mix(neonBlue, neonPink, adjustedRadius);\
    vec4 texColor = texture(textTexture, TexCoord);
    vec3 finalColor = texColor.rgb * gradientColor;
    FragColor = vec4(finalColor, texColor.a);
}
