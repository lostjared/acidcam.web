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
    float rowHeight = 1.0 / 4.0;

    vec2 snake;
    if (TexCoord.y < rowHeight) {
        snake = TexCoord + vec2(amplitude * sin(TexCoord.y * frequency + time_f * speed), amplitude * sin(TexCoord.x * frequency + time_f * speed));
    } else if (TexCoord.y < 2.0 * rowHeight) {
        snake = TexCoord + vec2(amplitude * sin((TexCoord.y - rowHeight) * frequency + time_f * speed), amplitude * sin(TexCoord.x * frequency + time_f * speed));
    } else if (TexCoord.y < 3.0 * rowHeight) {
        snake = TexCoord + vec2(amplitude * sin((TexCoord.y - 2.0 * rowHeight) * frequency + time_f * speed), amplitude * sin(TexCoord.x * frequency + time_f * speed));
    } else {
        snake = TexCoord + vec2(amplitude * sin((TexCoord.y - 3.0 * rowHeight) * frequency + time_f * speed), amplitude * sin(TexCoord.x * frequency + time_f * speed));
    }
    
    vec4 texColor = texture(textTexture, snake);
    FragColor = texColor;
}
