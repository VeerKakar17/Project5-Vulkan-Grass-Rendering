#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(quads, equal_spacing, ccw) in;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation evaluation shader inputs and outputs

layout(location = 0) in vec4 in_v0[];
layout(location = 1) in vec4 in_v1[];
layout(location = 2) in vec4 in_v2[];
layout(location = 3) in vec4 in_up[];

void main() {
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;

	// TODO: Use u and v to parameterize along the grass blade and output positions for each vertex of the grass blade
    
    // Quad Shape
    float t = u;
    float width = in_v2[0].w;
    float height = in_v1[0].w;
    vec4 c0 = vec4(in_v0[0].x - width/2, in_v0[0].y+v*height, in_v0[0].z, 1);
    vec4 c1 = vec4(in_v0[0].x + width/2, in_v0[0].y+v*height, in_v0[0].z, 1);
    vec4 pos = (1-t)*c0 + t*c1;
    
    // project onto world space
    gl_Position = camera.proj * camera.view * pos;
}   
