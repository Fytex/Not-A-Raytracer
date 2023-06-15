#version 450

// in
in vec4 position;
in vec2 texCoord0;



// out
out vec2 tc;


void main(){
    tc = texCoord0;

    gl_Position = position;
}