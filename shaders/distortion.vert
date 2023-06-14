#version 450

// in
in vec4 position;
in vec2 texCoord0;

// uniforms
uniform mat4 mView, mModel;
uniform vec4 lightDir;


// out
out vec2 tc;
out vec3 ld;
out vec3 pw;

void main(){
    ld = normalize(vec3(mView * -lightDir));
    tc = texCoord0;

    pw = vec3(mModel * position);

    gl_Position = position;
}