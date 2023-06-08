#version 330

layout(triangles_adjacency) in;
layout (triangle_strip, max_vertices=15) out;

// in
in vec3 vNormal[];      // Normal in camera coords.
in vec3 vLightDir[];

// uniforms
uniform float edgeOverdraw; // percentage to extend the quads beyond the edge
uniform float edgeWidth;    // width of the silhouette edge in clip coords.
uniform int normalThreshold;

// out
out vec3 gNormal;
out vec3 gLightDir;
flat out int gIsEdge;
flat out float gDist;




bool isFront(vec3 a, vec3 b, vec3 c){
    float threshold  = 0.0;
    
    return ((a.x * b.y - b.x * a.y) +
            (b.x * c.y - c.x * b.y) +
            (c.x * a.y - a.x * c.y) > 0) && 
            a.z > 0 && b.z > 0 && c.z > 0; // Clip Space
}



void emitEdge(vec3 p0, vec3 p1){
    vec2 v = normalize(p1.xy - p0.xy);
    vec2 n = vec2(-v.y, v.x) * edgeWidth; //edge Width vector
    
    gIsEdge = 1;

    /*
        C --------------- D  
        |                 |
        |    p1     p2    |
        |                 |
        A --------------- B
    */


    // A
    gDist = -edgeWidth;
    gl_Position = vec4(p0.xy + n, p0.z, 1.0);
    EmitVertex();

    // C
    gDist = +edgeWidth;
    gl_Position = vec4(p0.xy - n, p0.z, 1.0);
    EmitVertex();


    // B
    gDist = -edgeWidth;
    gl_Position = vec4(p1.xy + n, p1.z, 1.0);
    EmitVertex();

    // D
    gDist = +edgeWidth;
    gl_Position = vec4(p1.xy - n, p1.z, 1.0);
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

    // Output the original triangle
    gIsEdge = 0; // Triangle is not part of an edge.

    gNormal = vNormal[0];
    gLightDir = vLightDir[0];
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gNormal = vNormal[2];
    gLightDir = vLightDir[2];
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    gNormal = vNormal[4];
    gLightDir = vLightDir[4];
    gl_Position = gl_in[4].gl_Position;
    EmitVertex();

    EndPrimitive();
}