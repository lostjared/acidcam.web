#version 300 es
precision highp float;


in vec2 TexCoord;
out vec4 FragColor;
uniform sampler2D textTexture;
uniform float time_f;

void main(void) {
    float speed = 1.5;
    float amplitude = 0.02;
    float frequency = 6.0;
    float twist = 8.0;

    vec2 vortexCenter = vec2(-0.5, 1.5);
    vec2 adjustedTC = TexCoord - vortexCenter;
    float angle = atan(adjustedTC.y, adjustedTC.x);
    float radius = length(adjustedTC);
    float vortex = sin(twist * angle + radius * frequency - time_f * speed) * amplitude * radius;

    vec2 vortexDistortedTC = TexCoord + normalize(adjustedTC) * vortex;

    float whirlSpeed = 2.0;
    float whirlFrequency = 8.0;
    float whirlAmplitude = 0.03;
    float whirlScale = 0.5 + 0.5 * sin(time_f * whirlSpeed);
    vec2 whirlCenter = vec2(0.5, 0.5);
    vec2 whirlAdjustedTC = (TexCoord - whirlCenter) * whirlScale;
    float whirlAngle = atan(whirlAdjustedTC.y, whirlAdjustedTC.x);
    float whirlRadius = length(whirlAdjustedTC);
    float whirlDistortion = sin(whirlFrequency * whirlAngle + whirlRadius * whirlFrequency - time_f * whirlSpeed) * whirlAmplitude;

    vec2 whirlDistortedTC = TexCoord + normalize(whirlAdjustedTC) * whirlDistortion;

    vec4 originalColor = texture(textTexture, TexCoord);
    vec4 vortexColor = texture(textTexture, vortexDistortedTC);
    vec4 whirlColor = texture(textTexture, whirlDistortedTC);

    float lightEffect = sin(whirlRadius * 10.0 - time_f * 5.0) * 0.5 + 0.5;

    vec3 rainbow = vec3(
        sin(time_f + 0.0) * 0.5 + 0.5,
        sin(time_f + 2.094) * 0.5 + 0.5,
        sin(time_f + 4.188) * 0.5 + 0.5
    );
    vec4 rainbowLight = vec4(rainbow, 1.0) * lightEffect;

    FragColor = mix(originalColor, mix(vortexColor, whirlColor, 0.5), 0.6 + 0.4 * sin(time_f));
    FragColor += rainbowLight * (1.0 - lightEffect) * 0.3;
}

