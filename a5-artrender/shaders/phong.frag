#version 330

in vec3 position_in_eye_space;
in vec3 normal_in_eye_space;

out vec4 color;

uniform vec3 light_in_eye_space;
uniform vec4 Ia, Id, Is;

uniform vec4 ka, kd, ks;
uniform float s;


void main() {

    // unit vector from the vertex to the light
    vec3 l = normalize(light_in_eye_space - position_in_eye_space);
    
    // unit vector from the vertex to the eye point, which is at 0,0,0 in "eye space"
    vec3 e = normalize(vec3(0,0,0) - position_in_eye_space);

    // halfway vector
    vec3 h = normalize(l + e);


	// calculating lighting output the color for this vertex
    // ... 
    vec4 ambient = ka * Ia;
    vec4 diffuse = kd * Id * max(dot(normalize(normal_in_eye_space),l), 0);
    vec4 specular = ks * Is * pow(max(dot(h,normalize(normal_in_eye_space)), 0),s);

    color = ambient + diffuse + specular;
}
