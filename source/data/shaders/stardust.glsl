#version 300 es
precision highp float;
out vec4 FragColor;
in vec2 TexCoord;

uniform sampler2D textTexture;
uniform float time_f;
uniform vec2 iResolution;

float rand(vec2 co) {
    return fract(sin(dot(co.xy, vec2(12.9898, 78.233))) * 43758.5453);
}

void main(void) {
    vec2 uv = TexCoord;
    vec4 texColor = texture(textTexture, uv);
    
    float starDensity = 0.01;
    float starSize = 0.03;
    vec2 gridPos = floor(uv * iResolution.xy * starDensity);
    vec2 starPos = fract(uv * iResolution.xy * starDensity);
    
    float starNoise = rand(gridPos);
    float starIntensity = smoothstep(starSize, starSize * 0.5, distance(starPos, vec2(starNoise, fract(sin(time_f + starNoise) * 0.5 + 0.5))));
    
    starIntensity *= 0.5 + 0.5 * sin(time_f * 10.0 + starNoise * 100.0);
    
    vec4 starColor = vec4(vec3(starIntensity), starIntensity);
    
    FragColor = mix(texColor, starColor, starColor.a);
}
