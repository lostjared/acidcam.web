#version 300 es
precision highp float;
out vec4 FragColor;
in vec2 TexCoord;

uniform sampler2D textTexture;
uniform float time_f;
uniform vec2 iResolution;

void main(void) {
    vec4 texColor = texture(textTexture, TexCoord);
    float gray = dot(texColor.rgb, vec3(0.299, 0.587, 0.114));
    FragColor = vec4(vec3(gray), texColor.a);
}
