#version 450
#extension  GL_ARB_separate_shader_objects : enable

layout (location = 0) in vec3 vertNormal;
layout (location = 1) in vec3 lightDir[3];
layout (location = 4) in vec3 eyeDir; 
layout (location = 5) in vec2 fragTexCoords;

layout (location = 0) out vec4 fragColor;
layout(binding = 1) uniform sampler2D texSampler;


void main() { 



	const vec4 ks[3] = {vec4(1.0, 0.0, 0.0, 0.0),vec4(0.0, 1.0, 0.0, 0.0),vec4(0.0, 0.0, 1.0, 0.0)};
	const vec4 kd[3] = {vec4(0.1, 0.0, 0.0, 0.0),vec4(0.0, 0.1, 0.0, 0.0),vec4(0.0, 0.0, 0.1, 0.0)}; /// const means it cannot be changed just like C++
	
	vec4 kt = texture(texSampler, fragTexCoords);

	float diff[3];
	float spec[3];
	
	for (int i = 0; i < 3; i++) {
		
		const vec4 ka = 0.1 * kd[i];

		diff[i] = max(dot(vertNormal, lightDir[i]), 0.0);
		vec3 reflection = normalize(reflect(-lightDir[i], vertNormal));
		spec[i] = max(dot(eyeDir, reflection), 0.0);
		
		if(diff[i] > 0.0){
			spec[i] = pow(spec[i],14.0);
			}		
		

	fragColor = ka + (diff[0] * kt) + (diff[1] * kt) + (diff[2] * kt) + (spec[0] * ks[0]) + (spec[1] * ks[1]) + (spec[2] * ks[2]);
	} 
}

