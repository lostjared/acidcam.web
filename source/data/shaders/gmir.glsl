#version 300 es
precision highp float;

uniform sampler2D textTexture;
uniform float time_f;
uniform vec2 iResolution;

out vec4 FragColor;

void main() {
    vec2 uv = gl_FragCoord.xy / iResolution;
    float scale = 2.0 + sin(time_f * 0.5) * 0.5;
    vec2 centeredUV = (uv - 0.5) * scale;
    centeredUV = abs(mod(centeredUV, 2.0) - 1.0);
    float angle = time_f * 0.2;
    mat2 rotation = mat2(cos(angle), -sin(angle), sin(angle), cos(angle));
    centeredUV = rotation * centeredUV;
    centeredUV += 0.5;
    vec4 texColor = texture(textTexture, centeredUV);
    vec3 gradientEffect = vec3(
        0.5 + 0.5 * sin(time_f + uv.x * 15.0),
        0.5 + 0.5 * cos(time_f + uv.y * 15.0),
        0.5 + 0.5 * sin(time_f + (uv.x + uv.y) * 15.0)
    );
    vec3 finalColor = mix(texColor.rgb, gradientEffect, 0.4);
    FragColor = vec4(finalColor, texColor.a);
}

