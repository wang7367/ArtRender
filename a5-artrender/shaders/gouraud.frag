#version 330

// This color comes in from the output of the vertex shader stage.  The current
// fragment will lie somewhere within a triangle.  So, the vec4 that is passed
// in here is actually an interpolated version of the colors output by the 3
// vertex shader programs run for the 3 vertices of the triangle.
in vec4 color;


in vec2 texcoords;

//this is the variable for the texture we bound in C++
uniform sampler2D surface_tex;


// All fragment shaders are required to output a vec4 color.
out vec4 final_color;


void main() {

    vec4 tex_color = texture(surface_tex, texcoords);


    // For a Gouraud shader, there is nothing more to compute at this stage.  We
    // just output the input color.
    final_color = color;
}
