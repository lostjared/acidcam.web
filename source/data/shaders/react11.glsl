#version 300 es
precision highp float;


in vec2 TexCoord;
out vec4 FragColor;
uniform sampler2D textTexture;
uniform float time_f;

void main(void) {
    float amplitude = sin(time_f * 5.0) * 2.0;
    vec2 center = vec2(0.5, 0.5);
    vec2 direction = TexCoord - center;
    float distance = length(direction);
    float angle = atan(direction.y, direction.x);
    float spin = amplitude * distance;

    float newAngle1 = angle + spin;
    float newAngle2 = angle - spin;
    
    vec2 distorted_TexCoord1 = center + vec2(cos(newAngle1), sin(newAngle1)) * distance;
    vec2 distorted_TexCoord2 = center + vec2(cos(newAngle2), sin(newAngle2)) * distance;
    
    distorted_TexCoord1 = clamp(distorted_TexCoord1, vec2(0.0), vec2(1.0));
    distorted_TexCoord2 = clamp(distorted_TexCoord2, vec2(0.0), vec2(1.0));

    vec4 FragColor1 = texture(textTexture, distorted_TexCoord1);
    vec4 FragColor2 = texture(textTexture, distorted_TexCoord2);

    FragColor = mix(FragColor1, FragColor2, 0.5);
}
