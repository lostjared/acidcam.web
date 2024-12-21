#version 300 es
precision highp float;

uniform sampler2D textTexture;
uniform float time_f;
uniform vec2 iResolution;

out vec4 FragColor;

void main() {
    vec2 uv = gl_FragCoord.xy / iResolution;
    vec4 texColor = texture(textTexture, uv);
    
    vec2 trailOffset1 = vec2(0.02, 0.03) * sin(time_f + length(uv - 0.5) * 10.0);
    vec2 trailOffset2 = vec2(-0.03, 0.02) * cos(time_f * 1.5 + length(uv - 0.5) * 15.0);
    vec2 trailOffset3 = vec2(0.01, -0.01) * sin(time_f * 3.0);
    
    vec3 trail1 = texture(textTexture, uv + trailOffset1).rgb * 0.7;
    vec3 trail2 = texture(textTexture, uv + trailOffset2).rgb * 0.5;
    vec3 trail3 = texture(textTexture, uv + trailOffset3).rgb * 0.3;

    vec3 intenseTrail = trail1 + trail2 + trail3;
    vec3 vibrantShift = vec3(
        0.5 + 0.5 * sin(time_f + uv.x * 20.0),
        0.5 + 0.5 * cos(time_f + uv.y * 20.0),
        0.5 + 0.5 * sin(time_f + uv.x * uv.y * 20.0)
    );

    vec3 finalColor = mix(intenseTrail, vibrantShift, 0.6);
    FragColor = vec4(finalColor, texColor.a);
}

