#version 300 es
precision highp float;

in vec2 TexCoord;
out vec4 FragColor;
uniform sampler2D textTexture;
uniform float time_f;
uniform vec2 iResolution;

void main() {
    vec2 uv = TexCoord;

    float trailStrength = 0.05;
    float strobeSpeed = sin(time_f * 10.0);

    vec2 trailOffsetR = vec2(trailStrength * strobeSpeed, 0.0);
    vec2 trailOffsetG = vec2(-trailStrength * strobeSpeed, trailStrength * strobeSpeed);
    vec2 trailOffsetB = vec2(0.0, -trailStrength * strobeSpeed);

    vec3 rgbTrail = vec3(
        texture(textTexture, uv + trailOffsetR).r,
        texture(textTexture, uv + trailOffsetG).g,
        texture(textTexture, uv + trailOffsetB).b
    );

    float strobe = 0.5 + 0.5 * sin(time_f * 20.0);
    vec3 baseColor = texture(textTexture, uv).rgb;

    FragColor = vec4(mix(baseColor, rgbTrail, strobe), 1.0);
}

