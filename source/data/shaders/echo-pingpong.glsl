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

float pingPong(float x, float length) {
    float modVal = mod(x, length * 2.0);
    return modVal <= length ? modVal : length * 2.0 - modVal;
}

void main(void)
{
    float time_x = pingPong(time_f, 2.0) + 1.0;
    float time_y = pingPong(time_f, 4.0) + 1.0;
    float time_z = pingPong(time_f, 8.0) + 1.0;
    FragColor = texture(textTexture, TexCoord);
    vec4 FragColor2 = texture(textTexture, TexCoord /time_x);
    vec4 FragColor3 = texture(textTexture, TexCoord/time_y);
    vec4 FragColor4 = texture(textTexture, TexCoord/time_z);
    FragColor = (FragColor * 0.4) + (FragColor2 * 0.4) + (FragColor3 * 0.4) + (FragColor4 * 0.4) ;
}



