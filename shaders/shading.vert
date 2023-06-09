#version 450

// in
in vec4 position;
in vec2 texCoord0;

// uniforms
uniform mat4 mView;
uniform vec4 lightDir;


// out
out vec2 tc;
out vec3 ld;

void main(){
    ld = normalize(vec3(mView * -lightDir));
    tc = texCoord0;

    gl_Position = position;
}