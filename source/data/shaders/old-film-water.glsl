#version 300 es
precision highp float;
out vec4 FragColor;
in vec2 TexCoord;

uniform sampler2D textTexture;
uniform float time_f;
uniform vec2 iResolution;

float rand(vec2 co) {
    return fract(sin(dot(co.xy, vec2(12.9898, 78.233))) * 43758.5453);
}

void main(void) {
    vec2 normCoord = TexCoord;

    float timeAdjustedFrequency = 10.0 + sin(time_f) * 5.0;
    float timeAdjustedAmplitude = 0.01 + (sin(time_f * 0.5) * 0.5 + 0.5) * 0.05;
    float zigzagFactor = abs(fract(normCoord.y * timeAdjustedFrequency) - 0.5) * 2.0;
    float xDisplacement = zigzagFactor * timeAdjustedAmplitude;
    vec2 displacedCoord = vec2(normCoord.x + xDisplacement, normCoord.y);
    displacedCoord = clamp(displacedCoord, 0.0, 1.0);

    vec4 texColor = texture(textTexture, displacedCoord);

    float noise = rand(displacedCoord * time_f) * 0.1;
    float line = step(0.995, rand(vec2(displacedCoord.y * 100.0, time_f * 0.1)));

    texColor.rgb += noise;
    texColor.rgb = mix(texColor.rgb, vec3(0.0), line * 0.5);

    FragColor = texColor;
}
