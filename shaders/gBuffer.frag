#version 450

// in
in vec3 n;

// out
layout (location = 0) out vec4 texNormal; // out vec4 texNormal

void main(){
    //texNormal = (n + 1.0) * 0.5;

    // normalize and pack normal and tangent
    texNormal = vec4(normalize(n) * 0.5 + 0.5, 1.0);
}
