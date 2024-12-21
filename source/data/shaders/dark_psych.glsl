#version 300 es
precision highp float;

in vec2 TexCoord;
out vec4 FragColor;
uniform float time_f;
uniform vec2 iResolution;
uniform sampler2D textTexture;

vec3 rainbow(float t) {
    t = fract(t);
    float r = abs(t * 6.0 - 3.0) - 1.0;
    float g = 2.0 - abs(t * 6.0 - 2.0);
    float b = 2.0 - abs(t * 6.0 - 4.0);
    return clamp(vec3(r, g, b), 0.0, 1.0);
}

void main(void) {
    vec2 uv = (TexCoord - 0.5) * 2.0;
    uv.x *= iResolution.x / iResolution.y;
    float time = time_f * 0.5;
    float sine1 = sin(uv.x * 10.0 + time) * cos(uv.y * 10.0 + time);
    float sine2 = sin(uv.y * 15.0 - time) * cos(uv.x * 15.0 - time);
    float sine3 = sin(sqrt(uv.x * uv.x + uv.y * uv.y) * 20.0 + time);
    float pattern = sine1 + sine2 + sine3;
    float FragColorIntensity = pattern * 0.5 + 0.5;
    vec3 psychedelicColor = vec3(
        sin(FragColorIntensity * 6.28318 + 0.0) * 0.5 + 0.5,
        sin(FragColorIntensity * 6.28318 + 2.09439) * 0.5 + 0.5,
        sin(FragColorIntensity * 6.28318 + 4.18879) * 0.5 + 0.5
    );
    vec3 baseColor = psychedelicColor;
    uv = TexCoord * 2.0 - 1.0;
    float t = mod(time_f, 20);
    uv.y *= iResolution.y / iResolution.x;
    float angle = atan(uv.y, uv.x) + t * 20.0;
    vec3 rainbowColor = rainbow(angle / (2.0 * 3.14159));
    vec4 originalColor = texture(textTexture, TexCoord);
    vec3 blendedColor = mix(originalColor.rgb, rainbowColor, 0.5);
    FragColor = vec4(sin(blendedColor * t), originalColor.a);
    FragColor = mix(FragColor, vec4(baseColor, 1.0), 0.5);
}
