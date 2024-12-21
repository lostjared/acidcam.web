#version 300 es
precision highp float;

uniform sampler2D textTexture;
uniform vec2 iResolution;

out vec4 FragColor;

void main() {
    vec2 uv = gl_FragCoord.xy / iResolution;
    vec2 centeredUV = uv * 2.0 - 1.0;
    centeredUV = abs(centeredUV);
    vec2 mirroredUV = mod(centeredUV, 1.0);
    vec4 texColor = texture(textTexture, mirroredUV);
    FragColor = texColor;
}
