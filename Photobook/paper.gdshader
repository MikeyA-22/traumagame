shader_type spatial;



uniform sampler2D paper_texture;

void vertex() {
	// Called for every vertex the material is visible on.
	
}

void fragment() {
	// Called for every pixel the material is visible on.
	vec4 texture_color = texture(paper_texture, UV);
	ALBEDO = texture_color.rgb;
	ALPHA =  texture_color.a;
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
