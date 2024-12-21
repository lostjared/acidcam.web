#version 300 es
precision highp float;


in vec2 TexCoord;
out vec4 FragColor;
uniform sampler2D textTexture;
uniform float time_f;
uniform vec2 iResolution;

void main(void) {
    vec2 uv = TexCoord * 2.0 - 1.0;
    float angle = atan(uv.y, uv.x);
    float radius = length(uv);
    
     float spinningSpeed = mix(5.0, 1.0, radius);
     float spinningAngle = angle + time_f * spinningSpeed;
    
    vec2 spinningUV = vec2(cos(spinningAngle), sin(spinningAngle)) * radius * 0.5 + 0.5;
    vec4 texColor = texture(textTexture, spinningUV);
    
    float centerGlow = exp(-radius * 10.0);
    float outerGlow = smoothstep(0.4, 0.5, radius) * 0.5 + 0.5;
    float glow = max(centerGlow, outerGlow);
    
    FragColor = texColor * vec4(glow, glow, glow, 1.0);
}
