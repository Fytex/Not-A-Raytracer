#version 450

// in
in vec3 gNormal; // Normal in camera coords.
in vec3 gLightDir;
flat in int gIsEdge; // Whether or not we're drawing an edge
flat in float gDist;

// uniforms
uniform vec4 lineColor;
uniform float edgeWidth;

// out
out vec4 colorOut;


void main(){
	if (gIsEdge != 1)
		discard;

    float alpha = 1.0;
	float d = abs(gDist);
	float tipLength = 2.0 * fwidth(d);
	if (d > edgeWidth - tipLength)
	    alpha = 1.0 - (d - edgeWidth + tipLength) / tipLength;
 
	colorOut = vec4(lineColor.xyz, alpha);
}