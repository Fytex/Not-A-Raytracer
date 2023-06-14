#version 460

uniform samplerCube texPaper;
in vec4 pos;

out vec4 colorOut;

void main() {

    colorOut = texture(texPaper, normalize(vec3(pos)));
}