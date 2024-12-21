#version 300 es
precision highp float;


in vec2 TexCoord;
out vec4 FragColor;
uniform sampler2D textTexture;
uniform float time_f;

void main(void) {
    vec4 texColor = texture(textTexture, TexCoord);
    float sparkle = abs(sin(time_f * 10.0 + TexCoord.x * 100.0) * cos(time_f * 15.0 + TexCoord.y * 100.0));
    vec3 magicalColor = vec3(sin(time_f * 2.0) * 0.5 + 0.5, cos(time_f * 3.0) * 0.5 + 0.5, sin(time_f * 4.0) * 0.5 + 0.5);
    FragColor = texColor + vec4(magicalColor * sparkle, 1.0);
}
