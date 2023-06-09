#version 450

// in
in vec4 position;
in vec2 texCoord0;
//in vec3 normal;

// uniforms
//uniform mat3 mNormal;
uniform mat4 mView;
//uniform mat4 mPVM;
uniform vec4 lightDir; // global space


// out
out vec2 tc;
//out vec3 vNormal;
out vec3 vLightDir;

void main(){
    //vNormal = normalize(mNormal * normal);
    vLightDir = normalize(vec3(mView * -lightDir));
    tc = texCoord0;

    gl_Position = position;
}