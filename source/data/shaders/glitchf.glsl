#version 300 es
precision highp float;

in vec2 TexCoord;
out vec4 FragColor;
uniform sampler2D textTexture;
uniform float time_f;
uniform vec2 iResolution;

float random(vec2 co) {
    return fract(sin(dot(co.xy, vec2(12.9898, 78.233))) * 43758.5453);
}

void main() {
    vec2 uv = TexCoord;

    float gliTexCoordhStrength = 0.05 + 0.03 * sin(time_f * 3.0);
    float gliTexCoordhLine = step(0.5 + 0.1 * sin(time_f * 10.0), fract(uv.y * 10.0 + time_f * 5.0));
    float displacement = gliTexCoordhStrength * (random(uv + time_f) - 0.5);

    vec2 distortedUV = uv;
    distortedUV.x += displacement * gliTexCoordhLine;

    vec4 texColor = texture(textTexture, distortedUV);

    vec2 offset = vec2(0.01 * sin(time_f * 15.0), 0.01 * cos(time_f * 10.0));
    vec3 gliTexCoordhRGB = vec3(
        texture(textTexture, distortedUV + vec2(offset.x, 0.0)).r,
        texture(textTexture, distortedUV + vec2(-offset.x, offset.y)).g,
        texture(textTexture, distortedUV + vec2(0.0, -offset.y)).b
    );

    float strobe = step(0.5, fract(time_f * 10.0)) * 0.2;

    FragColor = vec4(mix(texColor.rgb, gliTexCoordhRGB, gliTexCoordhLine + strobe), texColor.a);
}

