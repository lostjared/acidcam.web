#version 300 es
precision highp float;

in vec2 TexCoord;
out vec4 FragColor;
in float alpha_r;
in float alpha_g;
in float alpha_b;
in float current_index;
in float timeval;
in float alpha;
in vec3 vpos;
in vec4 optx_val;
uniform vec4 optx;
in vec4 random_value;
uniform vec4 random_var;
uniform float alpha_value;

uniform mat4 mv_matrix;
uniform mat4 proj_matrix;
uniform sampler2D textTexture;
uniform float value_alpha_r, value_alpha_g, value_alpha_b;
uniform float index_value;
uniform float time_f;

uniform float restore_black;
in float restore_black_value;

void main(void)
{
    if(restore_black_value == 1.0 && texture(textTexture, TexCoord) == vec4(0, 0, 0, 1))
        discard;
    FragColor = texture(textTexture, TexCoord);
    for(int i = 0; i < 3; ++i) {
        FragColor[i] += tan(FragColor[i] * timeval);
    }
    ivec3 int_FragColor;
    for(int i = 0; i < 3; ++i) {
        int_FragColor[i] = int(255 * FragColor[i]);
        if(int_FragColor[i] > 255)
            int_FragColor[i] = int_FragColor[i]%255;
        FragColor[i] = float(int_FragColor[i])/255;
    }
}

