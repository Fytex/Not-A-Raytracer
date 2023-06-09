#version 450

// in
in vec3 ld;
in vec2 tc;

// uniforms
uniform sampler2D texNormal;

// out
out vec4 colorOut;

void main(){
	vec3 n = texture(texNormal, tc).xyz;

    if (n == vec3(0,0,0))
        colorOut = vec4(1.0, 1.0, 1.0, 1.0);
	else {
		n = normalize(n * 2 - 1);
		
		vec4 diffuse = vec4(1.0, 0.0, 0.0, 1.0);
		//vec3 n = normalize(vNormal);
		vec3 ldn = normalize(ld);
		float intensity = max(dot(n, ldn), 0.0);
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
