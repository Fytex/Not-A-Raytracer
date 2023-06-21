#version 450

// in
in vec2 tc;

// uniforms
uniform sampler2D texColor;
uniform sampler2D texNormal;
uniform float blur;

// out
layout (location = 0) out vec4 texBufferColor;
layout (location = 1) out vec2 texBackGroundBit;
out vec4 colorOut;



void main(){
    vec3 n = texture(texNormal, tc).xyz;

    if (n == vec3(0,0,0))
        discard;
    else {
        ivec2 textureSize2d = textureSize(texColor, 0);
        int W = textureSize2d.s;
        int H = textureSize2d.t;

        int Kw = int(W * (1 - blur));
        int Kh = int(H * (1 - blur));
        vec2 ntc = vec2((1.0f/float(Kw)) * floor(float(Kw) * tc.s), (1.0f/float(Kh)) * floor(float(Kh) * tc.t));

        int Nw = W / Kw;
        int Nh = W / Kh;
        
        vec3 color = vec3(0);
        for (int i = 0; i < Nw; i++) {
            for (int j = 0; j < Nh; j++) {
                color += texture(texColor, vec2(ntc.s + (float(i)/float(W)), ntc.t + (float(j)/float(H)))).xyz;
            }
        }

        colorOut = vec4(color / float(Nw * Nh), 1);
        texBufferColor = colorOut;
        texBackGroundBit.r = 1;
    }
}

