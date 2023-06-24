#version 450

layout (triangles_adjacency) in;
layout (triangle_strip, max_vertices=12) out;


// uniforms
uniform float edgeOverhangLength;
uniform float edgeWidth; 

// out
out vec3 gNormal;
out vec3 gLightDir;
flat out float gDist;
out vec3 gSpine;




bool isFront(vec3 a, vec3 b, vec3 c){
    
    return ((a.x * b.y - b.x * a.y) +
            (b.x * c.y - c.x * b.y) +
            (c.x * a.y - a.x * c.y) > 0) && 
            a.z > 0 && b.z > 0 && c.z > 0; // Clip Space
}



void emitEdge(vec3 p0, vec3 p1){
    vec2 e = edgeOverhangLength * (p1.xy - p0.xy);
    vec2 v = normalize(p1.xy - p0.xy);
    vec2 n = vec2(-v.y, v.x) * edgeWidth; //edge Width vector

    /*
        C --------------- D  
        |                 |
        p0                p1
        |                 |
        A --------------- B
    */


    gSpine = (p0 + 1.0) * 0.5;
    // A
    gDist = -edgeWidth;
    gl_Position = vec4(p0.xy + n - e, p0.z, 1.0);
    EmitVertex();

    // C
    gDist = edgeWidth;
    gl_Position = vec4(p0.xy - n - e, p0.z, 1.0);
    EmitVertex();

    gSpine = (p1 + 1.0) * 0.5;
    // B
    gDist = -edgeWidth;
    gl_Position = vec4(p1.xy + n + e, p1.z, 1.0);
    EmitVertex();

    // D
    gDist = edgeWidth;
    gl_Position = vec4(p1.xy - n + e, p1.z, 1.0);
    EmitVertex();
    
    EndPrimitive();
}

void main(){
    vec3 p0 = gl_in[0].gl_Position.xyz / gl_in[0].gl_Position.w;
    vec3 p1 = gl_in[1].gl_Position.xyz / gl_in[1].gl_Position.w;
    vec3 p2 = gl_in[2].gl_Position.xyz / gl_in[2].gl_Position.w;
    vec3 p3 = gl_in[3].gl_Position.xyz / gl_in[3].gl_Position.w;
    vec3 p4 = gl_in[4].gl_Position.xyz / gl_in[4].gl_Position.w;
    vec3 p5 = gl_in[5].gl_Position.xyz / gl_in[5].gl_Position.w;

    if(isFront(p0, p2, p4)){
        if(!isFront(p0, p1, p2)){
            emitEdge(p0, p2);
        }

        if(!isFront(p2, p3, p4)){
            emitEdge(p2, p4);
        }

        if(!isFront(p4, p5, p0)){
            emitEdge(p4, p0);
        }
    }
}
