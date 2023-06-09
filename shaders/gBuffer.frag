#version 450

// in
in vec3 vNormal;

// out
layout (location = 0) out vec3 normal; // out vec3 normal

void main(){
    normal = (vNormal + 1.0) * 0.5;
}
