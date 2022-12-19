#version 450
#extension GL_ARB_separate_shader_objects : enable

layout (triangles) in; /// bringing in triangles

layout (line_strip, max_vertices = 2) out; 

layout(std140, binding = 0) uniform UniformBufferObject {
    mat4 model;
    mat4 view;
    mat4 proj;
    vec4 lightPos[3];
} ubo;


layout (location = 0) in VertexStage {
    vec3 normal;
} vs_in[];



void main() {
    float length  = 0.01;
    for(int index = 0; index < 3; index++){
        gl_Position = ubo.proj * gl_in[index].gl_Position;
        EmitVertex();

        gl_Position = ubo.proj * (gl_in[index].gl_Position + (vec4(vs_in[index].normal, 1.0) * length));
        EmitVertex();

        EndPrimitive();
    }
}