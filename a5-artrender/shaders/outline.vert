#version 330

// CSci-4611 Assignment 5:  Art Render

// TODO: You need to modify this vertex shader to move the edge vertex along
// the normal away from the mesh surface IF you determine that the vertex
// belongs to a silhouette edge.


uniform mat4 model_view_matrix;
uniform mat4 normal_matrix;
uniform mat4 proj_matrix;
uniform float thickness;

layout(location = 0) in vec3 vertex;
layout(location = 1) in vec3 normal;
layout(location = 2) in vec3 left_normal;
layout(location = 3) in vec3 right_normal;

void main() {
    vec3 new_vertex = vertex;
    vec3 ln_e=(model_view_matrix * vec4(left_normal,0)).xyz;
    vec3 rn_e=(model_view_matrix * vec4(right_normal,0)).xyz;
    vec3 v = (model_view_matrix * vec4(vertex,1)).xyz;
    vec3 e = normalize(vec3(0,0,0) - v);

    if(dot(e,ln_e) * dot(e,rn_e)<0.0){
       new_vertex = vertex + thickness * normal;
    }

    gl_Position = proj_matrix * model_view_matrix * vec4(new_vertex,1);
}
