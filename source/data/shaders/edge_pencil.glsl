#version 300 es
precision highp float;
out vec4 FragColor;
in vec2 TexCoord;

uniform sampler2D textTexture;
uniform float time_f;
uniform vec2 iResolution;

float random(vec2 st) {
    return fract(sin(dot(st.xy, vec2(12.9898, 78.233))) * 43758.5453123);
}

vec3 pencilSkeTexCoordh(sampler2D tex, vec2 uv) {
    float edgeThreshold = 0.3;
    vec2 offset = vec2(1.0 / iResolution.x, 1.0 / iResolution.y);

    float gx =
          -1.0 * texture(tex, uv + vec2(-offset.x, -offset.y)).r
        + -2.0 * texture(tex, uv + vec2(-offset.x, 0.0)).r
        + -1.0 * texture(tex, uv + vec2(-offset.x, offset.y)).r
        +  1.0 * texture(tex, uv + vec2(offset.x, -offset.y)).r
        +  2.0 * texture(tex, uv + vec2(offset.x, 0.0)).r
        +  1.0 * texture(tex, uv + vec2(offset.x, offset.y)).r;

    float gy =
          -1.0 * texture(tex, uv + vec2(-offset.x, -offset.y)).r
        + -2.0 * texture(tex, uv + vec2(0.0, -offset.y)).r
        + -1.0 * texture(tex, uv + vec2(offset.x, -offset.y)).r
        +  1.0 * texture(tex, uv + vec2(-offset.x, offset.y)).r
        +  2.0 * texture(tex, uv + vec2(0.0, offset.y)).r
        +  1.0 * texture(tex, uv + vec2(offset.x, offset.y)).r;

    float edge = sqrt(gx * gx + gy * gy);
    float noise = random(uv * time_f) * 0.1;
    float skeTexCoordh = (edge > edgeThreshold) ? 0.0 : 1.0;
    skeTexCoordh += noise;

    vec3 FragColor = vec3(skeTexCoordh);

    return FragColor;
}

void main(void) {
    vec3 skeTexCoordhColor = pencilSkeTexCoordh(textTexture, TexCoord);
    FragColor = vec4(skeTexCoordhColor, 1.0);
}
