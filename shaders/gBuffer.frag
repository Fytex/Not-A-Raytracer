#version 450

// in
in vec3 n;

// out
layout (location = 0) out vec3 texNormal;


out vec3 colorOut;

void main(){
    //texNormal = (n + 1.0) * 0.5;

    // normalize and pack normal and tangent
    texNormal = normalize(n) * 0.5 + 0.5;
    colorOut = texNormal; // update depth buffer
}
