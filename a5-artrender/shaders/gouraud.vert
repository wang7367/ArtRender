#version 330

// Gouraud Shader Example

// INPUTS:

// uniform = variables passed in from the C++ code
// model and camera matrices:
uniform mat4 model_view_matrix;
uniform mat4 normal_matrix;
uniform mat4 proj_matrix;

// properties of the light:
uniform vec3 light_in_eye_space;
uniform vec4 Ia, Id, Is;

// properties of the material we are lighting:
uniform vec4 ka, kd, ks;
uniform float s;



// these variables come from the mesh data stored in buffers in gfx card memory
layout(location = 0) in vec3 vertex;
layout(location = 1) in vec3 normal;


// OUTPUT TO SEND TO THE RASTERIZER FOR THIS VERTEX:

// for Gouraud shading, the key output of the vertex shader is the color
// calculated based on lighting this vertex
out vec4 color;

//send the texture;
out vec2 texcoords;

void main() {
    
    // transform the vertex position into "eye space"
    vec3 v = (model_view_matrix * vec4(vertex,1)).xyz;

    // unit vector from the vertex to the light
    vec3 l = normalize(light_in_eye_space - v);
    
    // unit vector from the vertex to the eye point, which is at 0,0,0 in "eye space"
    vec3 e = normalize(vec3(0,0,0) - v);

    // normal transformed into "eye space"
    vec3 n = (normal_matrix * vec4(normal,0)).xyz;
    
    // halfway vector
    vec3 h = normalize(l + e);


	// calculating lighting output the color for this vertex
    // ... 
    vec4 ambient = ka * Ia;
    vec4 diffuse = kd * Id * max(dot(n,l), 0);
    vec4 specular = ks * Is * pow(max(dot(h,n), 0),s);


    color = ambient + diffuse + specular;
       
    // do the standard projection of the incoming vertex
    gl_Position = proj_matrix * model_view_matrix * vec4(vertex,1);

    //output the texture coords as well
    vec3 vertex_on_unit_sphere = normalize(vertex);
    texcoords.s = asin(vertex_on_unit_sphere.x)/3.14+0.5;
    texcoords.t = asin(vertex_on_unit_sphere.y)/3.14+0.5;
}
