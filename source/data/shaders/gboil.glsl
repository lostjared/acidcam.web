#version 300 es
precision highp float;
out vec4 FragColor;
in vec2 TexCoord;

uniform sampler2D textTexture;
uniform float time_f;
uniform vec2 iResolution;

float pingPong(float x, float length) {
    float modVal = mod(x, length * 2.0);
    return modVal <= length ? modVal : length * 2.0 - modVal;
}

float rand(vec2 co) {
    return fract(sin(dot(co, vec2(12.9898, 78.233))) * 43758.5453);
}

void main(void) {
    vec2 uv = TexCoord;
    float frequency = 30.0;
    float amplitude = 0.05;
    float speed = 5.0;
    float t = time_f * speed;
    float noiseX = rand(uv * frequency + t);
    float noiseY = rand(uv * frequency - t);
    float distortionX = amplitude * pingPong(t + uv.y * frequency + noiseX, 1.0);
    float distortionY = amplitude * pingPong(t + uv.x * frequency + noiseY, 1.0);
    vec2 TexCoord_mod = uv + vec2(distortionX, distortionY);
    FragColor = texture(textTexture, TexCoord_mod);
}
