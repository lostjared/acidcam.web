#version 300 es
precision highp float;


in vec2 TexCoord;
out vec4 FragColor;
uniform sampler2D textTexture;

uniform float time_f;

void main(void) {
    float rippleSpeed = 5.0;
    float rippleAmplitude = 0.03;
    float rippleWavelength = 10.0;
    float twistStrength = 1.0;
    float radius = length(TexCoord - vec2(0.5, 0.5));
    float ripple = sin(TexCoord.x * rippleWavelength + time_f * rippleSpeed) * rippleAmplitude;
    ripple += sin(TexCoord.y * rippleWavelength + time_f * rippleSpeed) * rippleAmplitude;
    vec2 rippleTC = TexCoord + vec2(ripple, ripple);
    
    float angle = twistStrength * (radius - 1.0) + time_f;
    float cosA = cos(angle);
    float sinA = sin(angle);
    mat2 rotationMatrix = mat2(cosA, -sinA, sinA, cosA);
    vec2 twistedTC = (rotationMatrix * (TexCoord - vec2(0.5, 0.5))) + vec2(0.5, 0.5);
    
    vec4 originalColor = texture(textTexture, TexCoord);
    vec4 twistedRippleColor = texture(textTexture, mix(rippleTC, twistedTC, 0.5));
    FragColor = mix(originalColor, twistedRippleColor, 0.5);
}
