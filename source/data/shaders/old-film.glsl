#version 300 es
precision highp float;
out vec4 FragColor;
in vec2 TexCoord;

uniform sampler2D textTexture;
uniform float time_f;
uniform vec2 iResolution;

float rand(vec2 co){
    return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
}

void main(void) {
    vec2 uv = TexCoord;
    vec4 texColor = texture(textTexture, uv);

    float noise = rand(uv * time_f) * 0.1;
    float line = step(0.995, rand(vec2(uv.y * 100.0, time_f * 0.1)));

    texColor.rgb += noise;
    texColor.rgb = mix(texColor.rgb, vec3(0.0), line * 0.5);

    FragColor = texColor;
}
