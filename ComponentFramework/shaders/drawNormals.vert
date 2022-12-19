#version 450
#extension GL_ARB_separate_shader_objects : enable


layout(location = 0) in vec4 vVertex;
layout(location = 1) in vec3 vNormal;

layout(std140, binding = 0) uniform UniformBufferObject {
    mat4 model;
    mat4 view;
    mat4 proj;
    vec4 lightPos[3];
} ubo;

layout(push_constant) uniform PushConstMatrix {
    mat4 modelMatrix;
    mat4 normalMatrix;
} pushConstMatrix;


layout (location = 0) out VertexStage {
    vec3 normal;
} vs_out;



void main() {


    gl_Position = ubo.view * pushConstMatrix.modelMatrix * vVertex;
    vs_out.normal = mat3(pushConstMatrix.normalMatrix) * vNormal;
}