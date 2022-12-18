#version 450
#extension  GL_ARB_separate_shader_objects : enable

layout(binding = 1) uniform GlobalLightingUBO{
	vec4 position[3];
	vec4 diffuse[3];
} glighting;

layout (location = 0) in vec3 vertNormal;
layout (location = 1) in vec3 lightDir[3];
layout (location = 4) in vec3 eyeDir; 
layout (location = 5) in vec2 fragTexCoords;

layout (location = 0) out vec4 fragColor;
layout(binding = 2) uniform sampler2D texSampler;


void main() { 
		
	vec4 kt = texture(texSampler, fragTexCoords);

	float diff[3];
	vec3 reflection[3];
	float spec[3];
	
	for (int i = 0; i < 3; i++) {
		
		const vec4 ka = 0.1 * glighting.diffuse[i];

		diff[i] = max(dot(vertNormal, lightDir[i]), 0.0);
		reflection[i] = normalize(reflect(-lightDir[i], vertNormal));
		spec[i] = max(dot(eyeDir, reflection[i]), 0.0);
		
		if(diff[i] > 0.0){
			spec[i] = pow(spec[i],14.0);
			}		
		

	fragColor = ka + (diff[0] * kt) + (diff[1] * kt) + (diff[2] * kt) + (spec[0] * glighting.diffuse[0]) + (spec[1] * glighting.diffuse[1]) + (spec[2] * glighting.diffuse[2]);
	} 
}

