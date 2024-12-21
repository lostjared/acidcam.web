#version 300 es
precision highp float;

out vec4 FragColor;
in vec2 TexCoord;

uniform sampler2D textTexture;
uniform float time_f; // Ensure this uniform is properly passed to the shader
uniform vec2 iResolution;
uniform float alpha;

float pingPong(float x, float length) {
    float modVal = mod(x, length * 2.0);
    return modVal <= length ? modVal : length * 2.0 - modVal;
}

float hash(vec2 p) {
    return fract(sin(dot(p, vec2(127.1, 311.7))) * 43758.5453123);
}

float noise(vec2 p) {
    vec2 i = floor(p);
    vec2 f = fract(p);
    vec2 u = f * f * (3.0 - 2.0 * f);
    return mix(mix(hash(i + vec2(0.0, 0.0)), hash(i + vec2(1.0, 0.0)), u.x),
               mix(hash(i + vec2(0.0, 1.0)), hash(i + vec2(1.0, 1.0)), u.x), u.y);
}

void main(void) {
    vec2 uv = (TexCoord * iResolution - 0.5 * iResolution) / iResolution.y;

    float t = time_f * 0.7;
    float beat = abs(sin(time_f * 3.14159)) * 0.2 + 0.8; // Drum beat effect from time_f
    
    float radius = length(uv);
    float angle = atan(uv.y, uv.x);
    angle += t * 0.5;
    float radMod = pingPong(radius + t * 0.3, 0.5);
    float wave = sin(radius * 10.0 - t * 6.0) * 0.5 + 0.5;

    float distortion = sin((radius + t * 0.5) * 8.0) * beat * 0.1;
    uv += vec2(cos(angle), sin(angle)) * distortion;
    
    vec3 texColor = texture(textTexture, TexCoord + distortion).rgb;
    
    float noiseEffect = noise(uv * 10.0 + t * 0.5) * 0.2;
    float r = sin(angle * 3.0 + radMod * 8.0 + wave * 6.2831 + noiseEffect);
    float g = sin(angle * 4.0 - radMod * 6.0 + wave * 4.1230 + noiseEffect);
    float b = sin(angle * 5.0 + radMod * 10.0 - wave * 3.4560 - noiseEffect);
    vec3 col = vec3(r, g, b) * 0.5 + 0.5;
    
    col = mix(col, texColor, 0.6);
    
    vec3 lightDir = normalize(vec3(0.5, 0.5, 1.0));
    vec3 norm = normalize(vec3(uv, sqrt(1.0 - dot(uv, uv))));
    float light = dot(norm, lightDir) * 0.5 + 0.5;
    col *= light * 1.2;
    
    col *= beat;
    FragColor = vec4(col, alpha);
}