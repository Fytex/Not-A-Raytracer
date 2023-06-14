#version 450

// in
in vec4 position;
in vec3 normal;

// uni
uniform mat4 mPVM;
uniform mat3 mNormal;

// out
out vec3 n;
out vec4 p;

void main(){
    n = normalize(mNormal * normal);
    gl_Position = mPVM * position;
}