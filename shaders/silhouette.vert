#version 450


// in
in vec4 position;

// uniforms
uniform mat3 mNormal;
uniform mat4 mPVM;


void main(){
    gl_Position = mPVM * position;
}
