#version 300 es
precision highp float;


in vec2 TexCoord;
out vec4 FragColor;
uniform sampler2D textTexture;
uniform float time_f;

void main(void) {
    float lightCycleSpeed = 2.0;
    float lightIntensity = 0.5 + 0.5 * sin(time_f * lightCycleSpeed);
    vec3 rainbow = vec3(
        sin(time_f + 0.0) * 0.5 + 0.5,
        sin(time_f + 2.094) * 0.5 + 0.5,
        sin(time_f + 4.188) * 0.5 + 0.5
    );

    vec4 rainbowLight = vec4(rainbow, 1.0) * lightIntensity;

    vec4 originalColor = texture(textTexture, TexCoord);

    FragColor = mix(originalColor, rainbowLight, 0.5 * lightIntensity);
}

