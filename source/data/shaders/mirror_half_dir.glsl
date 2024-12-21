#version 300 es
precision highp float;


in vec2 TexCoord;
out vec4 FragColor;
uniform sampler2D textTexture;
in vec2 iResolution_;
uniform float time_f;

void main(void)
{
    vec2 uv = TexCoord;
    float duration = 2.0;
    float totalDuration = 2.0 * duration;
    float currentTime = mod(time_f, totalDuration);

    if (currentTime < duration) {
        if (uv.x > 0.5) {
            uv.x = 1.0 - uv.x;
        }
    } else {
        if (uv.x < 0.5) {
            uv.x = 1.0 - uv.x;
        }
    }
    
    FragColor = texture(textTexture, uv);
}
