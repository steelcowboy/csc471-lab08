#version 330 core
in vec2 texCoord;
out vec4 color;

uniform sampler2D texBuf;

uniform float weight[5] = float[]( 0.2270270270, 0.1945945946, 0.1216216216, 
											0.0540540541, 0.0162162162 );
void main()
{             
    vec2 tex_offset = 1.0 / textureSize(texBuf, 0); // gets size of single texel
    vec3 result = texture(texBuf, texCoord).rgb * weight[0]; // current fragment's contribution

    for(int i = 1; i < 5; ++i)
    {
        result += texture(texBuf, texCoord + vec2(0.0, tex_offset.y * i)).rgb * weight[i];
        result += texture(texBuf, texCoord - vec2(0.0, tex_offset.y * i)).rgb * weight[i];
    }

    color = vec4(result, 1.0);
}
