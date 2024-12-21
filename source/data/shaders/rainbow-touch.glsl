#version 300 es
precision highp float;
out vec4 FragColor;
in vec2 TexCoord;

uniform sampler2D textTexture;
uniform float time_f;
uniform vec2 iResolution;

vec3 rainbow(vec2 uv, float offset) {
    float rainbowFactor = sin(offset + uv.x * 10.0) * 0.5 + 0.5;
    return vec3(
        sin(rainbowFactor * 3.0 + 0.0),
        sin(rainbowFactor * 3.0 + 2.0),
        sin(rainbowFactor * 3.0 + 4.0)
    );
}

void main(void) {
    vec4 texColor = texture(textTexture, TexCoord);
    
    float phase = mod(time_f, 6.0);
    float t = fract(time_f / 2.0);
    vec2 uv = TexCoord;
    vec3 rainbowColor;

    float angle = mix(0.0, 6.28318, t);


    uv += vec2(sin(angle + length(uv) * 10.0), cos(angle + length(uv) * 10.0)) * 0.1;
    
    
    rainbowColor = rainbow(uv, time_f);
    
    FragColor = vec4(texColor.rgb + rainbowColor * 0.5, texColor.a);
}
