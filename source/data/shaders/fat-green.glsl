#version 300 es
precision highp float;
out vec4 FragColor;
in vec2 TexCoord;

uniform sampler2D textTexture;
uniform float time_f;
uniform vec2 iResolution;

void main(void) {
    vec2 center = vec2(0.5, 0.5);
    vec2 dir = TexCoord - center;
    float streTexCoordh_factor = 1.0 + 0.5 * abs(sin(time_f * 3.14));
    vec2 new_TexCoord = center + dir;

    vec4 original_FragColor = texture(textTexture, TexCoord);
    vec4 streTexCoordhed_FragColor = texture(textTexture, center + vec2(dir.x / streTexCoordh_factor, dir.y));

    FragColor = vec4(original_FragColor.r, streTexCoordhed_FragColor.g, original_FragColor.b, original_FragColor.a);
}
