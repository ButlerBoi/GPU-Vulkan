#version 450
#extension GL_ARB_separate_shader_objects : enable

layout (location = 0) in  vec4 vVertex;
layout (location = 1) in  vec4 vNormal;
layout (location = 2) in  vec2 texCoords;

layout(binding = 0) uniform UniformBufferObject {
    mat4 model;
    mat4 view;
    mat4 proj;
    vec4 lightPos[3];
} ubo;

layout (location = 0) out vec3 vertNormal;
layout (location = 1) out vec3 lightDir[3];
layout (location = 4) out vec3 eyeDir; 
layout (location = 5) out vec2 fragTexCoords;

void main() {
    fragTexCoords = texCoords;
	mat3 normalMatrix = mat3(transpose(inverse(ubo.model)));
    vertNormal = normalize(normalMatrix * vNormal.xyz);
    vec3 vertPos = vec3(ubo.view * ubo.model * vVertex);
    vec3 vertDir = normalize(vertPos);
    eyeDir = -vertDir;

    lightDir[0] = normalize(vec3(ubo.lightPos[0]) - vertPos);
    lightDir[1] = normalize(vec3(ubo.lightPos[1]) - vertPos);
    lightDir[2] = normalize(vec3(ubo.lightPos[2]) - vertPos);
    
    gl_Position = ubo.proj * ubo.view * ubo.model * vVertex;

}
