#version 300 es
precision highp float;

uniform sampler2D textTexture;
uniform float time_f;
uniform vec2 iResolution;

out vec4 FragColor;

void main() {
    vec2 uv = gl_FragCoord.xy / iResolution;
    vec2 centeredUV = uv * 2.0 - 1.0;

    float angle1 = time_f * 0.5;
    float angle2 = -time_f * 0.5;

    if (centeredUV.x >= 0.0) {
        mat2 rotation1 = mat2(cos(angle1), -sin(angle1), sin(angle1), cos(angle1));
        centeredUV = rotation1 * centeredUV;
    } else {
        mat2 rotation2 = mat2(cos(angle2), -sin(angle2), sin(angle2), cos(angle2));
        centeredUV = rotation2 * centeredUV;
    }

    centeredUV = abs(centeredUV);
    vec2 mirroredUV = mod(centeredUV, 1.0);
    vec4 texColor = texture(textTexture, mirroredUV);
    FragColor = texColor;
}

