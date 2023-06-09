#version 450

// in
in vec3 gNormal; // Normal in camera coords.
in vec3 gLightDir;
flat in float gDist;
in vec3 gSpine;

// uniforms
uniform vec4 lineColor;
uniform float edgeWidth;
uniform sampler2D depthSampler;

// out
out vec4 colorOut;


void main(){
	vec2 tc = gSpine.xy;
	float depth = texture2D(depthSampler, tc).r;
	
	if (depth < gl_FragCoord.z)
	    discard;

    float alpha = 1.0;
	float d = abs(gDist);
	float tipLength = 2.0 * fwidth(d);
	if (d > edgeWidth - tipLength)
	    alpha = 1.0 - (d - edgeWidth + tipLength) / tipLength;
 
	colorOut = vec4(lineColor.xyz, alpha);
}