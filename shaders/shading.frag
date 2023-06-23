#version 450

// in
in vec3 ld;
in vec2 tc, tc_paper;
in vec3 inc;

// uniforms
uniform sampler2D texNormal;
uniform float opacity;
uniform int shading_phases;
uniform vec4 diffuse;

// out
layout (location = 0) out vec4 texColor;
out vec4 colorOut;


void main(){
	vec3 n = texture(texNormal, tc).xyz;

    if (n == vec3(0,0,0))
        discard;
	else {
		n = normalize(n * 2 - 1);
		
		vec3 ldn = normalize(ld);
		float intensity = max(dot(n, ldn), 0.0);

		float interval = 1.0f / float(shading_phases);

		float intensity_cap = 1.0 - interval;

		while (intensity <= intensity_cap) {
			intensity_cap -= interval;
		}

		float level = clamp(0.0f, intensity_cap + interval, 1.0f); // Float-point prevention

		colorOut = diffuse * level;

		/*
		if (intensity > 0.75)
			colorOut = diffuse;
		else if (intensity > 0.5)
			colorOut = diffuse * 0.75;
		else if (intensity > 0.25)
			colorOut = diffuse * 0.5;
		else
			colorOut = diffuse * 0.25;

		*/
		
	}

	texColor = vec4(colorOut.xyz, opacity);
}
