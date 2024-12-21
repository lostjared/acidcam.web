#version 300 es
precision highp float;


in vec2 TexCoord;
out vec4 FragColor;
uniform sampler2D textTexture;
uniform float time_f;

void main(void) {
    float frequency = 10.0;
    float amplitude = 0.02;
    float speed = 2.0;
    float columnWidth = 1.0 / 4.0;

    vec2 snake;
    if (TexCoord.x < columnWidth) {
        snake = TexCoord + vec2(amplitude * sin(TexCoord.y * frequency + time_f * speed), amplitude * sin(TexCoord.x * frequency + time_f * speed));
    } else if (TexCoord.x < 2.0 * columnWidth) {
        snake = TexCoord + vec2(amplitude * sin(TexCoord.y * frequency + time_f * speed), amplitude * sin((TexCoord.x - columnWidth) * frequency + time_f * speed));
    } else if (TexCoord.x < 3.0 * columnWidth) {
        snake = TexCoord + vec2(amplitude * sin(TexCoord.y * frequency + time_f * speed), amplitude * sin((TexCoord.x - 2.0 * columnWidth) * frequency + time_f * speed));
    } else {
        snake = TexCoord + vec2(amplitude * sin(TexCoord.y * frequency + time_f * speed), amplitude * sin((TexCoord.x - 3.0 * columnWidth) * frequency + time_f * speed));
    }
    
    vec4 texColor = texture(textTexture, snake);
    FragColor = texColor;
}
