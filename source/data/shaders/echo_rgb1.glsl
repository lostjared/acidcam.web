#version 300 es
precision highp float;

out vec4 FragColor;
in vec2 TexCoord;

uniform sampler2D textTexture;
uniform float time_f;
uniform vec2 iResolution;

void main() {
    vec2 uv = TexCoord;
    float timeOffset = 0.05 * sin(time_f);
    vec3 redLayer = texture(textTexture, uv + vec2(timeOffset, 0.0)).rgb;
    vec3 greenLayer = texture(textTexture, uv).rgb;
    vec3 blueLayer = texture(textTexture, uv - vec2(timeOffset, 0.0)).rgb;
    bool strobe = mod(floor(time_f * 2.0), 2.0) > 0.5;
    vec3 rgbStrobe = vec3(
        strobe ? redLayer.r : blueLayer.r,
        greenLayer.g,
        strobe ? blueLayer.b : redLayer.b
    );
    vec4 echoEffect = texture(textTexture, uv + vec2(0.01 * sin(time_f), 0.01 * cos(time_f)));
    FragColor = mix(vec4(rgbStrobe, 1.0), echoEffect, 0.5);
}

