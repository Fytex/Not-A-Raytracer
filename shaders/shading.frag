#version 450

// in
//in vec3 vNormal;
in vec3 vLightDir;
in vec2 texCoord;

// uniforms
uniform sampler2D texNormal;

// out
out vec4 colorOut;

void main(){
	vec3 n = texture(texNormal, texCoord).rgb;

    if (n == vec3(0,0,0))
        colorOut = vec4(1.0, 1.0, 1.0, 1.0);
	else {
	
		vec4 diffuse = vec4(1.0, 0.0, 0.0, 1.0);
		//vec3 n = normalize(vNormal);
		float intensity = max(dot(vLightDir,n),0.0);
		//float intensity = 1.0;
		
		if (intensity > 0.90)
			colorOut = diffuse;
		else if (intensity > 0.75)
			colorOut = 0.75 * diffuse;
		else if (intensity > 0.5)
			colorOut = 0.5 * diffuse;
		else
			colorOut = 0.35 * diffuse;
	}
}
