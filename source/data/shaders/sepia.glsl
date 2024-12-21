#version 300 es
precision highp float;
out vec4 FragColor;
in vec2 TexCoord;

uniform sampler2D textTexture;
uniform float time_f;
uniform vec2 iResolution;

void main(void) {
    vec4 texColor = texture(textTexture, TexCoord);
    float r = texColor.r;
    float g = texColor.g;
    float b = texColor.b;
    FragColor = vec4(
        dot(vec3(r, g, b), vec3(0.393, 0.769, 0.189)),
        dot(vec3(r, g, b), vec3(0.349, 0.686, 0.168)),
        dot(vec3(r, g, b), vec3(0.272, 0.534, 0.131)),
        texColor.a
    );
}
