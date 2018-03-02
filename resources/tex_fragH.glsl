#version 330 core

// texCoords
in vec2 texCoord;
// FragColor
out vec4 color;

// Image
uniform sampler2D texBuf;

//uniform float offset[5] = float[]( 0.0, 1.0, 2.0, 3.0, 4.0 );
uniform float weight[5] = float[]( 0.2270270270, 0.1945945946, 0.1216216216, 
											0.0540540541, 0.0162162162 );

//void main(){
   //color = vec4(texture( texBuf, texCoord ).rgb, 1)*weight[0];

	//for (int i=1; i <5; i ++) {
			//color += vec4(texture( texBuf, texCoord + vec2(offset[i], 0.0)/512.0 ).rgb, 1)*weight[i];
			//color += vec4(texture( texBuf, texCoord - vec2(offset[i], 0.0)/512.0 ).rgb, 1)*weight[i];
	//}
//}

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
