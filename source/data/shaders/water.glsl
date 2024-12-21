#version 300 es
precision highp float;


in vec2 TexCoord;
out vec4 FragColor;
uniform sampler2D textTexture;
uniform float time_f;

void main(void) {
    float speed = 5.0;
    float amplitude = 0.03;
    float wavelength = 10.0;
    float ripple = sin(TexCoord.x * wavelength + time_f * speed) * amplitude;
    ripple += sin(TexCoord.y * wavelength + time_f * speed) * amplitude;
    vec2 rippleTC = TexCoord + vec2(ripple, ripple);
    vec4 originalColor = texture(textTexture, TexCoord);
    vec4 rippleColor = texture(textTexture, rippleTC);
    FragColor = mix(originalColor, rippleColor, 0.5);
}
