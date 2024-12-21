#version 300 es
precision highp float;

uniform sampler2D textTexture;
uniform float time_f;
uniform vec2 iResolution;

out vec4 FragColor;

void main() {
    vec2 uv = gl_FragCoord.xy / iResolution;
    vec4 texColor = texture(textTexture, uv);
    float trail = sin(time_f * 2.0 + length(uv - 0.5)) * 0.5 + 0.5;
    vec3 ghostColor = texColor.rgb * vec3(0.8, 0.9, 1.0) * trail;
    vec3 shiftedColor = vec3(
        texture(textTexture, uv + vec2(0.01, 0.02) * sin(time_f)).r,
        texture(textTexture, uv + vec2(-0.02, 0.01) * cos(time_f)).g,
        texture(textTexture, uv + vec2(0.02, -0.01) * sin(time_f)).b
    );
    vec3 finalColor = mix(ghostColor, shiftedColor, 0.5);
    FragColor = vec4(finalColor, texColor.a);
}

