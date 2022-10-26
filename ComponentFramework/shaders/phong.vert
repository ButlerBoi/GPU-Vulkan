#version 450
#extension GL_ARB_separate_shader_objects : enable

layout (location = 0) in  vec4 vVertex;
layout (location = 1) in  vec4 vNormal;

layout(binding = 0) uniform UniformBufferObject {
    mat4 model;
    mat4 view;
    mat4 proj;
    vec4 lightPos;
} ubo;

layout (location = 0) out vec3 vertNormal;
layout (location = 1) out vec3 lightDir;
layout (location = 2) out vec3 eyeDir; 

void main() {
	mat3 normalMatrix = mat3(transpose(inverse(ubo.model)));
    vertNormal = normalize(normalMatrix * vNormal.xyz);
    vec3 vertPos = vec3(ubo.view * ubo.model * vVertex);
    vec3 vertDir = normalize(vertPos);
    eyeDir = -vertDir;
    lightDir = normalize(ubo.lightPos - vertPos);

    gl_Position = ubo.proj * ubo.view * ubo.model * vVertex;

}
